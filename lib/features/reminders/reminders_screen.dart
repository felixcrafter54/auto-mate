import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' show Value;
import '../../core/l10n/reminder_labels.dart';
import '../../core/providers/database_provider.dart';
import '../../services/database/database.dart';

import '../../services/models/enums.dart';
import '../../services/notification_service.dart';

final _remindersProvider = StreamProvider.family<List<Reminder>, int>(
  (ref, vehicleId) =>
      ref.read(remindersRepositoryProvider).watchRemindersByVehicle(vehicleId),
);


class RemindersScreen extends ConsumerWidget {
  final int vehicleId;
  const RemindersScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(_remindersProvider(vehicleId));
    final vehicleAsync = ref.watch(vehicleStreamProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Erinnerungen'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Neu'),
        onPressed: () => context.push('/vehicle/$vehicleId/reminders/add'),
      ),
      body: remindersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
        data: (reminders) {
          final sorted = [...reminders]
            ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
          if (sorted.isEmpty) return const _EmptyState();

          final currentMileage = vehicleAsync.valueOrNull?.currentMileage ?? 0;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: sorted.length,
            itemBuilder: (context, i) => _ReminderCard(
              reminder: sorted[i],
              currentMileage: currentMileage,
              onDone: () => _markDone(context, ref, sorted[i], currentMileage),
              onDelete: () => _delete(context, ref, sorted[i]),
            ),
          );
        },
      ),
    );
  }

  Future<void> _markDone(
    BuildContext context,
    WidgetRef ref,
    Reminder reminder,
    int currentMileage,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erledigt markieren'),
        content: Text(
          'Möchtest du die Erinnerung "${_typeLabel(reminder)}" '
          'als erledigt markieren?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Erledigt'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final db = ref.read(databaseProvider);

    // Delete first — if the reminder row is gone we know the user can't
    // double-tap and end up with duplicate history entries.
    final deleted =
        await (db.delete(db.reminders)..where((r) => r.id.equals(reminder.id)))
            .go();
    if (deleted == 0) return; // already handled elsewhere

    // Best-effort cancel of any scheduled alarms (up to 20 offsets per reminder).
    for (var i = 0; i < 20; i++) {
      await NotificationService().cancel(reminder.id * 100 + i);
    }

    await ref.read(maintenanceHistoryRepositoryProvider).insertMaintenanceHistory(
          MaintenanceHistoryTableCompanion.insert(
            vehicleId: reminder.vehicleId,
            type: reminder.type,
            customLabel: Value(reminder.customLabel),
            completedDate: DateTime.now(),
            mileageAtCompletion: currentMileage,
          ),
        );

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Als erledigt markiert')),
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Reminder reminder,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erinnerung löschen?'),
        content: Text(
          'Die Erinnerung "${_typeLabel(reminder)}" und alle zugehörigen '
          'Benachrichtigungen werden entfernt.',
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

    final db = ref.read(databaseProvider);
    final deleted =
        await (db.delete(db.reminders)..where((r) => r.id.equals(reminder.id)))
            .go();
    if (deleted == 0) return;

    for (var i = 0; i < 20; i++) {
      await NotificationService().cancel(reminder.id * 100 + i);
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erinnerung gelöscht')),
    );
  }

  String _typeLabel(Reminder r) =>
      reminderLabel(ReminderType.fromString(r.type), customLabel: r.customLabel);
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 72,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text('Keine Erinnerungen',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Lege eine Erinnerung für Ölwechsel, TÜV und Co. an.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final int currentMileage;
  final VoidCallback onDone;
  final VoidCallback onDelete;

  const _ReminderCard({
    required this.reminder,
    required this.currentMileage,
    required this.onDone,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = ReminderType.fromString(reminder.type);
    final now = DateTime.now();
    // Calendar-day difference (ignore time-of-day).
    final today = DateTime(now.year, now.month, now.day);
    final due =
        DateTime(reminder.dueDate.year, reminder.dueDate.month, reminder.dueDate.day);
    final daysLeft = due.difference(today).inDays;
    final overdue = daysLeft < 0;
    final soon = daysLeft >= 0 && daysLeft <= 14;
    final label = reminderLabel(type, customLabel: reminder.customLabel);

    final statusColor = overdue
        ? cs.error
        : soon
            ? cs.tertiary
            : cs.primary;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: statusColor.withValues(alpha: 0.15),
              child: Icon(_typeIcon(type), color: statusColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(
                    _dateLabel(reminder.dueDate, daysLeft, overdue),
                    style: TextStyle(color: statusColor),
                  ),
                  if (reminder.dueMileage != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      _kmLabel(reminder, currentMileage),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: _kmColor(reminder, currentMileage, cs),
                          ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.check_circle_outline),
              tooltip: 'Erledigt',
              onPressed: onDone,
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

  String _kmLabel(Reminder r, int currentKm) {
    final due = r.dueMileage!;
    final offset = r.notifyOffsetKm ?? 0;
    final kmLeft = due - currentKm;
    if (kmLeft <= 0) return 'Km-Fälligkeit erreicht! (${_formatKm(due)} km)';
    final base = 'Bei ${_formatKm(due)} km · noch $kmLeft km (jetzt ${_formatKm(currentKm)} km)';
    return offset > 0 ? '$base · Warnung ab ${_formatKm(due - offset)} km' : base;
  }

  Color _kmColor(Reminder r, int currentKm, ColorScheme cs) {
    final due = r.dueMileage!;
    final offset = r.notifyOffsetKm ?? 0;
    final kmLeft = due - currentKm;
    if (kmLeft <= 0) return cs.error;
    if (kmLeft <= offset || kmLeft <= 1000) return cs.tertiary;
    return cs.outline;
  }

  String _dateLabel(DateTime due, int daysLeft, bool overdue) {
    final fmt = DateFormat('dd.MM.yyyy', 'de');
    if (overdue) return '${fmt.format(due)} · ${-daysLeft} Tage überfällig';
    if (daysLeft == 0) return 'Heute fällig!';
    if (daysLeft == 1) return 'Morgen fällig';
    if (daysLeft < 14) return 'In $daysLeft Tagen · ${fmt.format(due)}';
    final weeks = (daysLeft / 7).round();
    if (weeks < 9) return 'In $weeks Wochen · ${fmt.format(due)}';
    return fmt.format(due);
  }

  IconData _typeIcon(ReminderType t) => switch (t) {
        ReminderType.oilChange => Icons.oil_barrel,
        ReminderType.tuev => Icons.verified_outlined,
        ReminderType.majorService => Icons.build,
        ReminderType.minorService => Icons.build_outlined,
        ReminderType.tyreSwap => Icons.tire_repair,
        ReminderType.custom => Icons.notifications_active_outlined,
      };

  String _formatKm(int km) {
    final s = km.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
