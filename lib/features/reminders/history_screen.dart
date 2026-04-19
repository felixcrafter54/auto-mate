import 'package:auto_mate/l10n/app_localizations.dart';
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
    final l = AppLocalizations.of(context);
    final historyAsync = ref.watch(_historyProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(title: Text(l.historyTitle)),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonError(e.toString()))),
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
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final lCtx = AppLocalizations.of(ctx);
        return AlertDialog(
          title: Text(lCtx.historyDeleteTitle),
          content: Text(lCtx.historyDeleteBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(lCtx.commonCancel),
            ),
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                foregroundColor: Theme.of(ctx).colorScheme.onErrorContainer,
                backgroundColor: Theme.of(ctx).colorScheme.errorContainer,
              ),
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(lCtx.commonDelete),
            ),
          ],
        );
      },
    );
    if (confirmed != true) return;
    await ref
        .read(maintenanceHistoryRepositoryProvider)
        .deleteEntry(entry.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.historyDeleted)),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 72, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text(l.historyEmpty, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              l.historyEmptyHint,
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
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final type = ReminderType.fromString(entry.type);
    final fmt = DateFormat('dd.MM.yyyy');

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
                    reminderLabel(l, type, customLabel: entry.customLabel),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(l.historyCompletedOn(fmt.format(entry.completedDate))),
                  Text(
                    l.historyMileageAt(_km(entry.mileageAtCompletion)),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (entry.workshopName != null)
                    Text(
                      l.historyWorkshop(entry.workshopName!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  if (entry.cost != null)
                    Text(
                      l.historyCost(entry.cost!.toStringAsFixed(2)),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: cs.error),
              tooltip: l.commonDelete,
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
