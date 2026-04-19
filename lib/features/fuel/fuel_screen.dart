import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/l10n/fuel_labels.dart';
import '../../core/providers/database_provider.dart';
import '../../services/database/database.dart';
import '../../services/km_reminder_service.dart';
import '../../services/models/enums.dart';

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

    final vehicle = vehicleAsync.valueOrNull;
    final fuelType =
        vehicle != null ? FuelType.fromString(vehicle.fuelType) : null;

    // Guard: only fossil-fuel vehicles
    if (fuelType != null && !fuelType.supportsFuelLog) {
      return Scaffold(
        appBar: AppBar(title: const Text(fuelScreenTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.electric_bolt,
                    size: 72,
                    color: Theme.of(context).colorScheme.outline),
                const SizedBox(height: 16),
                Text(
                  fuelScreenNotAvailableTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  fuelScreenNotAvailableBody,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text(fuelScreenTitle)),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.local_gas_station),
        label: const Text(fuelScreenAddButton),
        onPressed: () => _showAddEntry(context, ref, vehicle, fuelType),
      ),
      body: entriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
        data: (entries) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              _StatsCard(entries: entries, vehicle: vehicle),
              const SizedBox(height: 16),
              if (entries.isEmpty)
                const _EmptyState()
              else ...[
                Text(
                  fuelScreenAllEntries,
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
    BuildContext context,
    WidgetRef ref,
    Vehicle? vehicle,
    FuelType? fuelType,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _AddFuelEntrySheet(
        vehicleId: vehicleId,
        currentOdometer: vehicle?.currentMileage ?? 0,
        fuelType: fuelType ?? FuelType.petrol,
      ),
    );
  }

  Future<void> _delete(
      BuildContext context, WidgetRef ref, FuelEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(fuelScreenDeleteTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(fuelScreenDeleteCancel),
          ),
          FilledButton.tonal(
            style: FilledButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.onErrorContainer,
              backgroundColor: Theme.of(ctx).colorScheme.errorContainer,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(fuelScreenDeleteConfirm),
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

    final sorted = [...entries]
      ..sort((a, b) => a.odometerKm.compareTo(b.odometerKm));

    // Use only full-tank entries for consumption if available, else all entries
    final fullTankEntries = sorted.where((e) => e.fullTank).toList();
    final calcEntries = fullTankEntries.length >= 2 ? fullTankEntries : sorted;

    double? avgConsumption;
    if (calcEntries.length >= 2) {
      double totalLiters = 0;
      int totalKm = 0;
      for (var i = 1; i < calcEntries.length; i++) {
        final km = calcEntries[i].odometerKm - calcEntries[i - 1].odometerKm;
        if (km > 0) {
          totalLiters += calcEntries[i].liters;
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

    // Total cost
    double? totalCost;
    final withPrice = entries.where((e) => e.pricePerLiter != null).toList();
    if (withPrice.isNotEmpty) {
      totalCost = withPrice.fold<double>(
          0.0, (sum, e) => sum + e.liters * (e.pricePerLiter ?? 0));
    }

    return Card(
      color: cs.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _StatItem(
              icon: Icons.local_gas_station,
              label: fuelScreenStatConsumption,
              value: avgConsumption != null
                  ? '${avgConsumption.toStringAsFixed(1)} L/100km'
                  : '—',
            ),
            const VerticalDivider(),
            _StatItem(
              icon: Icons.route,
              label: fuelScreenStatKmPerYear,
              value: avgKmPerYear != null ? _fmt(avgKmPerYear) : '—',
              suffix: avgKmPerYear != null ? ' km' : '',
              isEstimate: avgKmPerYear == vehicle?.annualKmEstimate &&
                  sorted.length < 2,
            ),
            const VerticalDivider(),
            _StatItem(
              icon: Icons.euro,
              label: fuelScreenStatTotalCost,
              value: totalCost != null
                  ? '${totalCost.toStringAsFixed(0)} €'
                  : '—',
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
    if (prevEntry != null && entry.fullTank) {
      final km = entry.odometerKm - prevEntry!.odometerKm;
      if (km > 0) consumption = entry.liters / km * 100;
    } else if (prevEntry != null && !entry.fullTank) {
      final km = entry.odometerKm - prevEntry!.odometerKm;
      if (km > 0) consumption = entry.liters / km * 100;
    }

    final grade = entry.fuelGrade != null
        ? fuelGradeLabel(FuelGrade.fromString(entry.fuelGrade!))
        : null;
    final totalCost = entry.pricePerLiter != null
        ? entry.liters * entry.pricePerLiter!
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              entry.fullTank ? cs.primaryContainer : cs.secondaryContainer,
          child: Icon(
            entry.fullTank ? Icons.local_gas_station : Icons.water_drop,
            color: entry.fullTank
                ? cs.onPrimaryContainer
                : cs.onSecondaryContainer,
          ),
        ),
        title: Text(
          '${entry.liters.toStringAsFixed(2)} L  ·  ${_fmt(entry.odometerKm)} km',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              [
                fmt.format(entry.date),
                if (consumption != null)
                  '${consumption.toStringAsFixed(1)} L/100km',
                ?grade,
              ].join('  ·  '),
            ),
            if (totalCost != null || entry.pricePerLiter != null)
              Text(
                [
                  if (totalCost != null)
                    '${totalCost.toStringAsFixed(2)} €',
                  if (entry.pricePerLiter != null)
                    '${entry.pricePerLiter!.toStringAsFixed(3)} €/L',
                ].join('  ·  '),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: cs.primary,
                    ),
              ),
          ],
        ),
        isThreeLine: totalCost != null || entry.pricePerLiter != null,
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
  final FuelType fuelType;

  const _AddFuelEntrySheet({
    required this.vehicleId,
    required this.currentOdometer,
    required this.fuelType,
  });

  @override
  ConsumerState<_AddFuelEntrySheet> createState() => _AddFuelEntrySheetState();
}

class _AddFuelEntrySheetState extends ConsumerState<_AddFuelEntrySheet> {
  final _litersCtrl = TextEditingController();
  final _odometerCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  DateTime _date = DateTime.now();
  FuelGrade? _grade;
  bool _fullTank = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.currentOdometer > 0) {
      _odometerCtrl.text = '${widget.currentOdometer}';
    }
    final grades = widget.fuelType.applicableGrades;
    if (grades.isNotEmpty) _grade = grades.first;
  }

  @override
  void dispose() {
    _litersCtrl.dispose();
    _odometerCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  bool get _isValid {
    final liters = double.tryParse(_litersCtrl.text.replaceAll(',', '.'));
    final odometer = int.tryParse(_odometerCtrl.text);
    return liters != null && liters > 0 && odometer != null && odometer > 0;
  }

  String? get _calcPricePerLiter {
    final liters = double.tryParse(_litersCtrl.text.replaceAll(',', '.'));
    final total = double.tryParse(_priceCtrl.text.replaceAll(',', '.'));
    if (liters == null || liters <= 0 || total == null) return null;
    return '= ${(total / liters).toStringAsFixed(3)} €/L';
  }

  Future<void> _save() async {
    if (!_isValid) return;
    setState(() => _saving = true);

    final liters = double.parse(_litersCtrl.text.replaceAll(',', '.'));
    final odometer = int.parse(_odometerCtrl.text);
    final totalPrice = double.tryParse(_priceCtrl.text.replaceAll(',', '.'));
    final pricePerLiter =
        (totalPrice != null && liters > 0) ? totalPrice / liters : null;

    await ref.read(fuelEntriesRepositoryProvider).insertFuelEntry(
          FuelEntriesCompanion(
            vehicleId: Value(widget.vehicleId),
            date: Value(_date),
            liters: Value(liters),
            odometerKm: Value(odometer),
            fuelGrade: Value(_grade?.value),
            pricePerLiter: Value(pricePerLiter),
            fullTank: Value(_fullTank),
          ),
        );

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
    final grades = widget.fuelType.applicableGrades;

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
            fuelSheetTitle,
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
          // Fuel grade
          InputDecorator(
            decoration: const InputDecoration(
              labelText: fuelSheetFieldGrade,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.local_gas_station),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<FuelGrade>(
                value: _grade,
                isExpanded: true,
                items: grades
                    .map((g) => DropdownMenuItem(
                          value: g,
                          child: Text(fuelGradeLabel(g)),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _grade = v),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _litersCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: fuelSheetFieldLiters,
                    border: OutlineInputBorder(),
                    suffixText: 'L',
                    prefixIcon: Icon(Icons.water_drop_outlined),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _priceCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                  ],
                  decoration: InputDecoration(
                    labelText: fuelSheetFieldTotalPrice,
                    border: const OutlineInputBorder(),
                    suffixText: '€',
                    prefixIcon: const Icon(Icons.euro),
                    helperText: _calcPricePerLiter,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _odometerCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: fuelSheetFieldOdometer,
              border: OutlineInputBorder(),
              suffixText: 'km',
              prefixIcon: Icon(Icons.speed),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 4),
          // Full tank toggle
          SwitchListTile(
            value: _fullTank,
            onChanged: (v) => setState(() => _fullTank = v),
            title: const Text(fuelSheetFullTankLabel),
            subtitle: const Text(fuelSheetFullTankHint),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
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
              label: Text(_saving ? fuelSheetSaving : fuelSheetSave),
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
          Text(fuelScreenEmptyTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            fuelScreenEmptyBody,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
