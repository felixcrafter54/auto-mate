// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'AutoMate';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonSaving => 'Speichere…';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonBack => 'Zurück';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get commonAdd => 'Hinzufügen';

  @override
  String commonError(String error) {
    return 'Fehler: $error';
  }

  @override
  String get commonNoVehicle => 'Kein Fahrzeug';

  @override
  String get fuelTypePetrol => 'Benzin';

  @override
  String get fuelTypeDiesel => 'Diesel';

  @override
  String get fuelTypeElectric => 'Elektro';

  @override
  String get fuelTypeHybrid => 'Hybrid';

  @override
  String get fuelTypeOther => 'Sonstiges';

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
  String get reminderTypeOilChange => 'Ölwechsel';

  @override
  String get reminderTypeTuev => 'TÜV / HU';

  @override
  String get reminderTypeMajorService => 'Große Inspektion';

  @override
  String get reminderTypeMinorService => 'Kleine Inspektion';

  @override
  String get reminderTypeTyreSwap => 'Reifenwechsel';

  @override
  String get reminderTypeCustom => 'Sonstiges';

  @override
  String get skillLevelBeginner => 'Einsteiger';

  @override
  String get skillLevelIntermediate => 'Fortgeschritten';

  @override
  String get skillLevelPro => 'Profi';

  @override
  String get onboardingWelcomeTitle => 'Willkommen bei\nAutoMate';

  @override
  String get onboardingWelcomeSubtitle =>
      'Dein Begleiter für Wartung,\nReparaturen und Pannen.';

  @override
  String get onboardingNameLabel => 'Dein Name';

  @override
  String get onboardingNameError => 'Bitte gib deinen Namen ein';

  @override
  String get onboardingStartButton => 'Los geht\'s';

  @override
  String get onboardingStartingButton => 'Einen Moment…';

  @override
  String get skillQuizIntro =>
      'Damit AutoMate dir die passenden Empfehlungen geben kann, beantworte kurz 5 Fragen. Dauert weniger als eine Minute.';

  @override
  String skillQuizProgress(int current, int total) {
    return 'Frage $current von $total';
  }

  @override
  String get skillQuizNext => 'Weiter';

  @override
  String get skillQuizEvaluate => 'Auswerten';

  @override
  String skillQuizHello(String firstName) {
    return 'Hallo, $firstName!';
  }

  @override
  String get skillQuizHelloGeneric => 'Hallo!';

  @override
  String get skillQuiz1Question =>
      'Eine Warnleuchte leuchtet auf. Was machst du?';

  @override
  String get skillQuiz1Answer1 =>
      'Direkt zur Werkstatt – lieber auf Nummer sicher gehen.';

  @override
  String get skillQuiz1Answer2 =>
      'Ich schlage die Bedeutung nach und entscheide dann selbst.';

  @override
  String get skillQuiz1Answer3 =>
      'Ich lese den Fehlercode mit einem OBD-Gerät aus und analysiere ihn.';

  @override
  String get skillQuiz2Question => 'Wann prüfst du selbst den Motorölstand?';

  @override
  String get skillQuiz2Answer1 =>
      'Nie – das erledigt die Werkstatt beim nächsten Service.';

  @override
  String get skillQuiz2Answer2 =>
      'Gelegentlich, vor langen Fahrten oder wenn ich mal daran denke.';

  @override
  String get skillQuiz2Answer3 =>
      'Regelmäßig – ich kenne den typischen Ölverbrauch meines Motors genau.';

  @override
  String get skillQuiz3Question =>
      'Hast du schon selbst an deinem Auto gearbeitet?';

  @override
  String get skillQuiz3Answer1 => 'Nein, das überlasse ich immer dem Fachmann.';

  @override
  String get skillQuiz3Answer2 =>
      'Ja, einfache Sachen wie Scheibenwischer, Glühbirnen oder Luftfilter.';

  @override
  String get skillQuiz3Answer3 =>
      'Ja, auch komplexere Arbeiten – z. B. Bremsen, Kupplung oder Fahrwerk.';

  @override
  String get skillQuiz4Question =>
      'Dein Auto macht ein unbekanntes Geräusch. Was tust du zuerst?';

  @override
  String get skillQuiz4Answer1 =>
      'Werkstatt anrufen – ich möchte kein Risiko eingehen.';

  @override
  String get skillQuiz4Answer2 =>
      'Ich versuche das Geräusch zu beschreiben und suche online nach Ursachen.';

  @override
  String get skillQuiz4Answer3 =>
      'Ich lokalisiere das Geräusch systematisch und prüfe betroffene Bauteile selbst.';

  @override
  String get skillQuiz5Question =>
      'Wie vertraut bist du mit dem Motorraum deines Autos?';

  @override
  String get skillQuiz5Answer1 =>
      'Ich öffne die Motorhaube eigentlich nur zum Scheibenwasser nachfüllen.';

  @override
  String get skillQuiz5Answer2 =>
      'Ich kenne die wichtigsten Teile und prüfe regelmäßig Öl- und Kühlmittelstand.';

  @override
  String get skillQuiz5Answer3 =>
      'Ich kenne Aufbau und Funktion und kann viele Teile eigenständig wechseln.';

  @override
  String get skillResultTitle => 'Dein Skill-Level:';

  @override
  String get skillResultBeginnerDesc =>
      'Du verlässt dich auf Fachleute – das ist klug und sicher. AutoMate gibt dir klare Hinweise, wann du in die Werkstatt solltest, und erklärt alles verständlich ohne Fachchinesisch.';

  @override
  String get skillResultBeginnerFeatures =>
      'Werkstatt-Empfehlungen, einfache Erklärungen';

  @override
  String get skillResultIntermediateDesc =>
      'Du kennst dein Auto gut und packst gerne selbst mit an. AutoMate zeigt dir passende Repair-Tutorials und hilft dir, die richtigen Teile zu finden – Schritt für Schritt.';

  @override
  String get skillResultIntermediateFeatures => 'Tutorials, DIY mit Anleitung';

  @override
  String get skillResultProDesc =>
      'Du weißt genau, was unter der Motorhaube passiert. AutoMate liefert dir technische Details, Fehlercodes im Rohformat und volle Kontrolle – ganz ohne Vereinfachungen.';

  @override
  String get skillResultProFeatures =>
      'Technische Details, OBD-Daten, volle Kontrolle';

  @override
  String skillResultFitsQuestion(String firstName) {
    return 'Passt das für dich, $firstName?';
  }

  @override
  String get skillResultFitsQuestionNoName => 'Passt das für dich?';

  @override
  String get skillResultYes => 'Ja, das passt!';

  @override
  String get skillResultNo => 'Nein, ich möchte es anpassen';

  @override
  String get skillResultSelectLevel => 'Wähle dein Level';

  @override
  String get skillResultAdjustLater =>
      'Du kannst es jederzeit im Profil anpassen.';

  @override
  String get dashboardTitle => 'AutoMate';

  @override
  String get dashboardAddVehicle => 'Fahrzeug hinzufügen';

  @override
  String get dashboardNoVehicle => 'Noch kein Fahrzeug';

  @override
  String get dashboardNoVehicleHint => 'Füge dein erstes Fahrzeug hinzu.';

  @override
  String get vehicleSetupTitle => 'Fahrzeug hinzufügen';

  @override
  String get vehicleSetupSectionData => 'Fahrzeugdaten';

  @override
  String get vehicleSetupSectionHint =>
      'Grunddaten deines Autos. Ohne VIN kein Problem — die ist optional.';

  @override
  String get vehicleSetupYear => 'Baujahr *';

  @override
  String get vehicleSetupMake => 'Marke *';

  @override
  String get vehicleSetupMakePlaceholder => 'z. B. Ford, Toyota, BMW';

  @override
  String get vehicleSetupMakeLoading => 'Lade…';

  @override
  String get vehicleSetupModelDisabled => 'Modell * (erst Marke wählen)';

  @override
  String get vehicleSetupModel => 'Modell *';

  @override
  String get vehicleSetupModelPlaceholder => 'z. B. Golf, Corolla, 3er';

  @override
  String get vehicleSetupVin => 'Fahrgestellnummer (optional)';

  @override
  String get vehicleSetupVinHint =>
      '17-stellige VIN, findest du im Fahrzeugschein';

  @override
  String get vehicleSetupFuel => 'Kraftstoff *';

  @override
  String get vehicleSetupMileage => 'Aktueller Kilometerstand *';

  @override
  String get vehicleSetupAnnualKm => 'Geschätzte Kilometer pro Jahr (optional)';

  @override
  String get vehicleSetupAnnualKmHint =>
      'Hilft bei der Berechnung von Wartungsintervallen';

  @override
  String get vehicleSetupAnnualKmSuffix => 'km/Jahr';

  @override
  String get vehicleSetupSaveButton => 'Fahrzeug speichern';

  @override
  String get vehicleSetupSavingButton => 'Speichere…';

  @override
  String get vehicleDetailMoreActions => 'Weitere Aktionen';

  @override
  String get vehicleDetailNotFound => 'Fahrzeug nicht gefunden.';

  @override
  String get vehicleDetailUpdateMileage => 'Kilometerstand aktualisieren';

  @override
  String get vehicleDetailDeleteVehicle => 'Fahrzeug löschen';

  @override
  String get vehicleDetailSectionMaintenance => 'Wartung';

  @override
  String get vehicleDetailFuelTitle => 'Tanken & Verbrauch';

  @override
  String get vehicleDetailFuelSubtitle =>
      'Tankfüllungen eintragen · Verbrauch berechnen';

  @override
  String get vehicleDetailRemindersTitle => 'Erinnerungen';

  @override
  String get vehicleDetailRemindersSubtitle =>
      'Fälligkeiten für Ölwechsel, TÜV, Inspektionen';

  @override
  String get vehicleDetailHistoryTitle => 'Wartungshistorie';

  @override
  String get vehicleDetailHistorySubtitle => 'Alle erledigten Arbeiten';

  @override
  String get vehicleDetailConsumablesTitle => 'Verbrauchsmaterial';

  @override
  String get vehicleDetailConsumablesSubtitle =>
      'Öl, Kühlmittel, Bremsflüssigkeit — zum Kopieren';

  @override
  String get vehicleDetailSectionRepair => 'Reparatur & Pannen';

  @override
  String get vehicleDetailTutorialsTitle => 'Reparatur-Tutorials';

  @override
  String get vehicleDetailTutorialsSubtitle => 'YouTube-Videos für dein Modell';

  @override
  String get vehicleDetailReportTitle => 'Werkstattbericht';

  @override
  String get vehicleDetailReportSubtitle =>
      'KI erstellt PDF-Diagnose für den Mechaniker';

  @override
  String get vehicleDetailBreakdownTitle => 'Pannen-Assistent';

  @override
  String get vehicleDetailBreakdownSubtitle =>
      'KI-Chat für unterwegs · Sprachsteuerung';

  @override
  String get vehicleDetailGaragesTitle => 'Werkstatt finden';

  @override
  String get vehicleDetailGaragesSubtitle =>
      'Karten-basierte Suche in deiner Nähe';

  @override
  String get vehicleDetailUpdateMileageTitle => 'Kilometerstand aktualisieren';

  @override
  String get vehicleDetailCurrentMileageLabel => 'Aktueller Kilometerstand';

  @override
  String get vehicleDetailDeleteTitle => 'Fahrzeug löschen?';

  @override
  String vehicleDetailDeleteBody(int year, String make, String model) {
    return '$year $make $model und alle zugehörigen Erinnerungen, Historieneinträge und Verbrauchsmaterial-Specs werden unwiderruflich entfernt.';
  }

  @override
  String vehicleDetailMileageUpdated(String km) {
    return 'Kilometerstand auf $km km aktualisiert';
  }

  @override
  String get vehicleDetailDeleted => 'Fahrzeug gelöscht';

  @override
  String get vehicleDetailKmLabel => 'Kilometer';

  @override
  String get vehicleDetailYearLabel => 'Baujahr';

  @override
  String get vehicleDetailVinLabel => 'VIN';

  @override
  String get fuelScreenTitle => 'Tanken & Verbrauch';

  @override
  String get fuelScreenAddButton => 'Tankfüllung';

  @override
  String get fuelScreenAllEntries => 'Alle Tankfüllungen';

  @override
  String get fuelScreenEmptyTitle => 'Noch keine Tankfüllungen';

  @override
  String get fuelScreenEmptyBody =>
      'Trage deine erste Tankfüllung ein\num den Verbrauch zu berechnen.';

  @override
  String get fuelScreenNotAvailableTitle => 'Nicht verfügbar';

  @override
  String get fuelScreenNotAvailableBody =>
      'Das Tanktagebuch steht nur für Benzin-, Diesel- und Hybridfahrzeuge zur Verfügung.';

  @override
  String get fuelScreenStatConsumption => 'Ø Verbrauch';

  @override
  String get fuelScreenStatKmPerYear => 'Ø km/Jahr';

  @override
  String get fuelScreenStatTotalCost => 'Kosten ges.';

  @override
  String get fuelScreenDeleteTitle => 'Eintrag löschen?';

  @override
  String get fuelSheetTitle => 'Tankfüllung eintragen';

  @override
  String get fuelSheetFieldGrade => 'Kraftstoffsorte';

  @override
  String get fuelSheetFieldLiters => 'Getankte Liter';

  @override
  String get fuelSheetFieldTotalPrice => 'Gesamtpreis';

  @override
  String get fuelSheetFieldOdometer => 'Kilometerstand beim Tanken';

  @override
  String get fuelSheetFullTankLabel => 'Volltank';

  @override
  String get fuelSheetFullTankHint => 'Für präzise Verbrauchsberechnung';

  @override
  String get fuelSheetSave => 'Speichern';

  @override
  String get fuelSheetSaving => 'Speichere…';

  @override
  String get remindersTitle => 'Erinnerungen';

  @override
  String get remindersNew => 'Neu';

  @override
  String get remindersEmpty => 'Keine Erinnerungen';

  @override
  String get remindersEmptyHint =>
      'Lege eine Erinnerung für Ölwechsel, TÜV und Co. an.';

  @override
  String get remindersMarkDone => 'Erledigt markieren';

  @override
  String remindersMarkDoneConfirm(String label) {
    return 'Möchtest du \"$label\" als erledigt markieren?';
  }

  @override
  String get remindersMarkedDone => 'Als erledigt markiert';

  @override
  String get remindersDeleteTitle => 'Erinnerung löschen?';

  @override
  String remindersDeleteBody(String label) {
    return 'Die Erinnerung \"$label\" und alle zugehörigen Benachrichtigungen werden entfernt.';
  }

  @override
  String get remindersDeleted => 'Erinnerung gelöscht';

  @override
  String remindersOverdue(int days) {
    return '$days Tage überfällig';
  }

  @override
  String get remindersDueToday => 'Heute fällig!';

  @override
  String get remindersDueTomorrow => 'Morgen fällig';

  @override
  String remindersDueInDays(int days, String date) {
    return 'In $days Tagen · $date';
  }

  @override
  String remindersDueInWeeks(int weeks, String date) {
    return 'In $weeks Wochen · $date';
  }

  @override
  String remindersKmOverdue(String km) {
    return 'Km-Fälligkeit erreicht! ($km km)';
  }

  @override
  String remindersKmDueAt(String due, String kmLeft, String current) {
    return 'Bei $due km · noch $kmLeft km (jetzt $current km)';
  }

  @override
  String remindersKmWithWarning(String base, String km) {
    return '$base · Warnung ab $km km';
  }

  @override
  String get addReminderTitle => 'Neue Erinnerung';

  @override
  String get addReminderTypeLabel => 'Art der Wartung';

  @override
  String get addReminderCustomLabel => 'Eigene Bezeichnung';

  @override
  String get addReminderCustomPlaceholder => 'z.B. Pollenfilter wechseln';

  @override
  String get addReminderDueDateLabel => 'Fälligkeitsdatum';

  @override
  String get addReminderDueDateHint => 'Zum Ändern tippen';

  @override
  String get addReminderDueMileageLabel =>
      'Fällig bei Kilometerstand (optional)';

  @override
  String get addReminderDueMileageHint =>
      'Falls die Wartung auch vom Kilometerstand abhängt';

  @override
  String get addReminderKmOffsetLabel => 'km-Vorwarnung';

  @override
  String get addReminderKmOffsetHint =>
      'Benachrichtigung X km vor dem Fälligkeits-Kilometerstand';

  @override
  String get addReminderAtDue => 'Genau bei Fälligkeit';

  @override
  String addReminderKmBefore(int km) {
    return '$km km vorher';
  }

  @override
  String get addReminderNotificationsLabel => 'Benachrichtigungen';

  @override
  String get addReminderNotificationsHint =>
      'Wann möchtest du vor der Fälligkeit erinnert werden?';

  @override
  String get addReminderCustomTimeLabel => 'Eigener Zeitpunkt';

  @override
  String get addReminderDaysSuffix => 'Tage';

  @override
  String get addReminderNoNotifications =>
      'Keine Benachrichtigungen aktiv — die Erinnerung wird nur in der Liste angezeigt.';

  @override
  String get addReminderSaveButton => 'Erinnerung anlegen';

  @override
  String get addReminderSavingButton => 'Speichere…';

  @override
  String get addReminderCustomNameError =>
      'Bitte gib einen Namen für die eigene Erinnerung ein.';

  @override
  String get addReminderNotificationsDisabledTitle =>
      'Benachrichtigungen deaktiviert';

  @override
  String get addReminderNotificationsDisabledBody =>
      'Ohne Benachrichtigungen können wir dich nicht an anstehende Wartungen erinnern. In den Systemeinstellungen kannst du die Freigabe nachträglich erteilen.';

  @override
  String get addReminderSaveAnyway => 'Trotzdem speichern';

  @override
  String get addReminderOpenSettings => 'Einstellungen öffnen';

  @override
  String get addReminderDay => '1 Tag';

  @override
  String addReminderDays(int days) {
    return '$days Tage';
  }

  @override
  String get addReminderWeek => '1 Woche';

  @override
  String addReminderWeeks(int weeks) {
    return '$weeks Wochen';
  }

  @override
  String get addReminderNotifDay => 'Noch 1 Tag bis zur Fälligkeit.';

  @override
  String addReminderNotifDays(int days) {
    return 'Noch $days Tage bis zur Fälligkeit.';
  }

  @override
  String get addReminderNotifWeek => 'Noch 1 Woche bis zur Fälligkeit.';

  @override
  String addReminderNotifWeeks(int weeks) {
    return 'Noch $weeks Wochen bis zur Fälligkeit.';
  }

  @override
  String addReminderSaveFailed(String error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get kmReminderBodyDue => 'Wartung fällig! Kilometerstand erreicht.';

  @override
  String kmReminderBodyKmLeft(int km) {
    return 'Noch $km km bis zur Fälligkeit.';
  }

  @override
  String get historyTitle => 'Wartungshistorie';

  @override
  String get historyEmpty => 'Noch keine Historie';

  @override
  String get historyEmptyHint =>
      'Sobald du eine Erinnerung als erledigt markierst, landet sie hier.';

  @override
  String get historyDeleteTitle => 'Eintrag löschen?';

  @override
  String get historyDeleteBody =>
      'Der Eintrag wird dauerhaft aus der Historie entfernt.';

  @override
  String get historyDeleted => 'Eintrag gelöscht';

  @override
  String historyCompletedOn(String date) {
    return 'Erledigt am $date';
  }

  @override
  String historyMileageAt(String km) {
    return 'Kilometerstand: $km km';
  }

  @override
  String historyWorkshop(String name) {
    return 'Werkstatt: $name';
  }

  @override
  String historyCost(String amount) {
    return 'Kosten: $amount €';
  }

  @override
  String get consumablesTitle => 'Verbrauchsmaterial';

  @override
  String get consumablesEmpty => 'Noch keine Specs';

  @override
  String get consumablesEmptyHint =>
      'Hinterlege Öl-, Kühlmittel- und Bremsflüssigkeits-Specs deines Autos, damit du sie beim Werkstattbesuch parat hast.';

  @override
  String get consumablesAddButton => 'Specs hinzufügen';

  @override
  String consumablesHintWithVehicle(int year, String make, String model) {
    return 'Specs für $year $make $model — tippe auf \"Kopieren\", um sie an die Werkstatt zu schicken.';
  }

  @override
  String get consumablesHintGeneral =>
      'Specs für die Werkstatt — tippe auf \"Kopieren\", um sie weiterzugeben.';

  @override
  String get consumablesEngineOil => 'Motoröl';

  @override
  String get consumablesOilVolume => 'Öl-Füllmenge';

  @override
  String get consumablesCoolant => 'Kühlmittel';

  @override
  String get consumablesBrakeFluid => 'Bremsflüssigkeit';

  @override
  String get consumablesTransmissionFluid => 'Getriebeöl';

  @override
  String get consumablesCopyAll => 'Alle Specs kopieren';

  @override
  String get consumablesCopied => 'Specs in die Zwischenablage kopiert';

  @override
  String get consumablesEditTitle => 'Specs bearbeiten';

  @override
  String get consumablesCreateTitle => 'Specs anlegen';

  @override
  String get consumablesOilGradeLabel => 'Motoröl-Viskosität';

  @override
  String get consumablesOilGradePlaceholder => 'z. B. 5W-30';

  @override
  String get consumablesOilVolumeLabel => 'Öl-Füllmenge (Liter)';

  @override
  String get consumablesOilVolumePlaceholder => 'z. B. 4.5';

  @override
  String get consumablesCoolantLabel => 'Kühlmittel';

  @override
  String get consumablesCoolantPlaceholder => 'z. B. G12++';

  @override
  String get consumablesBrakeFluidLabel => 'Bremsflüssigkeit';

  @override
  String get consumablesBrakeFluidPlaceholder => 'z. B. DOT 4';

  @override
  String get consumablesTransFluidLabel => 'Getriebeöl';

  @override
  String get consumablesTransFluidPlaceholder => 'z. B. ATF 3+';

  @override
  String consumablesCopyHeader(String header) {
    return 'AutoMate – $header';
  }

  @override
  String consumablesCopyOilGrade(String value) {
    return 'Motoröl: $value';
  }

  @override
  String consumablesCopyOilVolume(String value) {
    return 'Öl-Füllmenge: $value l';
  }

  @override
  String consumablesCopyCoolant(String value) {
    return 'Kühlmittel: $value';
  }

  @override
  String consumablesCopyBrakeFluid(String value) {
    return 'Bremsflüssigkeit: $value';
  }

  @override
  String consumablesCopyTransFluid(String value) {
    return 'Getriebeöl: $value';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsApiKeysSection => 'API-Schlüssel';

  @override
  String get settingsApiKeysHint =>
      'Die Schlüssel werden nur lokal auf deinem Gerät gespeichert. Du brauchst sie, um die KI-Features und die YouTube-Tutorials zu nutzen.';

  @override
  String get settingsGeminiKeyLabel => 'Gemini API-Key (Google AI)';

  @override
  String get settingsGeminiKeyHint => 'AIza…';

  @override
  String get settingsGeminiKeyLink => 'Key bei Google AI Studio anlegen';

  @override
  String get settingsYouTubeKeyLabel => 'YouTube Data API v3 Key';

  @override
  String get settingsYouTubeKeyLink => 'Key bei Google Cloud anlegen';

  @override
  String get settingsNotificationsSection => 'Benachrichtigungen';

  @override
  String get settingsNotificationsActive => 'Benachrichtigungen sind aktiv';

  @override
  String get settingsNotificationsDisabled =>
      'Benachrichtigungen sind deaktiviert';

  @override
  String get settingsNotificationsActiveHint =>
      'Du bekommst Erinnerungen zu fälligen Wartungen.';

  @override
  String get settingsPwaNotificationsHint =>
      'Fallen nur, solange die PWA geöffnet ist.';

  @override
  String get settingsNotificationsNoPermission =>
      'Ohne Berechtigung kann AutoMate dich nicht erinnern.';

  @override
  String get settingsAllowNotifications => 'Erlauben';

  @override
  String get settingsSendTestNotification => 'Test-Benachrichtigung senden';

  @override
  String get settingsScheduleTestNotification => 'Geplanten Test in 2 Minuten';

  @override
  String get settingsDefaultRemindersHint =>
      'Standard-Erinnerungszeitpunkte vor Fälligkeit. Lässt sich pro Erinnerung überschreiben.';

  @override
  String get settingsReportSection => 'Werkstattbericht';

  @override
  String get settingsReportLanguageLabel => 'Berichtsprache';

  @override
  String get settingsReportLanguageHint =>
      'Nützlich wenn du im Ausland liegen bleibst.';

  @override
  String get settingsSaveButton => 'Speichern';

  @override
  String get settingsWebWarning =>
      'Du nutzt die Web-Version. Sprach-Assistent, OBD-II und Kamera-Scan funktionieren nur in der Mobile-App.';

  @override
  String get settingsSaved => 'Einstellungen gespeichert';

  @override
  String get settingsPermissionDenied =>
      'Berechtigung abgelehnt. Öffne die Systemeinstellungen, um sie zu erlauben.';

  @override
  String get settingsPermissionError => 'Benachrichtigungen nicht erlaubt.';

  @override
  String get settingsNotificationsWork => 'Benachrichtigungen funktionieren.';

  @override
  String get settingsTestSent => 'Test-Benachrichtigung gesendet';

  @override
  String get settingsScheduledNotification =>
      'Geplante Benachrichtigung nach 2 Minuten.';

  @override
  String get settingsScheduledPwa =>
      'Test in 2 Min geplant — die PWA muss offen bleiben.';

  @override
  String get settingsScheduledMobile => 'Test in 2 Min geplant.';

  @override
  String settingsScheduleFailed(String error) {
    return 'Planung fehlgeschlagen: $error';
  }

  @override
  String get settingsLangDe => 'Deutsch';

  @override
  String get settingsLangEn => 'Englisch';

  @override
  String get settingsLangFr => 'Französisch';

  @override
  String get settingsLangEs => 'Spanisch';

  @override
  String get settingsLangIt => 'Italienisch';

  @override
  String get profileTitle => 'PROFIL';

  @override
  String get profileName => 'Name';

  @override
  String get profileMemberSince => 'Mitglied seit';

  @override
  String get profileSkillLevel => 'Skill Level';

  @override
  String profileMemberSinceDate(String date) {
    return 'Dabei seit $date';
  }

  @override
  String get profileSettingsSection => 'EINSTELLUNGEN';

  @override
  String get profileChangeSkillLevel => 'Skill Level ändern';

  @override
  String get profileApiAndLanguage => 'API-Keys & Sprache';

  @override
  String get profileApiAndLanguageHint => 'Gemini, YouTube, Berichtsprache';

  @override
  String get profileLogout => 'Abmelden';

  @override
  String get profileChangeSkillLevelTitle => 'Skill Level ändern';

  @override
  String get profileChangeSkillLevelBody =>
      'Möchtest du dein Skill Level wirklich anpassen?\nAutoMate passt alle Empfehlungen und Erklärungen entsprechend an.';

  @override
  String get profileChangeSkillLevelYes => 'Ja, anpassen';

  @override
  String get profileSelectSkillLevel => 'Wähle dein Skill Level';

  @override
  String get skillLevelBeginnerFeatures =>
      'Werkstatt-Empfehlungen, einfache Erklärungen';

  @override
  String get skillLevelIntermediateFeatures => 'Tutorials, DIY mit Anleitung';

  @override
  String get skillLevelProFeatures => 'Technische Details, volle Kontrolle';

  @override
  String get tutorialsTitle => 'Reparatur-Tutorials';

  @override
  String get tutorialsNoVehicle => 'Kein Fahrzeug';

  @override
  String tutorialsVehicleLabel(int year, String make, String model) {
    return 'Für: $year $make $model';
  }

  @override
  String get tutorialsSearchPlaceholder =>
      'z. B. Bremsen wechseln, Ölwechsel, Zündkerzen';

  @override
  String get tutorialsBeginnerTip =>
      'Einsteiger-Tipp: Arbeite bei komplexen Reparaturen lieber mit einer Werkstatt.';

  @override
  String get tutorialsIntermediateTip =>
      'Lesbare Schritt-für-Schritt-Videos für dein Level werden bevorzugt.';

  @override
  String get tutorialsProTip =>
      'Für dich: Suche ruhig spezifische Begriffe (z. B. \"ZKD wechseln\").';

  @override
  String get tutorialsEmptyHint =>
      'Gib oben ein, was du reparieren willst, und wir suchen passende Videos.';

  @override
  String get tutorialsNothingFound => 'Nichts gefunden';

  @override
  String get videoPlayerTip =>
      'Tipp: Sieh dir das Video einmal komplett an, bevor du loslegst. Notiere benötigte Werkzeuge und Teile.';

  @override
  String get workshopTitle => 'Werkstattbericht';

  @override
  String get workshopSharePdf => 'Als PDF teilen';

  @override
  String get workshopNoVehicle => 'Kein Fahrzeug';

  @override
  String get workshopDescription =>
      'Beschreibe kurz das Problem — die KI erstellt einen strukturierten Bericht, den du dem Mechaniker geben kannst.';

  @override
  String get workshopSymptomsLabel => 'Symptome';

  @override
  String get workshopSymptomsPlaceholder =>
      'z. B. \"Seit gestern ruckelt der Motor bei 60 km/h, Motorkontrollleuchte blinkt gelb, Geruch nach Benzin.\"';

  @override
  String get workshopAnalyzing => 'Analysiere…';

  @override
  String get workshopGenerateButton => 'Bericht erstellen';

  @override
  String get workshopAnalysisTitle => 'Analyse';

  @override
  String get workshopPdfTitle => 'AutoMate — Werkstattbericht';

  @override
  String get workshopPdfSymptomsLabel => 'Beobachtete Symptome:';

  @override
  String get workshopPdfAnalysisLabel => 'Analyse:';

  @override
  String get workshopPdfFooter =>
      'Erstellt mit AutoMate · KI-Analyse zur Orientierung · Ersetzt keine professionelle Diagnose.';

  @override
  String workshopPdfFilename(String make, String model) {
    return 'werkstattbericht_${make}_$model.pdf';
  }

  @override
  String get breakdownTitle => 'Pannen-Assistent';

  @override
  String get breakdownTts => 'Sprachausgabe';

  @override
  String get breakdownFindGarage => 'Werkstatt finden';

  @override
  String get breakdownNoVehicle => 'Kein Fahrzeug';

  @override
  String breakdownPlaceholder(String make) {
    return 'Was ist los mit deinem $make?';
  }

  @override
  String get breakdownExamplesTitle =>
      'Sprich oder tippe dein Problem. Beispiele:';

  @override
  String get breakdownExample1Beginner =>
      'Die Motorkontrollleuchte blinkt gelb';

  @override
  String get breakdownExample2Beginner => 'Das Auto springt nicht an';

  @override
  String get breakdownExample3Beginner =>
      'Ich höre ein Quietschen beim Bremsen';

  @override
  String get breakdownExample1Intermediate => 'Fehlercode P0420 — was tun?';

  @override
  String get breakdownExample2Intermediate =>
      'Bremsen wechseln — was brauche ich?';

  @override
  String get breakdownExample3Intermediate =>
      'Ölwechsel selbst machen, was beachten?';

  @override
  String get breakdownExample1Pro =>
      'Lambda-Sonde vorne vs. hinten — Unterschiede';

  @override
  String get breakdownExample2Pro =>
      'Kompressionswerte Bank 1 niedrig, Diagnoseschritte';

  @override
  String get breakdownExample3Pro =>
      'Zweimassenschwungrad wechseln — Werkzeuge';

  @override
  String get breakdownWebWarning =>
      'Sprachsteuerung und Sprachausgabe sind nur in der Mobile-App verfügbar. Im Browser kannst du trotzdem tippen.';

  @override
  String get breakdownInputPlaceholder => 'Problem beschreiben…';

  @override
  String get garageFinderTitle => 'Werkstätten in der Nähe';

  @override
  String get garageFinderDefault => 'Werkstatt';

  @override
  String get garageFinderShowOnMap => 'Auf Karte zeigen';

  @override
  String garageFinderFound(int count) {
    return '$count Werkstätten gefunden';
  }

  @override
  String get garageFinderNoLocation =>
      'Kein Standort verfügbar — Suche um Deutschland-Mitte.';

  @override
  String get settingsAppLanguageSection => 'App-Sprache';

  @override
  String get settingsAppLanguageLabel => 'Anzeigesprache';

  @override
  String get settingsAppLanguageSystem => 'Systemsprache';

  @override
  String get settingsLangHr => 'Kroatisch';

  @override
  String get navGarage => 'Garage';

  @override
  String get navMaintenance => 'Wartung';

  @override
  String get navAssistant => 'Assistent';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSelectVehicle => 'Fahrzeug auswählen';
}
