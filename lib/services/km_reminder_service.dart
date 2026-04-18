import '../core/l10n/reminder_labels.dart';
import '../services/database/database.dart';
import '../services/models/enums.dart';
import '../services/notification_service.dart';

/// Checks km-based reminders after a mileage update and fires notifications
/// for any threshold that has been crossed.
Future<void> checkKmReminders(
  AppDatabase db,
  int vehicleId,
  int newMileage,
) async {
  final reminders = await db.getKmRemindersToCheck(vehicleId);
  if (reminders.isEmpty) return;

  final svc = NotificationService();
  for (final r in reminders) {
    final offsetKm = r.notifyOffsetKm ?? 0;
    final threshold = r.dueMileage! - offsetKm;
    if (newMileage < threshold) continue;

    final label = reminderLabel(
      ReminderType.fromString(r.type),
      customLabel: r.customLabel,
    );

    final kmLeft = r.dueMileage! - newMileage;
    final body = kmLeft <= 0
        ? 'Wartung fällig! Kilometerstand erreicht.'
        : 'Noch $kmLeft km bis zur Fälligkeit.';

    await svc.showNow(
      id: r.id * 100 + 99,
      title: 'AutoMate · $label',
      body: body,
    );
    await db.markReminderNotified(r.id);
  }
}
