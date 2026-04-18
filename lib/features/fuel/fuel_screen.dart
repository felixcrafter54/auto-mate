import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/providers/database_provider.dart';
import '../../services/database/database.dart';
import '../../services/km_reminder_service.dart';

final _fuelEntriesProvider = StreamProvider.family<List<FuelEntry>, int>(
  (ref, vehicleId) =>
      ref.read(fuelEntriesRepositoryProvider).watchFuelEntriesByVehicle(vehicleId),
);

class FuelScreen extends ConsumerWidget {
  final int vehicleId;
  const FuelScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(_fuelEntriesProvider(vehicleId));
    final vehicleAsync = ref.watch(vehicleStreamProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(title: const Text('Tanken & Verbrauch')),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.local_gas_station),
        label: const Text('Tankfüllung'),
        onPressed: () => _showAddEntry(context, ref, vehicleAsync.valueOrNull),
      ),
      body: entriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
        data: (entries) {
          final vehicle = vehicleAsync.valueOrNull;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              _StatsCard(entries: entries, vehicle: vehicle),
              const SizedBox(height: 16),
              if (entries.isEmpty)
                const _EmptyState()
              else ...[
                Text(
                  'Alle Tankfüllungen',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...entries.map(
                  (e) => _FuelEntryCard(
                    entry: e,
                    prevEntry: entries.length > entries.indexOf(e) + 1
                        ? entries[entries.indexOf(e) + 1]
                        : null,
                    onDelete: () => _delete(context, ref, e),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _showAddEntry(
      BuildContext context, WidgetRef ref, Vehicle? vehicle) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _AddFuelEntrySheet(
        vehicleId: vehicleId,
        currentOdometer: vehicle?.currentMileage ?? 0,
      ),
    );
  }

  Future<void> _delete(
      BuildContext context, WidgetRef ref, FuelEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eintrag löschen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton.tonal(
            style: FilledButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.onErrorContainer,
              backgroundColor: Theme.of(ctx).colorScheme.errorContainer,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(fuelEntriesRepositoryProvider).deleteFuelEntry(entry.id);
  }
}

// ============================================================================
// STATS CARD
// ============================================================================

class _StatsCard extends StatelessWidget {
  final List<FuelEntry> entries;
  final Vehicle? vehicle;
  const _StatsCard({required this.entries, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Need at least 2 entries sorted ascending by odometer for consumption calc
    final sorted = [...entries]..sort((a, b) => a.odometerKm.compareTo(b.odometerKm));

    double? avgConsumption;
    if (sorted.length >= 2) {
      double totalLiters = 0;
      int totalKm = 0;
      for (var i = 1; i < sorted.length; i++) {
        final km = sorted[i].odometerKm - sorted[i - 1].odometerKm;
        if (km > 0) {
          totalLiters += sorted[i].liters;
          totalKm += km;
        }
      }
      if (totalKm > 0) avgConsumption = totalLiters / totalKm * 100;
    }

    int? avgKmPerYear;
    if (sorted.length >= 2) {
      final kmDiff = sorted.last.odometerKm - sorted.first.odometerKm;
      final daysDiff =
          sorted.last.date.difference(sorted.first.date).inDays;
      if (daysDiff > 0) {
        avgKmPerYear = (kmDiff / daysDiff * 365).round();
      }
    }
    avgKmPerYear ??= vehicle?.annualKmEstimate;

    return Card(
      color: cs.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _StatItem(
              icon: Icons.local_gas_station,
              label: 'Ø Verbrauch',
              value: avgConsumption != null
                  ? '${avgConsumption.toStringAsFixed(1)} L/100km'
                  : '—',
            ),
            const VerticalDivider(),
            _StatItem(
              icon: Icons.route,
              label: 'Ø km/Jahr',
              value: avgKmPerYear != null ? _fmt(avgKmPerYear) : '—',
              suffix: avgKmPerYear != null ? ' km' : '',
              isEstimate: avgKmPerYear == vehicle?.annualKmEstimate &&
                  sorted.length < 2,
            ),
            const VerticalDivider(),
            _StatItem(
              icon: Icons.water_drop_outlined,
              label: 'Tankungen',
              value: '${entries.length}',
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(int km) {
    final s = km.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String suffix;
  final bool isEstimate;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    this.suffix = '',
    this.isEstimate = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: cs.onPrimaryContainer, size: 20),
          const SizedBox(height: 4),
          Text(
            '$value$suffix',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            isEstimate ? '$label *' : label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// FUEL ENTRY CARD
// ============================================================================

class _FuelEntryCard extends StatelessWidget {
  final FuelEntry entry;
  final FuelEntry? prevEntry;
  final VoidCallback onDelete;

  const _FuelEntryCard({
    required this.entry,
    required this.prevEntry,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fmt = DateFormat('dd.MM.yyyy', 'de');

    double? consumption;
    if (prevEntry != null) {
      final km = entry.odometerKm - prevEntry!.odometerKm;
      if (km > 0) consumption = entry.liters / km * 100;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cs.secondaryContainer,
          child: Icon(Icons.local_gas_station, color: cs.onSecondaryContainer),
        ),
        title: Text(
          '${entry.liters.toStringAsFixed(1)} L  ·  ${_fmt(entry.odometerKm)} km',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          consumption != null
              ? '${fmt.format(entry.date)}  ·  ${consumption.toStringAsFixed(1)} L/100km'
              : fmt.format(entry.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: cs.error),
          onPressed: onDelete,
        ),
      ),
    );
  }

  String _fmt(int km) {
    final s = km.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

// ============================================================================
// ADD ENTRY BOTTOM SHEET
// ============================================================================

class _AddFuelEntrySheet extends ConsumerStatefulWidget {
  final int vehicleId;
  final int currentOdometer;
  const _AddFuelEntrySheet({
    required this.vehicleId,
    required this.currentOdometer,
  });

  @override
  ConsumerState<_AddFuelEntrySheet> createState() => _AddFuelEntrySheetState();
}

class _AddFuelEntrySheetState extends ConsumerState<_AddFuelEntrySheet> {
  final _litersCtrl = TextEditingController();
  final _odometerCtrl = TextEditingController();
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.currentOdometer > 0) {
      _odometerCtrl.text = '${widget.currentOdometer}';
    }
  }

  @override
  void dispose() {
    _litersCtrl.dispose();
    _odometerCtrl.dispose();
    super.dispose();
  }

  bool get _isValid {
    final liters = double.tryParse(_litersCtrl.text.replaceAll(',', '.'));
    final odometer = int.tryParse(_odometerCtrl.text);
    return liters != null && liters > 0 && odometer != null && odometer > 0;
  }

  Future<void> _save() async {
    if (!_isValid) return;
    setState(() => _saving = true);

    final liters = double.parse(_litersCtrl.text.replaceAll(',', '.'));
    final odometer = int.parse(_odometerCtrl.text);

    await ref.read(fuelEntriesRepositoryProvider).insertFuelEntry(
          FuelEntriesCompanion(
            vehicleId: Value(widget.vehicleId),
            date: Value(_date),
            liters: Value(liters),
            odometerKm: Value(odometer),
          ),
        );

    // Update vehicle mileage if odometer is higher than current
    if (odometer > widget.currentOdometer) {
      await ref
          .read(vehiclesRepositoryProvider)
          .updateMileage(widget.vehicleId, odometer);
      await checkKmReminders(
          ref.read(databaseProvider), widget.vehicleId, odometer);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd.MM.yyyy', 'de');
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tankfüllung eintragen',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Date picker
          OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today, size: 18),
            label: Text(fmt.format(_date)),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => _date = picked);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _litersCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
            ],
            decoration: const InputDecoration(
              labelText: 'Getankte Liter',
              border: OutlineInputBorder(),
              suffixText: 'L',
              prefixIcon: Icon(Icons.water_drop_outlined),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _odometerCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Kilometerstand beim Tanken',
              border: OutlineInputBorder(),
              suffixText: 'km',
              prefixIcon: Icon(Icons.speed),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.check),
              label: Text(_saving ? 'Speichere...' : 'Speichern'),
              onPressed: _isValid && !_saving ? _save : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// EMPTY STATE
// ============================================================================

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48),
          Icon(
            Icons.local_gas_station,
            size: 72,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text('Noch keine Tankfüllungen',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Trage deine erste Tankfüllung ein\num den Verbrauch zu berechnen.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
