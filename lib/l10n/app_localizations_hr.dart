// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'AutoMate';

  @override
  String get commonSave => 'Spremi';

  @override
  String get commonSaving => 'Sprema se…';

  @override
  String get commonCancel => 'Odustani';

  @override
  String get commonDelete => 'Obriši';

  @override
  String get commonBack => 'Natrag';

  @override
  String get commonEdit => 'Uredi';

  @override
  String get commonAdd => 'Dodaj';

  @override
  String commonError(String error) {
    return 'Greška: $error';
  }

  @override
  String get commonNoVehicle => 'Nema vozila';

  @override
  String get fuelTypePetrol => 'Benzin';

  @override
  String get fuelTypeDiesel => 'Dizel';

  @override
  String get fuelTypeElectric => 'Električno';

  @override
  String get fuelTypeHybrid => 'Hibrid';

  @override
  String get fuelTypeOther => 'Ostalo';

  @override
  String get fuelGradeSuperE5 => 'Super E5 (95)';

  @override
  String get fuelGradeSuperE10 => 'Super E10 (95)';

  @override
  String get fuelGradeSuperPlus => 'Super Plus (98)';

  @override
  String get fuelGradePremium => 'Premium (100)';

  @override
  String get fuelGradeDieselB7 => 'Dizel B7';

  @override
  String get fuelGradeDieselPremium => 'Premium Dizel';

  @override
  String get reminderTypeOilChange => 'Izmjena ulja';

  @override
  String get reminderTypeTuev => 'Tehnički pregled';

  @override
  String get reminderTypeMajorService => 'Veliki servis';

  @override
  String get reminderTypeMinorService => 'Mali servis';

  @override
  String get reminderTypeTyreSwap => 'Zamjena guma';

  @override
  String get reminderTypeCustom => 'Ostalo';

  @override
  String get skillLevelBeginner => 'Početnik';

  @override
  String get skillLevelIntermediate => 'Napredni';

  @override
  String get skillLevelPro => 'Profesionalac';

  @override
  String get onboardingWelcomeTitle => 'Dobrodošli u\nAutoMate';

  @override
  String get onboardingWelcomeSubtitle =>
      'Vaš pratilac za održavanje,\nporavke i kvarove.';

  @override
  String get onboardingNameLabel => 'Vaše ime';

  @override
  String get onboardingNameError => 'Molimo unesite svoje ime';

  @override
  String get onboardingStartButton => 'Počnimo';

  @override
  String get onboardingStartingButton => 'Trenutak…';

  @override
  String get skillQuizIntro =>
      'Kako bi AutoMate mogao dati prave preporuke, odgovorite na 5 kratkih pitanja. Traje manje od minute.';

  @override
  String skillQuizProgress(int current, int total) {
    return 'Pitanje $current od $total';
  }

  @override
  String get skillQuizNext => 'Dalje';

  @override
  String get skillQuizEvaluate => 'Procijeni';

  @override
  String skillQuizHello(String firstName) {
    return 'Zdravo, $firstName!';
  }

  @override
  String get skillQuizHelloGeneric => 'Zdravo!';

  @override
  String get skillQuiz1Question => 'Upali se kontrolna lampica. Što radite?';

  @override
  String get skillQuiz1Answer1 => 'Odmah u servis — bolje biti siguran.';

  @override
  String get skillQuiz1Answer2 => 'Pogledam značenje i sam odlučim.';

  @override
  String get skillQuiz1Answer3 =>
      'Očitam kôd greške OBD uređajem i analiziram ga.';

  @override
  String get skillQuiz2Question =>
      'Kada sami provjeravate razinu motornog ulja?';

  @override
  String get skillQuiz2Answer1 =>
      'Nikad — to radi servis pri sljedećem servisu.';

  @override
  String get skillQuiz2Answer2 =>
      'Ponekad, prije dugih vožnji ili kada se sjetim.';

  @override
  String get skillQuiz2Answer3 =>
      'Redovito — znam tipičnu potrošnju ulja svog motora.';

  @override
  String get skillQuiz3Question => 'Jeste li ikad sami radili na svom autu?';

  @override
  String get skillQuiz3Answer1 => 'Ne, to uvijek prepuštam stručnjacima.';

  @override
  String get skillQuiz3Answer2 =>
      'Da, jednostavne stvari poput brisača, žarulja ili filtera zraka.';

  @override
  String get skillQuiz3Answer3 =>
      'Da, uključujući složenije radove — npr. kočnice, kvačilo ili ovjes.';

  @override
  String get skillQuiz4Question =>
      'Vaš auto pravi nepoznatu buku. Što prvo radite?';

  @override
  String get skillQuiz4Answer1 => 'Zovem servis — ne želim riskirati.';

  @override
  String get skillQuiz4Answer2 =>
      'Pokušavam opisati buku i tražim uzroke online.';

  @override
  String get skillQuiz4Answer3 =>
      'Sustavno lociram buku i sam provjeravate zahvaćene dijelove.';

  @override
  String get skillQuiz5Question =>
      'Koliko ste upoznati s motornim prostorom vašeg auta?';

  @override
  String get skillQuiz5Answer1 =>
      'Otvorim haubu uglavnom samo za punjenje tekućine za pranje.';

  @override
  String get skillQuiz5Answer2 =>
      'Poznajem glavne dijelove i redovito provjeravate razine ulja i rashladne tekućine.';

  @override
  String get skillQuiz5Answer3 =>
      'Poznajem raspored i funkciju te mogu samostalno zamijeniti mnoge dijelove.';

  @override
  String get skillResultTitle => 'Vaša razina znanja:';

  @override
  String get skillResultBeginnerDesc =>
      'Oslanjate se na stručnjake — to je pametno i sigurno. AutoMate vam daje jasne smjernice kada posjetiti servis i sve objašnjava razumljivo bez žargona.';

  @override
  String get skillResultBeginnerFeatures =>
      'Preporuke servisa, jednostavna objašnjenja';

  @override
  String get skillResultIntermediateDesc =>
      'Dobro poznajete svoj auto i volite se sami uhvatiti posla. AutoMate vam prikazuje odgovarajuće tutorijale za popravke i pomaže pronaći prave dijelove — korak po korak.';

  @override
  String get skillResultIntermediateFeatures => 'Tutorijali, DIY s uputama';

  @override
  String get skillResultProDesc =>
      'Točno znate što se događa ispod haube. AutoMate vam pruža tehničke detalje, kôdove grešaka u sirovom obliku i punu kontrolu — bez pojednostavljivanja.';

  @override
  String get skillResultProFeatures =>
      'Tehnički detalji, OBD podaci, puna kontrola';

  @override
  String skillResultFitsQuestion(String firstName) {
    return 'Odgovara li vam to, $firstName?';
  }

  @override
  String get skillResultFitsQuestionNoName => 'Odgovara li vam to?';

  @override
  String get skillResultYes => 'Da, odgovara!';

  @override
  String get skillResultNo => 'Ne, želim prilagoditi';

  @override
  String get skillResultSelectLevel => 'Odaberite razinu';

  @override
  String get skillResultAdjustLater => 'Uvijek možete promijeniti u profilu.';

  @override
  String get dashboardTitle => 'AutoMate';

  @override
  String get dashboardAddVehicle => 'Dodaj vozilo';

  @override
  String get dashboardNoVehicle => 'Još nema vozila';

  @override
  String get dashboardNoVehicleHint => 'Dodajte svoje prvo vozilo.';

  @override
  String get vehicleSetupTitle => 'Dodaj vozilo';

  @override
  String get vehicleSetupSectionData => 'Podaci o vozilu';

  @override
  String get vehicleSetupSectionHint =>
      'Osnovni podaci o vašem autu. Bez VIN-a nema problema — nije obavezno.';

  @override
  String get vehicleSetupYear => 'Godina *';

  @override
  String get vehicleSetupMake => 'Marka *';

  @override
  String get vehicleSetupMakePlaceholder => 'npr. Ford, Toyota, BMW';

  @override
  String get vehicleSetupMakeLoading => 'Učitavanje…';

  @override
  String get vehicleSetupModelDisabled => 'Model * (prvo odaberite marku)';

  @override
  String get vehicleSetupModel => 'Model *';

  @override
  String get vehicleSetupModelPlaceholder => 'npr. Golf, Corolla, 3 serija';

  @override
  String get vehicleSetupVin => 'VIN (neobavezno)';

  @override
  String get vehicleSetupVinHint => '17-znamenkasti VIN iz prometne dozvole';

  @override
  String get vehicleSetupFuel => 'Gorivo *';

  @override
  String get vehicleSetupMileage => 'Trenutna kilometraža *';

  @override
  String get vehicleSetupAnnualKm => 'Procijenjeni km godišnje (neobavezno)';

  @override
  String get vehicleSetupAnnualKmHint =>
      'Pomaže u izračunu intervala održavanja';

  @override
  String get vehicleSetupAnnualKmSuffix => 'km/god.';

  @override
  String get vehicleSetupSaveButton => 'Spremi vozilo';

  @override
  String get vehicleSetupSavingButton => 'Sprema se…';

  @override
  String get vehicleDetailMoreActions => 'Više radnji';

  @override
  String get vehicleDetailNotFound => 'Vozilo nije pronađeno.';

  @override
  String get vehicleDetailUpdateMileage => 'Ažuriraj kilometražu';

  @override
  String get vehicleDetailDeleteVehicle => 'Obriši vozilo';

  @override
  String get vehicleDetailSectionMaintenance => 'Održavanje';

  @override
  String get vehicleDetailFuelTitle => 'Gorivo i potrošnja';

  @override
  String get vehicleDetailFuelSubtitle =>
      'Bilježi punjenja · izračunaj potrošnju';

  @override
  String get vehicleDetailRemindersTitle => 'Podsjetnici';

  @override
  String get vehicleDetailRemindersSubtitle =>
      'Rokovi za izmjenu ulja, tehnički pregled, servise';

  @override
  String get vehicleDetailHistoryTitle => 'Povijest održavanja';

  @override
  String get vehicleDetailHistorySubtitle => 'Svi obavljeni radovi';

  @override
  String get vehicleDetailConsumablesTitle => 'Potrošni materijal';

  @override
  String get vehicleDetailConsumablesSubtitle =>
      'Ulje, rashladna tekućina, tekućina za kočnice — kopiraj';

  @override
  String get vehicleDetailSectionRepair => 'Popravci i kvarovi';

  @override
  String get vehicleDetailTutorialsTitle => 'Tutorijali za popravke';

  @override
  String get vehicleDetailTutorialsSubtitle =>
      'YouTube videozapisi za vaš model';

  @override
  String get vehicleDetailReportTitle => 'Izvještaj za servis';

  @override
  String get vehicleDetailReportSubtitle =>
      'AI generira PDF dijagnozu za mehaničara';

  @override
  String get vehicleDetailBreakdownTitle => 'Asistent za kvarove';

  @override
  String get vehicleDetailBreakdownSubtitle =>
      'AI chat na cesti · glasovne naredbe';

  @override
  String get vehicleDetailGaragesTitle => 'Pronađi servis';

  @override
  String get vehicleDetailGaragesSubtitle =>
      'Pretraga na karti u vašoj blizini';

  @override
  String get vehicleDetailUpdateMileageTitle => 'Ažuriraj kilometražu';

  @override
  String get vehicleDetailCurrentMileageLabel => 'Trenutna kilometraža';

  @override
  String get vehicleDetailDeleteTitle => 'Obriši vozilo?';

  @override
  String vehicleDetailDeleteBody(int year, String make, String model) {
    return '$year $make $model i svi povezani podsjetnici, unosi povijesti i specifikacije potrošnog materijala bit će trajno uklonjeni.';
  }

  @override
  String vehicleDetailMileageUpdated(String km) {
    return 'Kilometraža ažurirana na $km km';
  }

  @override
  String get vehicleDetailDeleted => 'Vozilo obrisano';

  @override
  String get vehicleDetailKmLabel => 'Kilometraža';

  @override
  String get vehicleDetailYearLabel => 'Godina';

  @override
  String get vehicleDetailVinLabel => 'VIN';

  @override
  String get fuelScreenTitle => 'Gorivo i potrošnja';

  @override
  String get fuelScreenAddButton => 'Dodaj punjenje';

  @override
  String get fuelScreenAllEntries => 'Sva punjenja';

  @override
  String get fuelScreenEmptyTitle => 'Još nema punjenja';

  @override
  String get fuelScreenEmptyBody =>
      'Dodajte prvo punjenje\nza izračun potrošnje.';

  @override
  String get fuelScreenNotAvailableTitle => 'Nije dostupno';

  @override
  String get fuelScreenNotAvailableBody =>
      'Dnevnik goriva dostupan je samo za benzinska, dizelska i hibridna vozila.';

  @override
  String get fuelScreenStatConsumption => 'Prosj. potrošnja';

  @override
  String get fuelScreenStatKmPerYear => 'Prosj. km/god';

  @override
  String get fuelScreenStatTotalCost => 'Ukupni trošak';

  @override
  String get fuelScreenDeleteTitle => 'Obriši unos?';

  @override
  String get fuelSheetTitle => 'Dodaj punjenje';

  @override
  String get fuelSheetFieldGrade => 'Vrsta goriva';

  @override
  String get fuelSheetFieldLiters => 'Litara natočeno';

  @override
  String get fuelSheetFieldTotalPrice => 'Ukupna cijena';

  @override
  String get fuelSheetFieldOdometer => 'Kilometraža pri punjenju';

  @override
  String get fuelSheetFullTankLabel => 'Puni rezervoar';

  @override
  String get fuelSheetFullTankHint => 'Za precizan izračun potrošnje';

  @override
  String get fuelSheetSave => 'Spremi';

  @override
  String get fuelSheetSaving => 'Sprema se…';

  @override
  String get remindersTitle => 'Podsjetnici';

  @override
  String get remindersNew => 'Novo';

  @override
  String get remindersEmpty => 'Nema podsjetnika';

  @override
  String get remindersEmptyHint =>
      'Dodajte podsjetnik za izmjenu ulja, tehnički pregled i sl.';

  @override
  String get remindersMarkDone => 'Označi kao gotovo';

  @override
  String remindersMarkDoneConfirm(String label) {
    return 'Označiti \"$label\" kao gotovo?';
  }

  @override
  String get remindersMarkedDone => 'Označeno kao gotovo';

  @override
  String get remindersDeleteTitle => 'Obriši podsjetnik?';

  @override
  String remindersDeleteBody(String label) {
    return 'Podsjetnik \"$label\" i sve povezane obavijesti bit će uklonjene.';
  }

  @override
  String get remindersDeleted => 'Podsjetnik obrisan';

  @override
  String remindersOverdue(int days) {
    return '$days dana zakašnjenja';
  }

  @override
  String get remindersDueToday => 'Dospijeće danas!';

  @override
  String get remindersDueTomorrow => 'Dospijeće sutra';

  @override
  String remindersDueInDays(int days, String date) {
    return 'Za $days dana · $date';
  }

  @override
  String remindersDueInWeeks(int weeks, String date) {
    return 'Za $weeks tjedana · $date';
  }

  @override
  String remindersKmOverdue(String km) {
    return 'Dosegnuta km granica! ($km km)';
  }

  @override
  String remindersKmDueAt(String due, String kmLeft, String current) {
    return 'Na $due km · još $kmLeft km (sada $current km)';
  }

  @override
  String remindersKmWithWarning(String base, String km) {
    return '$base · upozorenje od $km km';
  }

  @override
  String get addReminderTitle => 'Novi podsjetnik';

  @override
  String get addReminderTypeLabel => 'Vrsta održavanja';

  @override
  String get addReminderCustomLabel => 'Vlastiti naziv';

  @override
  String get addReminderCustomPlaceholder => 'npr. Zamjena filtera polena';

  @override
  String get addReminderDueDateLabel => 'Datum dospijeća';

  @override
  String get addReminderDueDateHint => 'Dodirnite za promjenu';

  @override
  String get addReminderDueMileageLabel =>
      'Dospijeće po kilometraži (neobavezno)';

  @override
  String get addReminderDueMileageHint =>
      'Ako održavanje ovisi i o kilometraži';

  @override
  String get addReminderKmOffsetLabel => 'Km prethopredno upozorenje';

  @override
  String get addReminderKmOffsetHint => 'Obavijest X km prije km dospijeća';

  @override
  String get addReminderAtDue => 'Točno na datum dospijeća';

  @override
  String addReminderKmBefore(int km) {
    return '$km km ranije';
  }

  @override
  String get addReminderNotificationsLabel => 'Obavijesti';

  @override
  String get addReminderNotificationsHint =>
      'Kada želite biti podsjetnik prije dospijeća?';

  @override
  String get addReminderCustomTimeLabel => 'Vlastito vrijeme';

  @override
  String get addReminderDaysSuffix => 'dana';

  @override
  String get addReminderNoNotifications =>
      'Nema aktivnih obavijesti — podsjetnik će biti prikazan samo na popisu.';

  @override
  String get addReminderSaveButton => 'Stvori podsjetnik';

  @override
  String get addReminderSavingButton => 'Sprema se…';

  @override
  String get addReminderCustomNameError =>
      'Molimo unesite naziv za vlastiti podsjetnik.';

  @override
  String get addReminderNotificationsDisabledTitle => 'Obavijesti onemogućene';

  @override
  String get addReminderNotificationsDisabledBody =>
      'Bez obavijesti AutoMate vas ne može podsjetiti na nadolazeća održavanja. Dopuštenje možete dati u sistemskim postavkama.';

  @override
  String get addReminderSaveAnyway => 'Svejedno spremi';

  @override
  String get addReminderOpenSettings => 'Otvori postavke';

  @override
  String get addReminderDay => '1 dan';

  @override
  String addReminderDays(int days) {
    return '$days dana';
  }

  @override
  String get addReminderWeek => '1 tjedan';

  @override
  String addReminderWeeks(int weeks) {
    return '$weeks tjedana';
  }

  @override
  String get addReminderNotifDay => 'Još 1 dan do dospijeća.';

  @override
  String addReminderNotifDays(int days) {
    return 'Još $days dana do dospijeća.';
  }

  @override
  String get addReminderNotifWeek => 'Još 1 tjedan do dospijeća.';

  @override
  String addReminderNotifWeeks(int weeks) {
    return 'Još $weeks tjedana do dospijeća.';
  }

  @override
  String addReminderSaveFailed(String error) {
    return 'Spremanje neuspješno: $error';
  }

  @override
  String get kmReminderBodyDue => 'Servis dospio! Dostignut kilometarski prag.';

  @override
  String kmReminderBodyKmLeft(int km) {
    return 'Još $km km do roka.';
  }

  @override
  String get historyTitle => 'Povijest održavanja';

  @override
  String get historyEmpty => 'Još nema povijesti';

  @override
  String get historyEmptyHint =>
      'Kada označite podsjetnik kao gotov, pojavit će se ovdje.';

  @override
  String get historyDeleteTitle => 'Obriši unos?';

  @override
  String get historyDeleteBody => 'Unos će biti trajno uklonjen iz povijesti.';

  @override
  String get historyDeleted => 'Unos obrisan';

  @override
  String historyCompletedOn(String date) {
    return 'Obavljeno $date';
  }

  @override
  String historyMileageAt(String km) {
    return 'Kilometraža: $km km';
  }

  @override
  String historyWorkshop(String name) {
    return 'Servis: $name';
  }

  @override
  String historyCost(String amount) {
    return 'Trošak: $amount €';
  }

  @override
  String get consumablesTitle => 'Potrošni materijal';

  @override
  String get consumablesEmpty => 'Još nema specifikacija';

  @override
  String get consumablesEmptyHint =>
      'Dodajte specifikacije ulja, rashladne tekućine i tekućine za kočnice za vaš auto.';

  @override
  String get consumablesAddButton => 'Dodaj specifikacije';

  @override
  String consumablesHintWithVehicle(int year, String make, String model) {
    return 'Specifikacije za $year $make $model — dodirnite \"Kopiraj\" za slanje servisu.';
  }

  @override
  String get consumablesHintGeneral =>
      'Specifikacije za servis — dodirnite \"Kopiraj\" za dijeljenje.';

  @override
  String get consumablesEngineOil => 'Motorno ulje';

  @override
  String get consumablesOilVolume => 'Kapacitet ulja';

  @override
  String get consumablesCoolant => 'Rashladna tekućina';

  @override
  String get consumablesBrakeFluid => 'Tekućina za kočnice';

  @override
  String get consumablesTransmissionFluid => 'Ulje mjenjača';

  @override
  String get consumablesCopyAll => 'Kopiraj sve specifikacije';

  @override
  String get consumablesCopied => 'Specifikacije kopirane u međuspremnik';

  @override
  String get consumablesEditTitle => 'Uredi specifikacije';

  @override
  String get consumablesCreateTitle => 'Dodaj specifikacije';

  @override
  String get consumablesOilGradeLabel => 'Viskoznost motornog ulja';

  @override
  String get consumablesOilGradePlaceholder => 'npr. 5W-30';

  @override
  String get consumablesOilVolumeLabel => 'Kapacitet ulja (litre)';

  @override
  String get consumablesOilVolumePlaceholder => 'npr. 4.5';

  @override
  String get consumablesCoolantLabel => 'Rashladna tekućina';

  @override
  String get consumablesCoolantPlaceholder => 'npr. G12++';

  @override
  String get consumablesBrakeFluidLabel => 'Tekućina za kočnice';

  @override
  String get consumablesBrakeFluidPlaceholder => 'npr. DOT 4';

  @override
  String get consumablesTransFluidLabel => 'Ulje mjenjača';

  @override
  String get consumablesTransFluidPlaceholder => 'npr. ATF 3+';

  @override
  String consumablesCopyHeader(String header) {
    return 'AutoMate – $header';
  }

  @override
  String consumablesCopyOilGrade(String value) {
    return 'Motorno ulje: $value';
  }

  @override
  String consumablesCopyOilVolume(String value) {
    return 'Kapacitet ulja: $value l';
  }

  @override
  String consumablesCopyCoolant(String value) {
    return 'Rashladna tekućina: $value';
  }

  @override
  String consumablesCopyBrakeFluid(String value) {
    return 'Tekućina za kočnice: $value';
  }

  @override
  String consumablesCopyTransFluid(String value) {
    return 'Ulje mjenjača: $value';
  }

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get settingsApiKeysSection => 'API ključevi';

  @override
  String get settingsApiKeysHint =>
      'Ključevi su pohranjeni samo lokalno na vašem uređaju. Potrebni su za korištenje AI funkcija i YouTube tutorijala.';

  @override
  String get settingsGeminiKeyLabel => 'Gemini API ključ (Google AI)';

  @override
  String get settingsGeminiKeyHint => 'AIza…';

  @override
  String get settingsGeminiKeyLink => 'Stvori ključ na Google AI Studio';

  @override
  String get settingsYouTubeKeyLabel => 'YouTube Data API v3 ključ';

  @override
  String get settingsYouTubeKeyLink => 'Stvori ključ na Google Cloud';

  @override
  String get settingsNotificationsSection => 'Obavijesti';

  @override
  String get settingsNotificationsActive => 'Obavijesti su aktivne';

  @override
  String get settingsNotificationsDisabled => 'Obavijesti su onemogućene';

  @override
  String get settingsNotificationsActiveHint =>
      'Primit ćete podsjetnike za nadolazeća održavanja.';

  @override
  String get settingsPwaNotificationsHint => 'Radi samo dok je PWA otvorena.';

  @override
  String get settingsNotificationsNoPermission =>
      'Bez dopuštenja AutoMate vas ne može podsjetiti.';

  @override
  String get settingsAllowNotifications => 'Dopusti';

  @override
  String get settingsSendTestNotification => 'Pošalji testnu obavijest';

  @override
  String get settingsScheduleTestNotification => 'Zakaži test za 2 minute';

  @override
  String get settingsDefaultRemindersHint =>
      'Zadana vremena podsjetnika prije dospijeća. Može se nadjačati po podsjetniku.';

  @override
  String get settingsReportSection => 'Izvještaj za servis';

  @override
  String get settingsReportLanguageLabel => 'Jezik izvještaja';

  @override
  String get settingsReportLanguageHint =>
      'Korisno ako ostanete bez auta u inozemstvu.';

  @override
  String get settingsSaveButton => 'Spremi';

  @override
  String get settingsWebWarning =>
      'Koristite web verziju. Glasovni asistent, OBD-II i skeniranje kamerom rade samo u mobilnoj aplikaciji.';

  @override
  String get settingsSaved => 'Postavke spremljene';

  @override
  String get settingsPermissionDenied =>
      'Dopuštenje odbijeno. Otvorite sistemske postavke za aktivaciju.';

  @override
  String get settingsPermissionError => 'Obavijesti nisu dopuštene.';

  @override
  String get settingsNotificationsWork => 'Obavijesti rade.';

  @override
  String get settingsTestSent => 'Testna obavijest poslana';

  @override
  String get settingsScheduledNotification => 'Zakazana obavijest za 2 minute.';

  @override
  String get settingsScheduledPwa =>
      'Test zakazan za 2 min — PWA mora ostati otvorena.';

  @override
  String get settingsScheduledMobile => 'Test zakazan za 2 min.';

  @override
  String settingsScheduleFailed(String error) {
    return 'Zakazivanje neuspješno: $error';
  }

  @override
  String get settingsLangDe => 'Njemački';

  @override
  String get settingsLangEn => 'Engleski';

  @override
  String get settingsLangFr => 'Francuski';

  @override
  String get settingsLangEs => 'Španjolski';

  @override
  String get settingsLangIt => 'Talijanski';

  @override
  String get profileTitle => 'PROFIL';

  @override
  String get profileName => 'Ime';

  @override
  String get profileMemberSince => 'Član od';

  @override
  String get profileSkillLevel => 'Razina znanja';

  @override
  String profileMemberSinceDate(String date) {
    return 'Član od $date';
  }

  @override
  String get profileSettingsSection => 'POSTAVKE';

  @override
  String get profileChangeSkillLevel => 'Promijeni razinu znanja';

  @override
  String get profileApiAndLanguage => 'API ključevi i jezik';

  @override
  String get profileApiAndLanguageHint => 'Gemini, YouTube, jezik izvještaja';

  @override
  String get profileLogout => 'Odjava';

  @override
  String get profileChangeSkillLevelTitle => 'Promijeni razinu znanja';

  @override
  String get profileChangeSkillLevelBody =>
      'Jeste li sigurni da želite prilagoditi razinu znanja?\nAutoMate će prilagoditi sve preporuke i objašnjenja.';

  @override
  String get profileChangeSkillLevelYes => 'Da, prilagodi';

  @override
  String get profileSelectSkillLevel => 'Odaberite razinu znanja';

  @override
  String get skillLevelBeginnerFeatures =>
      'Preporuke servisa, jednostavna objašnjenja';

  @override
  String get skillLevelIntermediateFeatures => 'Tutorijali, DIY s uputama';

  @override
  String get skillLevelProFeatures => 'Tehnički detalji, puna kontrola';

  @override
  String get tutorialsTitle => 'Tutorijali za popravke';

  @override
  String get tutorialsNoVehicle => 'Nema vozila';

  @override
  String tutorialsVehicleLabel(int year, String make, String model) {
    return 'Za: $year $make $model';
  }

  @override
  String get tutorialsSearchPlaceholder =>
      'npr. zamjena kočnica, izmjena ulja, svjećice';

  @override
  String get tutorialsBeginnerTip =>
      'Savjet za početnike: Za složene popravke radite s servisom.';

  @override
  String get tutorialsIntermediateTip =>
      'Preferiraju se jasni videozapisi korak po korak za vašu razinu.';

  @override
  String get tutorialsProTip =>
      'Za vas: tražite specifične pojmove (npr. \"zamjena brtve glave\").';

  @override
  String get tutorialsEmptyHint =>
      'Unesite gore što želite popraviti i pronaći ćemo odgovarajuće videozapise.';

  @override
  String get tutorialsNothingFound => 'Ništa nije pronađeno';

  @override
  String get videoPlayerTip =>
      'Savjet: Pogledajte video u cijelosti prije nego što počnete. Zabilježite potrebne alate i dijelove.';

  @override
  String get workshopTitle => 'Izvještaj za servis';

  @override
  String get workshopSharePdf => 'Podijeli kao PDF';

  @override
  String get workshopNoVehicle => 'Nema vozila';

  @override
  String get workshopDescription =>
      'Ukratko opišite problem — AI stvara strukturirani izvještaj koji možete dati mehaničaru.';

  @override
  String get workshopSymptomsLabel => 'Simptomi';

  @override
  String get workshopSymptomsPlaceholder =>
      'npr. \"Od jučer motor trza pri 60 km/h, žuto bljeska kontrolna lampica, miris benzina.\"';

  @override
  String get workshopAnalyzing => 'Analizira se…';

  @override
  String get workshopGenerateButton => 'Stvori izvještaj';

  @override
  String get workshopAnalysisTitle => 'Analiza';

  @override
  String get workshopPdfTitle => 'AutoMate — Izvještaj za servis';

  @override
  String get workshopPdfSymptomsLabel => 'Uočeni simptomi:';

  @override
  String get workshopPdfAnalysisLabel => 'Analiza:';

  @override
  String get workshopPdfFooter =>
      'Stvoreno s AutoMate · AI analiza samo kao smjernica · Ne zamjenjuje profesionalnu dijagnozu.';

  @override
  String workshopPdfFilename(String make, String model) {
    return 'izvjestaj_servisa_${make}_$model.pdf';
  }

  @override
  String get breakdownTitle => 'Asistent za kvarove';

  @override
  String get breakdownTts => 'Govorna sinteza';

  @override
  String get breakdownFindGarage => 'Pronađi servis';

  @override
  String get breakdownNoVehicle => 'Nema vozila';

  @override
  String breakdownPlaceholder(String make) {
    return 'Što nije u redu s vašim $make?';
  }

  @override
  String get breakdownExamplesTitle =>
      'Govorite ili tipkajte problem. Primjeri:';

  @override
  String get breakdownExample1Beginner =>
      'Žuto bljeska kontrolna lampica motora';

  @override
  String get breakdownExample2Beginner => 'Auto ne pali';

  @override
  String get breakdownExample3Beginner => 'Čujem škripu pri kočenju';

  @override
  String get breakdownExample1Intermediate => 'Kôd greške P0420 — što učiniti?';

  @override
  String get breakdownExample2Intermediate => 'Zamjena kočnica — što trebam?';

  @override
  String get breakdownExample3Intermediate =>
      'Izmjena ulja samostalno — na što paziti?';

  @override
  String get breakdownExample1Pro =>
      'Lambda sonda sprijeda vs. straga — razlike';

  @override
  String get breakdownExample2Pro =>
      'Niske vrijednosti kompresije Bank 1, dijagnostički koraci';

  @override
  String get breakdownExample3Pro =>
      'Zamjena dvomасenog zamašnjaka — potrebni alati';

  @override
  String get breakdownWebWarning =>
      'Glasovne naredbe i govorna sinteza dostupni su samo u mobilnoj aplikaciji. U pregledniku možete i dalje tipkati.';

  @override
  String get breakdownInputPlaceholder => 'Opišite problem…';

  @override
  String get garageFinderTitle => 'Servisi u blizini';

  @override
  String get garageFinderDefault => 'Servis';

  @override
  String garageFinderFound(int count) {
    return 'Pronađeno $count servisa';
  }

  @override
  String get garageFinderNoLocation =>
      'Lokacija nije dostupna — pretraživanje oko centra Hrvatske.';
}
