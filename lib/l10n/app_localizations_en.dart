// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AutoMate';

  @override
  String get commonSave => 'Save';

  @override
  String get commonSaving => 'Saving…';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonBack => 'Back';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonAdd => 'Add';

  @override
  String commonError(String error) {
    return 'Error: $error';
  }

  @override
  String get commonNoVehicle => 'No vehicle';

  @override
  String get fuelTypePetrol => 'Petrol';

  @override
  String get fuelTypeDiesel => 'Diesel';

  @override
  String get fuelTypeElectric => 'Electric';

  @override
  String get fuelTypeHybrid => 'Hybrid';

  @override
  String get fuelTypeOther => 'Other';

  @override
  String get fuelGradeSuperE5 => 'Super E5 (95)';

  @override
  String get fuelGradeSuperE10 => 'Super E10 (95)';

  @override
  String get fuelGradeSuperPlus => 'Super Plus (98)';

  @override
  String get fuelGradePremium => 'Premium (100)';

  @override
  String get fuelGradeDieselB7 => 'Diesel B7';

  @override
  String get fuelGradeDieselPremium => 'Premium Diesel';

  @override
  String get reminderTypeOilChange => 'Oil change';

  @override
  String get reminderTypeTuev => 'MOT / annual inspection';

  @override
  String get reminderTypeMajorService => 'Major service';

  @override
  String get reminderTypeMinorService => 'Minor service';

  @override
  String get reminderTypeTyreSwap => 'Tyre swap';

  @override
  String get reminderTypeCustom => 'Other';

  @override
  String get skillLevelBeginner => 'Beginner';

  @override
  String get skillLevelIntermediate => 'Intermediate';

  @override
  String get skillLevelPro => 'Pro';

  @override
  String get onboardingWelcomeTitle => 'Welcome to\nAutoMate';

  @override
  String get onboardingWelcomeSubtitle =>
      'Your companion for maintenance,\nrepairs and breakdowns.';

  @override
  String get onboardingNameLabel => 'Your name';

  @override
  String get onboardingNameError => 'Please enter your name';

  @override
  String get onboardingStartButton => 'Let\'s go';

  @override
  String get onboardingStartingButton => 'Just a moment…';

  @override
  String get skillQuizIntro =>
      'So AutoMate can give you the right recommendations, answer 5 quick questions. Takes less than a minute.';

  @override
  String skillQuizProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get skillQuizNext => 'Next';

  @override
  String get skillQuizEvaluate => 'Evaluate';

  @override
  String skillQuizHello(String firstName) {
    return 'Hello, $firstName!';
  }

  @override
  String get skillQuizHelloGeneric => 'Hello!';

  @override
  String get skillQuiz1Question => 'A warning light comes on. What do you do?';

  @override
  String get skillQuiz1Answer1 =>
      'Head straight to the garage — better safe than sorry.';

  @override
  String get skillQuiz1Answer2 => 'I look up the meaning and decide myself.';

  @override
  String get skillQuiz1Answer3 =>
      'I read the fault code with an OBD device and analyse it.';

  @override
  String get skillQuiz2Question =>
      'When do you check the engine oil level yourself?';

  @override
  String get skillQuiz2Answer1 =>
      'Never — the garage handles that at the next service.';

  @override
  String get skillQuiz2Answer2 =>
      'Occasionally, before long trips or when I think of it.';

  @override
  String get skillQuiz2Answer3 =>
      'Regularly — I know my engine\'s typical oil consumption precisely.';

  @override
  String get skillQuiz3Question => 'Have you ever worked on your car yourself?';

  @override
  String get skillQuiz3Answer1 =>
      'No, I always leave that to the professionals.';

  @override
  String get skillQuiz3Answer2 =>
      'Yes, simple things like wipers, bulbs or air filter.';

  @override
  String get skillQuiz3Answer3 =>
      'Yes, including complex jobs — e.g. brakes, clutch or suspension.';

  @override
  String get skillQuiz4Question =>
      'Your car makes an unfamiliar noise. What do you do first?';

  @override
  String get skillQuiz4Answer1 =>
      'Call the garage — I don\'t want to take any risks.';

  @override
  String get skillQuiz4Answer2 =>
      'I try to describe the noise and search online for causes.';

  @override
  String get skillQuiz4Answer3 =>
      'I systematically locate the noise and check the affected components myself.';

  @override
  String get skillQuiz5Question =>
      'How familiar are you with your car\'s engine bay?';

  @override
  String get skillQuiz5Answer1 =>
      'I only open the bonnet to top up the windscreen washer.';

  @override
  String get skillQuiz5Answer2 =>
      'I know the main parts and regularly check oil and coolant levels.';

  @override
  String get skillQuiz5Answer3 =>
      'I know the layout and function and can replace many parts independently.';

  @override
  String get skillResultTitle => 'Your skill level:';

  @override
  String get skillResultBeginnerDesc =>
      'You rely on professionals — that\'s smart and safe. AutoMate gives you clear hints about when to visit a garage, and explains everything in plain language without jargon.';

  @override
  String get skillResultBeginnerFeatures =>
      'Garage recommendations, simple explanations';

  @override
  String get skillResultIntermediateDesc =>
      'You know your car well and like to get stuck in. AutoMate shows you suitable repair tutorials and helps you find the right parts — step by step.';

  @override
  String get skillResultIntermediateFeatures => 'Tutorials, DIY with guidance';

  @override
  String get skillResultProDesc =>
      'You know exactly what happens under the bonnet. AutoMate delivers technical details, raw fault codes and full control — without dumbing things down.';

  @override
  String get skillResultProFeatures =>
      'Technical details, OBD data, full control';

  @override
  String skillResultFitsQuestion(String firstName) {
    return 'Does that fit you, $firstName?';
  }

  @override
  String get skillResultFitsQuestionNoName => 'Does that fit you?';

  @override
  String get skillResultYes => 'Yes, that fits!';

  @override
  String get skillResultNo => 'No, I\'d like to adjust it';

  @override
  String get skillResultSelectLevel => 'Choose your level';

  @override
  String get skillResultAdjustLater =>
      'You can adjust it at any time in your profile.';

  @override
  String get dashboardTitle => 'AutoMate';

  @override
  String get dashboardAddVehicle => 'Add vehicle';

  @override
  String get dashboardNoVehicle => 'No vehicle yet';

  @override
  String get dashboardNoVehicleHint => 'Add your first vehicle.';

  @override
  String get vehicleSetupTitle => 'Add vehicle';

  @override
  String get vehicleSetupSectionData => 'Vehicle data';

  @override
  String get vehicleSetupSectionHint =>
      'Basic details about your car. No VIN? No problem — it\'s optional.';

  @override
  String get vehicleSetupYear => 'Year *';

  @override
  String get vehicleSetupMake => 'Make *';

  @override
  String get vehicleSetupMakePlaceholder => 'e.g. Ford, Toyota, BMW';

  @override
  String get vehicleSetupMakeLoading => 'Loading…';

  @override
  String get vehicleSetupModelDisabled => 'Model * (select make first)';

  @override
  String get vehicleSetupModel => 'Model *';

  @override
  String get vehicleSetupModelPlaceholder => 'e.g. Golf, Corolla, 3 Series';

  @override
  String get vehicleSetupVin => 'VIN (optional)';

  @override
  String get vehicleSetupVinHint =>
      '17-digit VIN, found in your registration document';

  @override
  String get vehicleSetupFuel => 'Fuel *';

  @override
  String get vehicleSetupMileage => 'Current mileage *';

  @override
  String get vehicleSetupAnnualKm => 'Estimated km per year (optional)';

  @override
  String get vehicleSetupAnnualKmHint =>
      'Helps calculate maintenance intervals';

  @override
  String get vehicleSetupAnnualKmSuffix => 'km/year';

  @override
  String get vehicleSetupSaveButton => 'Save vehicle';

  @override
  String get vehicleSetupSavingButton => 'Saving…';

  @override
  String get vehicleDetailMoreActions => 'More actions';

  @override
  String get vehicleDetailNotFound => 'Vehicle not found.';

  @override
  String get vehicleDetailUpdateMileage => 'Update mileage';

  @override
  String get vehicleDetailDeleteVehicle => 'Delete vehicle';

  @override
  String get vehicleDetailSectionMaintenance => 'Maintenance';

  @override
  String get vehicleDetailFuelTitle => 'Fuel & Consumption';

  @override
  String get vehicleDetailFuelSubtitle =>
      'Log fill-ups · calculate consumption';

  @override
  String get vehicleDetailRemindersTitle => 'Reminders';

  @override
  String get vehicleDetailRemindersSubtitle =>
      'Due dates for oil change, MOT, services';

  @override
  String get vehicleDetailHistoryTitle => 'Maintenance history';

  @override
  String get vehicleDetailHistorySubtitle => 'All completed work';

  @override
  String get vehicleDetailConsumablesTitle => 'Consumables';

  @override
  String get vehicleDetailConsumablesSubtitle =>
      'Oil, coolant, brake fluid — copy to clipboard';

  @override
  String get vehicleDetailSectionRepair => 'Repairs & breakdowns';

  @override
  String get vehicleDetailTutorialsTitle => 'Repair tutorials';

  @override
  String get vehicleDetailTutorialsSubtitle => 'YouTube videos for your model';

  @override
  String get vehicleDetailReportTitle => 'Workshop report';

  @override
  String get vehicleDetailReportSubtitle =>
      'AI-generated PDF diagnosis for your mechanic';

  @override
  String get vehicleDetailBreakdownTitle => 'Breakdown assistant';

  @override
  String get vehicleDetailBreakdownSubtitle =>
      'AI chat on the road · voice control';

  @override
  String get vehicleDetailGaragesTitle => 'Find a garage';

  @override
  String get vehicleDetailGaragesSubtitle => 'Map-based search near you';

  @override
  String get vehicleDetailUpdateMileageTitle => 'Update mileage';

  @override
  String get vehicleDetailCurrentMileageLabel => 'Current mileage';

  @override
  String get vehicleDetailDeleteTitle => 'Delete vehicle?';

  @override
  String vehicleDetailDeleteBody(int year, String make, String model) {
    return '$year $make $model and all associated reminders, history entries and consumable specs will be permanently removed.';
  }

  @override
  String vehicleDetailMileageUpdated(String km) {
    return 'Mileage updated to $km km';
  }

  @override
  String get vehicleDetailDeleted => 'Vehicle deleted';

  @override
  String get vehicleDetailKmLabel => 'Mileage';

  @override
  String get vehicleDetailYearLabel => 'Year';

  @override
  String get vehicleDetailVinLabel => 'VIN';

  @override
  String get fuelScreenTitle => 'Fuel & Consumption';

  @override
  String get fuelScreenAddButton => 'Add fuel';

  @override
  String get fuelScreenAllEntries => 'All fuel entries';

  @override
  String get fuelScreenEmptyTitle => 'No fuel entries yet';

  @override
  String get fuelScreenEmptyBody =>
      'Add your first fill-up\nto start calculating consumption.';

  @override
  String get fuelScreenNotAvailableTitle => 'Not available';

  @override
  String get fuelScreenNotAvailableBody =>
      'The fuel log is only available for petrol, diesel and hybrid vehicles.';

  @override
  String get fuelScreenStatConsumption => 'Avg consumption';

  @override
  String get fuelScreenStatKmPerYear => 'Avg km/year';

  @override
  String get fuelScreenStatTotalCost => 'Total cost';

  @override
  String get fuelScreenDeleteTitle => 'Delete entry?';

  @override
  String get fuelSheetTitle => 'Add fill-up';

  @override
  String get fuelSheetFieldGrade => 'Fuel grade';

  @override
  String get fuelSheetFieldLiters => 'Litres filled';

  @override
  String get fuelSheetFieldTotalPrice => 'Total price';

  @override
  String get fuelSheetFieldOdometer => 'Odometer at fill-up';

  @override
  String get fuelSheetFullTankLabel => 'Full tank';

  @override
  String get fuelSheetFullTankHint => 'For precise consumption calculation';

  @override
  String get fuelSheetSave => 'Save';

  @override
  String get fuelSheetSaving => 'Saving…';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String get remindersNew => 'New';

  @override
  String get remindersEmpty => 'No reminders';

  @override
  String get remindersEmptyHint =>
      'Add a reminder for oil change, MOT and more.';

  @override
  String get remindersMarkDone => 'Mark as done';

  @override
  String remindersMarkDoneConfirm(String label) {
    return 'Mark \"$label\" as done?';
  }

  @override
  String get remindersMarkedDone => 'Marked as done';

  @override
  String get remindersDeleteTitle => 'Delete reminder?';

  @override
  String remindersDeleteBody(String label) {
    return 'The reminder \"$label\" and all associated notifications will be removed.';
  }

  @override
  String get remindersDeleted => 'Reminder deleted';

  @override
  String remindersOverdue(int days) {
    return '$days days overdue';
  }

  @override
  String get remindersDueToday => 'Due today!';

  @override
  String get remindersDueTomorrow => 'Due tomorrow';

  @override
  String remindersDueInDays(int days, String date) {
    return 'In $days days · $date';
  }

  @override
  String remindersDueInWeeks(int weeks, String date) {
    return 'In $weeks weeks · $date';
  }

  @override
  String remindersKmOverdue(String km) {
    return 'Km threshold reached! ($km km)';
  }

  @override
  String remindersKmDueAt(String due, String kmLeft, String current) {
    return 'At $due km · $kmLeft km left (now $current km)';
  }

  @override
  String remindersKmWithWarning(String base, String km) {
    return '$base · warning from $km km';
  }

  @override
  String get addReminderTitle => 'New reminder';

  @override
  String get addReminderTypeLabel => 'Maintenance type';

  @override
  String get addReminderCustomLabel => 'Custom name';

  @override
  String get addReminderCustomPlaceholder => 'e.g. Replace pollen filter';

  @override
  String get addReminderDueDateLabel => 'Due date';

  @override
  String get addReminderDueDateHint => 'Tap to change';

  @override
  String get addReminderDueMileageLabel => 'Due at mileage (optional)';

  @override
  String get addReminderDueMileageHint =>
      'If the maintenance also depends on mileage';

  @override
  String get addReminderKmOffsetLabel => 'Km pre-warning';

  @override
  String get addReminderKmOffsetHint =>
      'Notify this many km before the due mileage';

  @override
  String get addReminderAtDue => 'Exactly at due date';

  @override
  String addReminderKmBefore(int km) {
    return '$km km before';
  }

  @override
  String get addReminderNotificationsLabel => 'Notifications';

  @override
  String get addReminderNotificationsHint =>
      'When would you like to be reminded before the due date?';

  @override
  String get addReminderCustomTimeLabel => 'Custom time';

  @override
  String get addReminderDaysSuffix => 'days';

  @override
  String get addReminderNoNotifications =>
      'No notifications active — the reminder will only appear in the list.';

  @override
  String get addReminderSaveButton => 'Create reminder';

  @override
  String get addReminderSavingButton => 'Saving…';

  @override
  String get addReminderCustomNameError =>
      'Please enter a name for the custom reminder.';

  @override
  String get addReminderNotificationsDisabledTitle => 'Notifications disabled';

  @override
  String get addReminderNotificationsDisabledBody =>
      'Without notifications AutoMate cannot remind you of upcoming maintenance. You can grant permission in the system settings.';

  @override
  String get addReminderSaveAnyway => 'Save anyway';

  @override
  String get addReminderOpenSettings => 'Open settings';

  @override
  String get addReminderDay => '1 day';

  @override
  String addReminderDays(int days) {
    return '$days days';
  }

  @override
  String get addReminderWeek => '1 week';

  @override
  String addReminderWeeks(int weeks) {
    return '$weeks weeks';
  }

  @override
  String get addReminderNotifDay => '1 day until due.';

  @override
  String addReminderNotifDays(int days) {
    return '$days days until due.';
  }

  @override
  String get addReminderNotifWeek => '1 week until due.';

  @override
  String addReminderNotifWeeks(int weeks) {
    return '$weeks weeks until due.';
  }

  @override
  String addReminderSaveFailed(String error) {
    return 'Save failed: $error';
  }

  @override
  String get kmReminderBodyDue => 'Maintenance due! Mileage threshold reached.';

  @override
  String kmReminderBodyKmLeft(int km) {
    return '$km km until due.';
  }

  @override
  String get historyTitle => 'Maintenance history';

  @override
  String get historyEmpty => 'No history yet';

  @override
  String get historyEmptyHint =>
      'When you mark a reminder as done, it will appear here.';

  @override
  String get historyDeleteTitle => 'Delete entry?';

  @override
  String get historyDeleteBody =>
      'The entry will be permanently removed from the history.';

  @override
  String get historyDeleted => 'Entry deleted';

  @override
  String historyCompletedOn(String date) {
    return 'Completed on $date';
  }

  @override
  String historyMileageAt(String km) {
    return 'Mileage: $km km';
  }

  @override
  String historyWorkshop(String name) {
    return 'Workshop: $name';
  }

  @override
  String historyCost(String amount) {
    return 'Cost: $amount €';
  }

  @override
  String get consumablesTitle => 'Consumables';

  @override
  String get consumablesEmpty => 'No specs yet';

  @override
  String get consumablesEmptyHint =>
      'Add oil, coolant and brake fluid specs for your car so you have them ready at the garage.';

  @override
  String get consumablesAddButton => 'Add specs';

  @override
  String consumablesHintWithVehicle(int year, String make, String model) {
    return 'Specs for $year $make $model — tap \"Copy\" to share with the garage.';
  }

  @override
  String get consumablesHintGeneral =>
      'Specs for the garage — tap \"Copy\" to share.';

  @override
  String get consumablesEngineOil => 'Engine oil';

  @override
  String get consumablesOilVolume => 'Oil capacity';

  @override
  String get consumablesCoolant => 'Coolant';

  @override
  String get consumablesBrakeFluid => 'Brake fluid';

  @override
  String get consumablesTransmissionFluid => 'Transmission fluid';

  @override
  String get consumablesCopyAll => 'Copy all specs';

  @override
  String get consumablesCopied => 'Specs copied to clipboard';

  @override
  String get consumablesEditTitle => 'Edit specs';

  @override
  String get consumablesCreateTitle => 'Add specs';

  @override
  String get consumablesOilGradeLabel => 'Engine oil viscosity';

  @override
  String get consumablesOilGradePlaceholder => 'e.g. 5W-30';

  @override
  String get consumablesOilVolumeLabel => 'Oil capacity (litres)';

  @override
  String get consumablesOilVolumePlaceholder => 'e.g. 4.5';

  @override
  String get consumablesCoolantLabel => 'Coolant';

  @override
  String get consumablesCoolantPlaceholder => 'e.g. G12++';

  @override
  String get consumablesBrakeFluidLabel => 'Brake fluid';

  @override
  String get consumablesBrakeFluidPlaceholder => 'e.g. DOT 4';

  @override
  String get consumablesTransFluidLabel => 'Transmission fluid';

  @override
  String get consumablesTransFluidPlaceholder => 'e.g. ATF 3+';

  @override
  String consumablesCopyHeader(String header) {
    return 'AutoMate – $header';
  }

  @override
  String consumablesCopyOilGrade(String value) {
    return 'Engine oil: $value';
  }

  @override
  String consumablesCopyOilVolume(String value) {
    return 'Oil capacity: $value l';
  }

  @override
  String consumablesCopyCoolant(String value) {
    return 'Coolant: $value';
  }

  @override
  String consumablesCopyBrakeFluid(String value) {
    return 'Brake fluid: $value';
  }

  @override
  String consumablesCopyTransFluid(String value) {
    return 'Transmission fluid: $value';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsApiKeysSection => 'API keys';

  @override
  String get settingsApiKeysHint =>
      'Keys are stored locally on your device only. You need them to use the AI features and YouTube tutorials.';

  @override
  String get settingsGeminiKeyLabel => 'Gemini API key (Google AI)';

  @override
  String get settingsGeminiKeyHint => 'AIza…';

  @override
  String get settingsGeminiKeyLink => 'Create key at Google AI Studio';

  @override
  String get settingsYouTubeKeyLabel => 'YouTube Data API v3 key';

  @override
  String get settingsYouTubeKeyLink => 'Create key at Google Cloud';

  @override
  String get settingsNotificationsSection => 'Notifications';

  @override
  String get settingsNotificationsActive => 'Notifications are active';

  @override
  String get settingsNotificationsDisabled => 'Notifications are disabled';

  @override
  String get settingsNotificationsActiveHint =>
      'You will receive reminders for upcoming maintenance.';

  @override
  String get settingsPwaNotificationsHint =>
      'Only works while the PWA is open.';

  @override
  String get settingsNotificationsNoPermission =>
      'Without permission AutoMate cannot remind you.';

  @override
  String get settingsAllowNotifications => 'Allow';

  @override
  String get settingsSendTestNotification => 'Send test notification';

  @override
  String get settingsScheduleTestNotification => 'Schedule test in 2 minutes';

  @override
  String get settingsDefaultRemindersHint =>
      'Default reminder times before due date. Can be overridden per reminder.';

  @override
  String get settingsReportSection => 'Workshop report';

  @override
  String get settingsReportLanguageLabel => 'Report language';

  @override
  String get settingsReportLanguageHint => 'Useful if you break down abroad.';

  @override
  String get settingsSaveButton => 'Save';

  @override
  String get settingsWebWarning =>
      'You are using the web version. Voice assistant, OBD-II and camera scan only work in the mobile app.';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get settingsPermissionDenied =>
      'Permission denied. Open system settings to allow it.';

  @override
  String get settingsPermissionError => 'Notifications not allowed.';

  @override
  String get settingsNotificationsWork => 'Notifications working.';

  @override
  String get settingsTestSent => 'Test notification sent';

  @override
  String get settingsScheduledNotification =>
      'Scheduled notification in 2 minutes.';

  @override
  String get settingsScheduledPwa =>
      'Test in 2 min scheduled — keep the PWA open.';

  @override
  String get settingsScheduledMobile => 'Test in 2 min scheduled.';

  @override
  String settingsScheduleFailed(String error) {
    return 'Scheduling failed: $error';
  }

  @override
  String get settingsLangDe => 'German';

  @override
  String get settingsLangEn => 'English';

  @override
  String get settingsLangFr => 'French';

  @override
  String get settingsLangEs => 'Spanish';

  @override
  String get settingsLangIt => 'Italian';

  @override
  String get profileTitle => 'PROFILE';

  @override
  String get profileName => 'Name';

  @override
  String get profileMemberSince => 'Member since';

  @override
  String get profileSkillLevel => 'Skill level';

  @override
  String profileMemberSinceDate(String date) {
    return 'Member since $date';
  }

  @override
  String get profileSettingsSection => 'SETTINGS';

  @override
  String get profileChangeSkillLevel => 'Change skill level';

  @override
  String get profileApiAndLanguage => 'API keys & language';

  @override
  String get profileApiAndLanguageHint => 'Gemini, YouTube, report language';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileChangeSkillLevelTitle => 'Change skill level';

  @override
  String get profileChangeSkillLevelBody =>
      'Do you really want to adjust your skill level?\nAutoMate will adapt all recommendations and explanations accordingly.';

  @override
  String get profileChangeSkillLevelYes => 'Yes, adjust';

  @override
  String get profileSelectSkillLevel => 'Choose your skill level';

  @override
  String get skillLevelBeginnerFeatures =>
      'Garage recommendations, simple explanations';

  @override
  String get skillLevelIntermediateFeatures => 'Tutorials, DIY with guidance';

  @override
  String get skillLevelProFeatures => 'Technical details, full control';

  @override
  String get tutorialsTitle => 'Repair tutorials';

  @override
  String get tutorialsNoVehicle => 'No vehicle';

  @override
  String tutorialsVehicleLabel(int year, String make, String model) {
    return 'For: $year $make $model';
  }

  @override
  String get tutorialsSearchPlaceholder =>
      'e.g. replace brakes, oil change, spark plugs';

  @override
  String get tutorialsBeginnerTip =>
      'Beginner tip: For complex repairs, work with a garage.';

  @override
  String get tutorialsIntermediateTip =>
      'Easy step-by-step videos for your level are preferred.';

  @override
  String get tutorialsProTip =>
      'For you: search specific terms (e.g. \"replace head gasket\").';

  @override
  String get tutorialsEmptyHint =>
      'Enter what you want to repair above and we\'ll find matching videos.';

  @override
  String get tutorialsNothingFound => 'Nothing found';

  @override
  String get videoPlayerTip =>
      'Tip: Watch the video all the way through before you start. Note the tools and parts you\'ll need.';

  @override
  String get workshopTitle => 'Workshop report';

  @override
  String get workshopSharePdf => 'Share as PDF';

  @override
  String get workshopNoVehicle => 'No vehicle';

  @override
  String get workshopDescription =>
      'Briefly describe the problem — the AI creates a structured report you can give to your mechanic.';

  @override
  String get workshopSymptomsLabel => 'Symptoms';

  @override
  String get workshopSymptomsPlaceholder =>
      'e.g. \"Since yesterday the engine stutters at 60 km/h, the engine warning light is flashing yellow, smell of petrol.\"';

  @override
  String get workshopAnalyzing => 'Analysing…';

  @override
  String get workshopGenerateButton => 'Generate report';

  @override
  String get workshopAnalysisTitle => 'Analysis';

  @override
  String get workshopPdfTitle => 'AutoMate — Workshop report';

  @override
  String get workshopPdfSymptomsLabel => 'Observed symptoms:';

  @override
  String get workshopPdfAnalysisLabel => 'Analysis:';

  @override
  String get workshopPdfFooter =>
      'Created with AutoMate · AI analysis for guidance only · Does not replace professional diagnosis.';

  @override
  String workshopPdfFilename(String make, String model) {
    return 'workshop_report_${make}_$model.pdf';
  }

  @override
  String get breakdownTitle => 'Breakdown assistant';

  @override
  String get breakdownTts => 'Text-to-speech';

  @override
  String get breakdownFindGarage => 'Find garage';

  @override
  String get breakdownNoVehicle => 'No vehicle';

  @override
  String breakdownPlaceholder(String make) {
    return 'What\'s wrong with your $make?';
  }

  @override
  String get breakdownExamplesTitle => 'Speak or type your problem. Examples:';

  @override
  String get breakdownExample1Beginner =>
      'The engine warning light is flashing yellow';

  @override
  String get breakdownExample2Beginner => 'The car won\'t start';

  @override
  String get breakdownExample3Beginner => 'I hear a squeak when braking';

  @override
  String get breakdownExample1Intermediate => 'Fault code P0420 — what to do?';

  @override
  String get breakdownExample2Intermediate =>
      'Replacing brakes — what do I need?';

  @override
  String get breakdownExample3Intermediate =>
      'Doing an oil change myself — what to watch out for?';

  @override
  String get breakdownExample1Pro =>
      'Front vs rear lambda sensor — differences';

  @override
  String get breakdownExample2Pro =>
      'Compression values Bank 1 low, diagnostic steps';

  @override
  String get breakdownExample3Pro =>
      'Replace dual-mass flywheel — tools needed';

  @override
  String get breakdownWebWarning =>
      'Voice control and text-to-speech are only available in the mobile app. You can still type in the browser.';

  @override
  String get breakdownInputPlaceholder => 'Describe the problem…';

  @override
  String get garageFinderTitle => 'Garages nearby';

  @override
  String get garageFinderDefault => 'Garage';

  @override
  String garageFinderFound(int count) {
    return '$count garages found';
  }

  @override
  String get garageFinderNoLocation =>
      'Location unavailable — searching around centre of Germany.';
}
