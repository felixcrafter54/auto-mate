import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/l10n/reminder_labels.dart';
import '../../core/providers/database_provider.dart';
import '../../services/database/database.dart';
import '../../services/models/enums.dart';

final _historyProvider =
    StreamProvider.family<List<MaintenanceHistoryTableData>, int>(
  (ref, vehicleId) =>
      ref.read(maintenanceHistoryRepositoryProvider).watchMaintenanceHistory(vehicleId),
);

class HistoryScreen extends ConsumerWidget {
  final int vehicleId;
  const HistoryScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(_historyProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(title: const Text('Wartungshistorie')),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
        data: (list) {
          if (list.isEmpty) return const _Empty();
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, i) => _HistoryCard(
              entry: list[i],
              onDelete: () => _delete(context, ref, list[i]),
            ),
          );
        },
      ),
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    MaintenanceHistoryTableData entry,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eintrag löschen?'),
        content: const Text(
          'Der Eintrag wird dauerhaft aus der Historie entfernt.',
        ),
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
    await ref
        .read(maintenanceHistoryRepositoryProvider)
        .deleteEntry(entry.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Eintrag gelöscht')),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 72, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text('Noch keine Historie',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Sobald du eine Erinnerung als erledigt markierst, '
              'landet sie hier.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final MaintenanceHistoryTableData entry;
  final VoidCallback onDelete;
  const _HistoryCard({required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = ReminderType.fromString(entry.type);
    final fmt = DateFormat('dd.MM.yyyy', 'de');

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 6, 14),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: cs.primaryContainer,
              child: Icon(_icon(type), color: cs.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminderLabel(type, customLabel: entry.customLabel),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text('Erledigt am ${fmt.format(entry.completedDate)}'),
                  Text('Kilometerstand: ${_km(entry.mileageAtCompletion)} km',
                      style: Theme.of(context).textTheme.bodySmall),
                  if (entry.workshopName != null)
                    Text('Werkstatt: ${entry.workshopName}',
                        style: Theme.of(context).textTheme.bodySmall),
                  if (entry.cost != null)
                    Text('Kosten: ${entry.cost!.toStringAsFixed(2)} €',
                        style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: cs.error),
              tooltip: 'Löschen',
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  IconData _icon(ReminderType t) => switch (t) {
        ReminderType.oilChange => Icons.oil_barrel,
        ReminderType.tuev => Icons.verified_outlined,
        ReminderType.majorService => Icons.build,
        ReminderType.minorService => Icons.build_outlined,
        ReminderType.tyreSwap => Icons.tire_repair,
        ReminderType.custom => Icons.notifications_active_outlined,
      };

  String _km(int km) {
    final s = km.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
