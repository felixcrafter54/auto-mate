import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/database_provider.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/info_row.dart';
import '../../services/database/database.dart';

final _consumablesProvider =
    StreamProvider.family<ConsumablesTableData?, int>(
  (ref, vehicleId) => ref
      .read(consumablesRepositoryProvider)
      .watchConsumablesByVehicle(vehicleId),
);

final _vehicleProvider = FutureProvider.family<Vehicle?, int>(
  (ref, id) => ref.read(vehiclesRepositoryProvider).getVehicleById(id),
);

class ConsumablesScreen extends ConsumerWidget {
  final int vehicleId;
  const ConsumablesScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final consumablesAsync = ref.watch(_consumablesProvider(vehicleId));
    final vehicleAsync = ref.watch(_vehicleProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.consumablesTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l.commonEdit,
            onPressed: () => _openEditor(context, ref, consumablesAsync.valueOrNull),
          ),
        ],
      ),
      body: consumablesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonError(e.toString()))),
        data: (data) {
          if (data == null) return EmptyState(
            icon: Icons.oil_barrel_outlined,
            title: l.consumablesEmpty,
            subtitle: l.consumablesEmptyHint,
            action: FilledButton.icon(
              icon: const Icon(Icons.add_rounded),
              label: Text(l.consumablesAddButton),
              onPressed: () => _openEditor(context, ref, null),
            ),
          );
          final vehicle = vehicleAsync.valueOrNull;
          return _Content(data: data, vehicle: vehicle);
        },
      ),
    );
  }

  Future<void> _openEditor(
    BuildContext context,
    WidgetRef ref,
    ConsumablesTableData? existing,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ConsumablesEditorScreen(
          vehicleId: vehicleId,
          existing: existing,
        ),
      ),
    );
  }
}


class _Content extends StatelessWidget {
  final ConsumablesTableData data;
  final Vehicle? vehicle;
  const _Content({required this.data, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          color: cs.primaryContainer.withValues(alpha: 0.35),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: cs.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    vehicle != null
                        ? l.consumablesHintWithVehicle(
                            vehicle!.year, vehicle!.make, vehicle!.model)
                        : l.consumablesHintGeneral,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                InfoRow(icon: Icons.oil_barrel, label: l.consumablesEngineOil, value: data.engineOilGrade),
                const Divider(height: 1),
                InfoRow(icon: Icons.water_drop, label: l.consumablesOilVolume, value: '${data.engineOilVolume.toStringAsFixed(1)} l'),
                const Divider(height: 1),
                InfoRow(icon: Icons.local_drink, label: l.consumablesCoolant, value: data.coolantType),
                const Divider(height: 1),
                InfoRow(icon: Icons.opacity, label: l.consumablesBrakeFluid, value: data.brakeFluidSpec),
                const Divider(height: 1),
                InfoRow(icon: Icons.settings, label: l.consumablesTransmissionFluid, value: data.transmissionFluid),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          icon: const Icon(Icons.copy_all_outlined),
          label: Text(l.consumablesCopyAll),
          onPressed: () => _copyAll(context, l),
        ),
      ],
    );
  }

  String _buildTextPayload(AppLocalizations l) {
    final v = vehicle;
    final header = v != null
        ? '${v.year} ${v.make} ${v.model}'
        : l.consumablesTitle;
    return [
      l.consumablesCopyHeader(header),
      l.consumablesCopyOilGrade(data.engineOilGrade),
      l.consumablesCopyOilVolume(data.engineOilVolume.toStringAsFixed(1)),
      l.consumablesCopyCoolant(data.coolantType),
      l.consumablesCopyBrakeFluid(data.brakeFluidSpec),
      l.consumablesCopyTransFluid(data.transmissionFluid),
    ].join('\n');
  }

  Future<void> _copyAll(BuildContext context, AppLocalizations l) async {
    await Clipboard.setData(ClipboardData(text: _buildTextPayload(l)));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.consumablesCopied)),
    );
  }
}


// ============================================================================
// EDITOR
// ============================================================================

class ConsumablesEditorScreen extends ConsumerStatefulWidget {
  final int vehicleId;
  final ConsumablesTableData? existing;
  const ConsumablesEditorScreen({
    super.key,
    required this.vehicleId,
    this.existing,
  });

  @override
  ConsumerState<ConsumablesEditorScreen> createState() =>
      _ConsumablesEditorScreenState();
}

class _ConsumablesEditorScreenState
    extends ConsumerState<ConsumablesEditorScreen> {
  late final TextEditingController _oil;
  late final TextEditingController _oilVol;
  late final TextEditingController _coolant;
  late final TextEditingController _brake;
  late final TextEditingController _trans;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _oil = TextEditingController(text: e?.engineOilGrade ?? '5W-30');
    _oilVol = TextEditingController(
        text: e != null ? e.engineOilVolume.toStringAsFixed(1) : '4.5');
    _coolant = TextEditingController(text: e?.coolantType ?? 'G12++');
    _brake = TextEditingController(text: e?.brakeFluidSpec ?? 'DOT 4');
    _trans = TextEditingController(text: e?.transmissionFluid ?? 'ATF 3+');
  }

  @override
  void dispose() {
    _oil.dispose();
    _oilVol.dispose();
    _coolant.dispose();
    _brake.dispose();
    _trans.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final repo = ref.read(consumablesRepositoryProvider);
    final now = DateTime.now();

    final companion = ConsumablesTableCompanion(
      id: widget.existing != null ? Value(widget.existing!.id) : const Value.absent(),
      vehicleId: Value(widget.vehicleId),
      engineOilGrade: Value(_oil.text.trim()),
      engineOilVolume: Value(double.tryParse(_oilVol.text.replaceAll(',', '.')) ?? 0),
      coolantType: Value(_coolant.text.trim()),
      brakeFluidSpec: Value(_brake.text.trim()),
      transmissionFluid: Value(_trans.text.trim()),
      createdAt: Value(widget.existing?.createdAt ?? now),
      updatedAt: Value(now),
    );

    if (widget.existing == null) {
      await repo.insertConsumables(companion);
    } else {
      await repo.updateConsumables(companion);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing == null
            ? l.consumablesCreateTitle
            : l.consumablesEditTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _Field(
            controller: _oil,
            label: l.consumablesOilGradeLabel,
            hint: l.consumablesOilGradePlaceholder,
            icon: Icons.oil_barrel,
          ),
          _Field(
            controller: _oilVol,
            label: l.consumablesOilVolumeLabel,
            hint: l.consumablesOilVolumePlaceholder,
            icon: Icons.water_drop,
            numeric: true,
          ),
          _Field(
            controller: _coolant,
            label: l.consumablesCoolantLabel,
            hint: l.consumablesCoolantPlaceholder,
            icon: Icons.local_drink,
          ),
          _Field(
            controller: _brake,
            label: l.consumablesBrakeFluidLabel,
            hint: l.consumablesBrakeFluidPlaceholder,
            icon: Icons.opacity,
          ),
          _Field(
            controller: _trans,
            label: l.consumablesTransFluidLabel,
            hint: l.consumablesTransFluidPlaceholder,
            icon: Icons.settings,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: _saving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            label: Text(_saving ? l.commonSaving : l.commonSave),
            onPressed: _saving ? null : _save,
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool numeric;

  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.numeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: numeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
