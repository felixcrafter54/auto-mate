import '../../services/models/enums.dart';

/// Returns the localized display name for a ReminderType.
/// Replace this with proper AppLocalizations calls when multilingual is added.
String reminderLabel(ReminderType type, {String? customLabel}) {
  if (type == ReminderType.custom && customLabel != null && customLabel.isNotEmpty) {
    return customLabel;
  }
  return switch (type) {
    ReminderType.oilChange => 'Ölwechsel',
    ReminderType.tuev => 'TÜV / HU',
    ReminderType.majorService => 'Große Inspektion',
    ReminderType.minorService => 'Kleine Inspektion',
    ReminderType.tyreSwap => 'Reifenwechsel',
    ReminderType.custom => 'Sonstiges',
  };
}
