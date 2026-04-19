import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../core/providers/database_provider.dart';
import '../../services/gemini_service.dart';
import '../../services/database/database.dart';
import '../../services/models/enums.dart';
import '../../services/settings_service.dart';

final _vehicleProvider = FutureProvider.family<Vehicle?, int>(
  (ref, id) => ref.read(vehiclesRepositoryProvider).getVehicleById(id),
);

class WorkshopReportScreen extends ConsumerStatefulWidget {
  final int vehicleId;
  const WorkshopReportScreen({super.key, required this.vehicleId});

  @override
  ConsumerState<WorkshopReportScreen> createState() =>
      _WorkshopReportScreenState();
}

class _WorkshopReportScreenState extends ConsumerState<WorkshopReportScreen> {
  final _symptomCtrl = TextEditingController();
  String? _report;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _symptomCtrl.dispose();
    super.dispose();
  }

  Future<void> _generate(Vehicle vehicle) async {
    if (_symptomCtrl.text.trim().isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
      _report = null;
    });

    try {
      final language = await ref.read(settingsServiceProvider).getReportLanguage();
      final service = ref.read(geminiServiceProvider);
      final systemPrompt = service.buildWorkshopReportPrompt(
        make: vehicle.make,
        model: vehicle.model,
        year: vehicle.year,
        fuelType: FuelType.fromString(vehicle.fuelType),
        language: language,
      );

      final report = await service.complete(
        systemPrompt: systemPrompt,
        messages: [
          GeminiMessage(role: 'user', content: _symptomCtrl.text.trim()),
        ],
        maxTokens: 1500,
      );

      if (!mounted) return;
      setState(() {
        _report = report;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _share(Vehicle vehicle, AppLocalizations l) async {
    if (_report == null) return;
    final doc = pw.Document();
    final vehicleLine = '${vehicle.year} ${vehicle.make} ${vehicle.model}';
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (context) => [
          pw.Text(l.workshopPdfTitle,
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Text(vehicleLine,
              style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
          pw.Divider(),
          pw.SizedBox(height: 10),
          pw.Text(l.workshopPdfSymptomsLabel,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Text(_symptomCtrl.text.trim()),
          pw.SizedBox(height: 14),
          pw.Text(l.workshopPdfAnalysisLabel,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Text(_report!),
          pw.SizedBox(height: 20),
          pw.Text(
            l.workshopPdfFooter,
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
        ],
      ),
    );
    await Printing.sharePdf(
      bytes: await doc.save(),
      filename: l.workshopPdfFilename(vehicle.make, vehicle.model),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final vehicleAsync = ref.watch(_vehicleProvider(widget.vehicleId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.workshopTitle),
        actions: [
          if (_report != null)
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: l.workshopSharePdf,
              onPressed: () {
                final v = vehicleAsync.valueOrNull;
                if (v != null) _share(v, l);
              },
            ),
        ],
      ),
      body: vehicleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonError(e.toString()))),
        data: (vehicle) {
          if (vehicle == null) return Center(child: Text(l.workshopNoVehicle));
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Icon(Icons.description,
                          color: Theme.of(context).colorScheme.onPrimaryContainer),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l.workshopDescription,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _symptomCtrl,
                minLines: 3,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: l.workshopSymptomsLabel,
                  hintText: l.workshopSymptomsPlaceholder,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: _loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.auto_awesome),
                  label: Text(_loading ? l.workshopAnalyzing : l.workshopGenerateButton),
                  onPressed: _loading ? null : () => _generate(vehicle),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      _error!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer),
                    ),
                  ),
                ),
              ],
              if (_report != null) ...[
                const SizedBox(height: 24),
                Text(l.workshopAnalysisTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SelectableText(_report!),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.picture_as_pdf),
                  label: Text(l.workshopSharePdf),
                  onPressed: () => _share(vehicle, l),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
