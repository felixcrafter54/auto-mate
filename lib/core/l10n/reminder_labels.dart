import '../../l10n/app_localizations.dart';
import '../../services/models/enums.dart';

/// Returns the localized display name for a ReminderType.
String reminderLabel(AppLocalizations l, ReminderType type, {String? customLabel}) {
  if (type == ReminderType.custom && customLabel != null && customLabel.isNotEmpty) {
    return customLabel;
  }
  return switch (type) {
    ReminderType.oilChange => l.reminderTypeOilChange,
    ReminderType.tuev => l.reminderTypeTuev,
    ReminderType.majorService => l.reminderTypeMajorService,
    ReminderType.minorService => l.reminderTypeMinorService,
    ReminderType.tyreSwap => l.reminderTypeTyreSwap,
    ReminderType.custom => l.reminderTypeCustom,
  };
}
