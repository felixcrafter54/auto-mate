import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/database_provider.dart';
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
    final consumablesAsync = ref.watch(_consumablesProvider(vehicleId));
    final vehicleAsync = ref.watch(_vehicleProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verbrauchsmaterial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Bearbeiten',
            onPressed: () => _openEditor(
              context,
              ref,
              consumablesAsync.valueOrNull,
            ),
          ),
        ],
      ),
      body: consumablesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
        data: (data) {
          if (data == null) return _Empty(onAdd: () => _openEditor(context, ref, null));
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

class _Empty extends StatelessWidget {
  final VoidCallback onAdd;
  const _Empty({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.oil_barrel_outlined,
            size: 72,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text('Noch keine Specs',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Hinterlege Öl-, Kühlmittel- und Bremsflüssigkeits-Specs deines '
              'Autos, damit du sie beim Werkstattbesuch parat hast.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Specs hinzufügen'),
            onPressed: onAdd,
          ),
        ],
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
                        ? 'Specs für ${vehicle!.year} ${vehicle!.make} ${vehicle!.model} — tippe auf „Kopieren", um sie an die Werkstatt zu schicken.'
                        : 'Specs für die Werkstatt — tippe auf „Kopieren", um sie weiterzugeben.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _SpecRow(icon: Icons.oil_barrel, label: 'Motoröl', value: data.engineOilGrade),
        _SpecRow(
          icon: Icons.water_drop,
          label: 'Öl-Füllmenge',
          value: '${data.engineOilVolume.toStringAsFixed(1)} l',
        ),
        _SpecRow(
          icon: Icons.local_drink,
          label: 'Kühlmittel',
          value: data.coolantType,
        ),
        _SpecRow(
          icon: Icons.opacity,
          label: 'Bremsflüssigkeit',
          value: data.brakeFluidSpec,
        ),
        _SpecRow(
          icon: Icons.settings,
          label: 'Getriebeöl',
          value: data.transmissionFluid,
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          icon: const Icon(Icons.copy_all_outlined),
          label: const Text('Alle Specs kopieren'),
          onPressed: () => _copyAll(context),
        ),
      ],
    );
  }

  String _buildTextPayload() {
    final v = vehicle;
    final header = v != null ? '${v.year} ${v.make} ${v.model}' : 'Fahrzeug';
    return '''AutoMate – $header
Motoröl: ${data.engineOilGrade}
Öl-Füllmenge: ${data.engineOilVolume.toStringAsFixed(1)} l
Kühlmittel: ${data.coolantType}
Bremsflüssigkeit: ${data.brakeFluidSpec}
Getriebeöl: ${data.transmissionFluid}''';
  }

  Future<void> _copyAll(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _buildTextPayload()));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Specs in die Zwischenablage kopiert')),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _SpecRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: cs.surfaceContainerHighest,
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: cs.primary),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, color: cs.primary),
        ),
      ),
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.existing == null ? 'Specs anlegen' : 'Specs bearbeiten')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _Field(
            controller: _oil,
            label: 'Motoröl-Viskosität',
            hint: 'z. B. 5W-30',
            icon: Icons.oil_barrel,
          ),
          _Field(
            controller: _oilVol,
            label: 'Öl-Füllmenge (Liter)',
            hint: 'z. B. 4.5',
            icon: Icons.water_drop,
            numeric: true,
          ),
          _Field(
            controller: _coolant,
            label: 'Kühlmittel',
            hint: 'z. B. G12++',
            icon: Icons.local_drink,
          ),
          _Field(
            controller: _brake,
            label: 'Bremsflüssigkeit',
            hint: 'z. B. DOT 4',
            icon: Icons.opacity,
          ),
          _Field(
            controller: _trans,
            label: 'Getriebeöl',
            hint: 'z. B. ATF 3+',
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
            label: Text(_saving ? 'Speichere ...' : 'Speichern'),
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
