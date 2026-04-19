import 'package:auto_mate/l10n/app_localizations.dart';
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
    final l = AppLocalizations.of(context);
    final remindersAsync = ref.watch(_remindersProvider(vehicleId));
    final vehicleAsync = ref.watch(vehicleStreamProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.remindersTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(l.remindersNew),
        onPressed: () => context.push('/vehicle/$vehicleId/reminders/add'),
      ),
      body: remindersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonError(e.toString()))),
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
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final lCtx = AppLocalizations.of(ctx);
        final label = reminderLabel(lCtx, ReminderType.fromString(reminder.type), customLabel: reminder.customLabel);
        return AlertDialog(
          title: Text(lCtx.remindersMarkDone),
          content: Text(lCtx.remindersMarkDoneConfirm(label)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(lCtx.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(lCtx.remindersMarkDone),
            ),
          ],
        );
      },
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
      SnackBar(content: Text(l.remindersMarkedDone)),
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Reminder reminder,
  ) async {
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final lCtx = AppLocalizations.of(ctx);
        final label = reminderLabel(lCtx, ReminderType.fromString(reminder.type), customLabel: reminder.customLabel);
        return AlertDialog(
          title: Text(lCtx.remindersDeleteTitle),
          content: Text(lCtx.remindersDeleteBody(label)),
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
      SnackBar(content: Text(l.remindersDeleted)),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
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
          Text(l.remindersEmpty,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            l.remindersEmptyHint,
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
    final l = AppLocalizations.of(context);
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
    final label = reminderLabel(l, type, customLabel: reminder.customLabel);

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
                    _dateLabel(l, reminder.dueDate, daysLeft, overdue),
                    style: TextStyle(color: statusColor),
                  ),
                  if (reminder.dueMileage != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      _kmLabel(l, reminder, currentMileage),
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
              tooltip: l.remindersMarkDone,
              onPressed: onDone,
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

  String _kmLabel(AppLocalizations l, Reminder r, int currentKm) {
    final due = r.dueMileage!;
    final offset = r.notifyOffsetKm ?? 0;
    final kmLeft = due - currentKm;
    if (kmLeft <= 0) return l.remindersKmOverdue(_formatKm(due));
    final base = l.remindersKmDueAt(_formatKm(due), kmLeft.toString(), _formatKm(currentKm));
    return offset > 0 ? l.remindersKmWithWarning(base, _formatKm(due - offset)) : base;
  }

  Color _kmColor(Reminder r, int currentKm, ColorScheme cs) {
    final due = r.dueMileage!;
    final offset = r.notifyOffsetKm ?? 0;
    final kmLeft = due - currentKm;
    if (kmLeft <= 0) return cs.error;
    if (kmLeft <= offset || kmLeft <= 1000) return cs.tertiary;
    return cs.outline;
  }

  String _dateLabel(AppLocalizations l, DateTime due, int daysLeft, bool overdue) {
    final fmt = DateFormat('dd.MM.yyyy');
    if (overdue) return l.remindersOverdue(-daysLeft);
    if (daysLeft == 0) return l.remindersDueToday;
    if (daysLeft == 1) return l.remindersDueTomorrow;
    if (daysLeft < 14) return l.remindersDueInDays(daysLeft, fmt.format(due));
    final weeks = (daysLeft / 7).round();
    if (weeks < 9) return l.remindersDueInWeeks(weeks, fmt.format(due));
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
