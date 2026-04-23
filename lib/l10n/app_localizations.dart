import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
    Locale('hr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AutoMate'**
  String get appTitle;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get commonSaving;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String commonError(String error);

  /// No description provided for @commonNoVehicle.
  ///
  /// In en, this message translates to:
  /// **'No vehicle'**
  String get commonNoVehicle;

  /// No description provided for @fuelTypePetrol.
  ///
  /// In en, this message translates to:
  /// **'Petrol'**
  String get fuelTypePetrol;

  /// No description provided for @fuelTypeDiesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get fuelTypeDiesel;

  /// No description provided for @fuelTypeElectric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get fuelTypeElectric;

  /// No description provided for @fuelTypeHybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get fuelTypeHybrid;

  /// No description provided for @fuelTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get fuelTypeOther;

  /// No description provided for @fuelGradeSuperE5.
  ///
  /// In en, this message translates to:
  /// **'Super E5 (95)'**
  String get fuelGradeSuperE5;

  /// No description provided for @fuelGradeSuperE10.
  ///
  /// In en, this message translates to:
  /// **'Super E10 (95)'**
  String get fuelGradeSuperE10;

  /// No description provided for @fuelGradeSuperPlus.
  ///
  /// In en, this message translates to:
  /// **'Super Plus (98)'**
  String get fuelGradeSuperPlus;

  /// No description provided for @fuelGradePremium.
  ///
  /// In en, this message translates to:
  /// **'Premium (100)'**
  String get fuelGradePremium;

  /// No description provided for @fuelGradeDieselB7.
  ///
  /// In en, this message translates to:
  /// **'Diesel B7'**
  String get fuelGradeDieselB7;

  /// No description provided for @fuelGradeDieselPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium Diesel'**
  String get fuelGradeDieselPremium;

  /// No description provided for @reminderTypeOilChange.
  ///
  /// In en, this message translates to:
  /// **'Oil change'**
  String get reminderTypeOilChange;

  /// No description provided for @reminderTypeTuev.
  ///
  /// In en, this message translates to:
  /// **'MOT / annual inspection'**
  String get reminderTypeTuev;

  /// No description provided for @reminderTypeMajorService.
  ///
  /// In en, this message translates to:
  /// **'Major service'**
  String get reminderTypeMajorService;

  /// No description provided for @reminderTypeMinorService.
  ///
  /// In en, this message translates to:
  /// **'Minor service'**
  String get reminderTypeMinorService;

  /// No description provided for @reminderTypeTyreSwap.
  ///
  /// In en, this message translates to:
  /// **'Tyre swap'**
  String get reminderTypeTyreSwap;

  /// No description provided for @reminderTypeCustom.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reminderTypeCustom;

  /// No description provided for @skillLevelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get skillLevelBeginner;

  /// No description provided for @skillLevelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get skillLevelIntermediate;

  /// No description provided for @skillLevelPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get skillLevelPro;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nAutoMate'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your companion for maintenance,\nrepairs and breakdowns.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get onboardingNameLabel;

  /// No description provided for @onboardingNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get onboardingNameError;

  /// No description provided for @onboardingStartButton.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go'**
  String get onboardingStartButton;

  /// No description provided for @onboardingStartingButton.
  ///
  /// In en, this message translates to:
  /// **'Just a moment…'**
  String get onboardingStartingButton;

  /// No description provided for @skillQuizIntro.
  ///
  /// In en, this message translates to:
  /// **'So AutoMate can give you the right recommendations, answer 5 quick questions. Takes less than a minute.'**
  String get skillQuizIntro;

  /// No description provided for @skillQuizProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String skillQuizProgress(int current, int total);

  /// No description provided for @skillQuizNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get skillQuizNext;

  /// No description provided for @skillQuizEvaluate.
  ///
  /// In en, this message translates to:
  /// **'Evaluate'**
  String get skillQuizEvaluate;

  /// No description provided for @skillQuizHello.
  ///
  /// In en, this message translates to:
  /// **'Hello, {firstName}!'**
  String skillQuizHello(String firstName);

  /// No description provided for @skillQuizHelloGeneric.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get skillQuizHelloGeneric;

  /// No description provided for @skillQuiz1Question.
  ///
  /// In en, this message translates to:
  /// **'A warning light comes on. What do you do?'**
  String get skillQuiz1Question;

  /// No description provided for @skillQuiz1Answer1.
  ///
  /// In en, this message translates to:
  /// **'Head straight to the garage — better safe than sorry.'**
  String get skillQuiz1Answer1;

  /// No description provided for @skillQuiz1Answer2.
  ///
  /// In en, this message translates to:
  /// **'I look up the meaning and decide myself.'**
  String get skillQuiz1Answer2;

  /// No description provided for @skillQuiz1Answer3.
  ///
  /// In en, this message translates to:
  /// **'I read the fault code with an OBD device and analyse it.'**
  String get skillQuiz1Answer3;

  /// No description provided for @skillQuiz2Question.
  ///
  /// In en, this message translates to:
  /// **'When do you check the engine oil level yourself?'**
  String get skillQuiz2Question;

  /// No description provided for @skillQuiz2Answer1.
  ///
  /// In en, this message translates to:
  /// **'Never — the garage handles that at the next service.'**
  String get skillQuiz2Answer1;

  /// No description provided for @skillQuiz2Answer2.
  ///
  /// In en, this message translates to:
  /// **'Occasionally, before long trips or when I think of it.'**
  String get skillQuiz2Answer2;

  /// No description provided for @skillQuiz2Answer3.
  ///
  /// In en, this message translates to:
  /// **'Regularly — I know my engine\'s typical oil consumption precisely.'**
  String get skillQuiz2Answer3;

  /// No description provided for @skillQuiz3Question.
  ///
  /// In en, this message translates to:
  /// **'Have you ever worked on your car yourself?'**
  String get skillQuiz3Question;

  /// No description provided for @skillQuiz3Answer1.
  ///
  /// In en, this message translates to:
  /// **'No, I always leave that to the professionals.'**
  String get skillQuiz3Answer1;

  /// No description provided for @skillQuiz3Answer2.
  ///
  /// In en, this message translates to:
  /// **'Yes, simple things like wipers, bulbs or air filter.'**
  String get skillQuiz3Answer2;

  /// No description provided for @skillQuiz3Answer3.
  ///
  /// In en, this message translates to:
  /// **'Yes, including complex jobs — e.g. brakes, clutch or suspension.'**
  String get skillQuiz3Answer3;

  /// No description provided for @skillQuiz4Question.
  ///
  /// In en, this message translates to:
  /// **'Your car makes an unfamiliar noise. What do you do first?'**
  String get skillQuiz4Question;

  /// No description provided for @skillQuiz4Answer1.
  ///
  /// In en, this message translates to:
  /// **'Call the garage — I don\'t want to take any risks.'**
  String get skillQuiz4Answer1;

  /// No description provided for @skillQuiz4Answer2.
  ///
  /// In en, this message translates to:
  /// **'I try to describe the noise and search online for causes.'**
  String get skillQuiz4Answer2;

  /// No description provided for @skillQuiz4Answer3.
  ///
  /// In en, this message translates to:
  /// **'I systematically locate the noise and check the affected components myself.'**
  String get skillQuiz4Answer3;

  /// No description provided for @skillQuiz5Question.
  ///
  /// In en, this message translates to:
  /// **'How familiar are you with your car\'s engine bay?'**
  String get skillQuiz5Question;

  /// No description provided for @skillQuiz5Answer1.
  ///
  /// In en, this message translates to:
  /// **'I only open the bonnet to top up the windscreen washer.'**
  String get skillQuiz5Answer1;

  /// No description provided for @skillQuiz5Answer2.
  ///
  /// In en, this message translates to:
  /// **'I know the main parts and regularly check oil and coolant levels.'**
  String get skillQuiz5Answer2;

  /// No description provided for @skillQuiz5Answer3.
  ///
  /// In en, this message translates to:
  /// **'I know the layout and function and can replace many parts independently.'**
  String get skillQuiz5Answer3;

  /// No description provided for @skillResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Your skill level:'**
  String get skillResultTitle;

  /// No description provided for @skillResultBeginnerDesc.
  ///
  /// In en, this message translates to:
  /// **'You rely on professionals — that\'s smart and safe. AutoMate gives you clear hints about when to visit a garage, and explains everything in plain language without jargon.'**
  String get skillResultBeginnerDesc;

  /// No description provided for @skillResultBeginnerFeatures.
  ///
  /// In en, this message translates to:
  /// **'Garage recommendations, simple explanations'**
  String get skillResultBeginnerFeatures;

  /// No description provided for @skillResultIntermediateDesc.
  ///
  /// In en, this message translates to:
  /// **'You know your car well and like to get stuck in. AutoMate shows you suitable repair tutorials and helps you find the right parts — step by step.'**
  String get skillResultIntermediateDesc;

  /// No description provided for @skillResultIntermediateFeatures.
  ///
  /// In en, this message translates to:
  /// **'Tutorials, DIY with guidance'**
  String get skillResultIntermediateFeatures;

  /// No description provided for @skillResultProDesc.
  ///
  /// In en, this message translates to:
  /// **'You know exactly what happens under the bonnet. AutoMate delivers technical details, raw fault codes and full control — without dumbing things down.'**
  String get skillResultProDesc;

  /// No description provided for @skillResultProFeatures.
  ///
  /// In en, this message translates to:
  /// **'Technical details, OBD data, full control'**
  String get skillResultProFeatures;

  /// No description provided for @skillResultFitsQuestion.
  ///
  /// In en, this message translates to:
  /// **'Does that fit you, {firstName}?'**
  String skillResultFitsQuestion(String firstName);

  /// No description provided for @skillResultFitsQuestionNoName.
  ///
  /// In en, this message translates to:
  /// **'Does that fit you?'**
  String get skillResultFitsQuestionNoName;

  /// No description provided for @skillResultYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, that fits!'**
  String get skillResultYes;

  /// No description provided for @skillResultNo.
  ///
  /// In en, this message translates to:
  /// **'No, I\'d like to adjust it'**
  String get skillResultNo;

  /// No description provided for @skillResultSelectLevel.
  ///
  /// In en, this message translates to:
  /// **'Choose your level'**
  String get skillResultSelectLevel;

  /// No description provided for @skillResultAdjustLater.
  ///
  /// In en, this message translates to:
  /// **'You can adjust it at any time in your profile.'**
  String get skillResultAdjustLater;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'AutoMate'**
  String get dashboardTitle;

  /// No description provided for @dashboardAddVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add vehicle'**
  String get dashboardAddVehicle;

  /// No description provided for @dashboardNoVehicle.
  ///
  /// In en, this message translates to:
  /// **'No vehicle yet'**
  String get dashboardNoVehicle;

  /// No description provided for @dashboardNoVehicleHint.
  ///
  /// In en, this message translates to:
  /// **'Add your first vehicle.'**
  String get dashboardNoVehicleHint;

  /// No description provided for @vehicleSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Add vehicle'**
  String get vehicleSetupTitle;

  /// No description provided for @vehicleSetupSectionData.
  ///
  /// In en, this message translates to:
  /// **'Vehicle data'**
  String get vehicleSetupSectionData;

  /// No description provided for @vehicleSetupSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Basic details about your car. No VIN? No problem — it\'s optional.'**
  String get vehicleSetupSectionHint;

  /// No description provided for @vehicleSetupYear.
  ///
  /// In en, this message translates to:
  /// **'Year *'**
  String get vehicleSetupYear;

  /// No description provided for @vehicleSetupMake.
  ///
  /// In en, this message translates to:
  /// **'Make *'**
  String get vehicleSetupMake;

  /// No description provided for @vehicleSetupMakePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ford, Toyota, BMW'**
  String get vehicleSetupMakePlaceholder;

  /// No description provided for @vehicleSetupMakeLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get vehicleSetupMakeLoading;

  /// No description provided for @vehicleSetupModelDisabled.
  ///
  /// In en, this message translates to:
  /// **'Model * (select make first)'**
  String get vehicleSetupModelDisabled;

  /// No description provided for @vehicleSetupModel.
  ///
  /// In en, this message translates to:
  /// **'Model *'**
  String get vehicleSetupModel;

  /// No description provided for @vehicleSetupModelPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Golf, Corolla, 3 Series'**
  String get vehicleSetupModelPlaceholder;

  /// No description provided for @vehicleSetupVin.
  ///
  /// In en, this message translates to:
  /// **'VIN (optional)'**
  String get vehicleSetupVin;

  /// No description provided for @vehicleSetupVinHint.
  ///
  /// In en, this message translates to:
  /// **'17-digit VIN, found in your registration document'**
  String get vehicleSetupVinHint;

  /// No description provided for @vehicleSetupFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel *'**
  String get vehicleSetupFuel;

  /// No description provided for @vehicleSetupMileage.
  ///
  /// In en, this message translates to:
  /// **'Current mileage *'**
  String get vehicleSetupMileage;

  /// No description provided for @vehicleSetupAnnualKm.
  ///
  /// In en, this message translates to:
  /// **'Estimated km per year (optional)'**
  String get vehicleSetupAnnualKm;

  /// No description provided for @vehicleSetupAnnualKmHint.
  ///
  /// In en, this message translates to:
  /// **'Helps calculate maintenance intervals'**
  String get vehicleSetupAnnualKmHint;

  /// No description provided for @vehicleSetupAnnualKmSuffix.
  ///
  /// In en, this message translates to:
  /// **'km/year'**
  String get vehicleSetupAnnualKmSuffix;

  /// No description provided for @vehicleSetupSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save vehicle'**
  String get vehicleSetupSaveButton;

  /// No description provided for @vehicleSetupSavingButton.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get vehicleSetupSavingButton;

  /// No description provided for @vehicleDetailMoreActions.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get vehicleDetailMoreActions;

  /// No description provided for @vehicleDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Vehicle not found.'**
  String get vehicleDetailNotFound;

  /// No description provided for @vehicleDetailUpdateMileage.
  ///
  /// In en, this message translates to:
  /// **'Update mileage'**
  String get vehicleDetailUpdateMileage;

  /// No description provided for @vehicleDetailDeleteVehicle.
  ///
  /// In en, this message translates to:
  /// **'Delete vehicle'**
  String get vehicleDetailDeleteVehicle;

  /// No description provided for @vehicleDetailSectionMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get vehicleDetailSectionMaintenance;

  /// No description provided for @vehicleDetailFuelTitle.
  ///
  /// In en, this message translates to:
  /// **'Fuel & Consumption'**
  String get vehicleDetailFuelTitle;

  /// No description provided for @vehicleDetailFuelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log fill-ups · calculate consumption'**
  String get vehicleDetailFuelSubtitle;

  /// No description provided for @vehicleDetailRemindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get vehicleDetailRemindersTitle;

  /// No description provided for @vehicleDetailRemindersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Due dates for oil change, MOT, services'**
  String get vehicleDetailRemindersSubtitle;

  /// No description provided for @vehicleDetailHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Maintenance history'**
  String get vehicleDetailHistoryTitle;

  /// No description provided for @vehicleDetailHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'All completed work'**
  String get vehicleDetailHistorySubtitle;

  /// No description provided for @vehicleDetailConsumablesTitle.
  ///
  /// In en, this message translates to:
  /// **'Consumables'**
  String get vehicleDetailConsumablesTitle;

  /// No description provided for @vehicleDetailConsumablesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Oil, coolant, brake fluid — copy to clipboard'**
  String get vehicleDetailConsumablesSubtitle;

  /// No description provided for @vehicleDetailSectionRepair.
  ///
  /// In en, this message translates to:
  /// **'Repairs & breakdowns'**
  String get vehicleDetailSectionRepair;

  /// No description provided for @vehicleDetailTutorialsTitle.
  ///
  /// In en, this message translates to:
  /// **'Repair tutorials'**
  String get vehicleDetailTutorialsTitle;

  /// No description provided for @vehicleDetailTutorialsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'YouTube videos for your model'**
  String get vehicleDetailTutorialsSubtitle;

  /// No description provided for @vehicleDetailReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Workshop report'**
  String get vehicleDetailReportTitle;

  /// No description provided for @vehicleDetailReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI-generated PDF diagnosis for your mechanic'**
  String get vehicleDetailReportSubtitle;

  /// No description provided for @vehicleDetailBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Breakdown assistant'**
  String get vehicleDetailBreakdownTitle;

  /// No description provided for @vehicleDetailBreakdownSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI chat on the road · voice control'**
  String get vehicleDetailBreakdownSubtitle;

  /// No description provided for @vehicleDetailGaragesTitle.
  ///
  /// In en, this message translates to:
  /// **'Find a garage'**
  String get vehicleDetailGaragesTitle;

  /// No description provided for @vehicleDetailGaragesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Map-based search near you'**
  String get vehicleDetailGaragesSubtitle;

  /// No description provided for @vehicleDetailUpdateMileageTitle.
  ///
  /// In en, this message translates to:
  /// **'Update mileage'**
  String get vehicleDetailUpdateMileageTitle;

  /// No description provided for @vehicleDetailCurrentMileageLabel.
  ///
  /// In en, this message translates to:
  /// **'Current mileage'**
  String get vehicleDetailCurrentMileageLabel;

  /// No description provided for @vehicleDetailDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete vehicle?'**
  String get vehicleDetailDeleteTitle;

  /// No description provided for @vehicleDetailDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'{year} {make} {model} and all associated reminders, history entries and consumable specs will be permanently removed.'**
  String vehicleDetailDeleteBody(int year, String make, String model);

  /// No description provided for @vehicleDetailMileageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Mileage updated to {km} km'**
  String vehicleDetailMileageUpdated(String km);

  /// No description provided for @vehicleDetailDeleted.
  ///
  /// In en, this message translates to:
  /// **'Vehicle deleted'**
  String get vehicleDetailDeleted;

  /// No description provided for @vehicleDetailKmLabel.
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get vehicleDetailKmLabel;

  /// No description provided for @vehicleDetailYearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get vehicleDetailYearLabel;

  /// No description provided for @vehicleDetailVinLabel.
  ///
  /// In en, this message translates to:
  /// **'VIN'**
  String get vehicleDetailVinLabel;

  /// No description provided for @fuelScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Fuel & Consumption'**
  String get fuelScreenTitle;

  /// No description provided for @fuelScreenAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add fuel'**
  String get fuelScreenAddButton;

  /// No description provided for @fuelScreenAllEntries.
  ///
  /// In en, this message translates to:
  /// **'All fuel entries'**
  String get fuelScreenAllEntries;

  /// No description provided for @fuelScreenEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No fuel entries yet'**
  String get fuelScreenEmptyTitle;

  /// No description provided for @fuelScreenEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add your first fill-up\nto start calculating consumption.'**
  String get fuelScreenEmptyBody;

  /// No description provided for @fuelScreenNotAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get fuelScreenNotAvailableTitle;

  /// No description provided for @fuelScreenNotAvailableBody.
  ///
  /// In en, this message translates to:
  /// **'The fuel log is only available for petrol, diesel and hybrid vehicles.'**
  String get fuelScreenNotAvailableBody;

  /// No description provided for @fuelScreenStatConsumption.
  ///
  /// In en, this message translates to:
  /// **'Avg consumption'**
  String get fuelScreenStatConsumption;

  /// No description provided for @fuelScreenStatKmPerYear.
  ///
  /// In en, this message translates to:
  /// **'Avg km/year'**
  String get fuelScreenStatKmPerYear;

  /// No description provided for @fuelScreenStatTotalCost.
  ///
  /// In en, this message translates to:
  /// **'Total cost'**
  String get fuelScreenStatTotalCost;

  /// No description provided for @fuelScreenDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete entry?'**
  String get fuelScreenDeleteTitle;

  /// No description provided for @fuelSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add fill-up'**
  String get fuelSheetTitle;

  /// No description provided for @fuelSheetFieldGrade.
  ///
  /// In en, this message translates to:
  /// **'Fuel grade'**
  String get fuelSheetFieldGrade;

  /// No description provided for @fuelSheetFieldLiters.
  ///
  /// In en, this message translates to:
  /// **'Litres filled'**
  String get fuelSheetFieldLiters;

  /// No description provided for @fuelSheetFieldTotalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total price'**
  String get fuelSheetFieldTotalPrice;

  /// No description provided for @fuelSheetFieldOdometer.
  ///
  /// In en, this message translates to:
  /// **'Odometer at fill-up'**
  String get fuelSheetFieldOdometer;

  /// No description provided for @fuelSheetFullTankLabel.
  ///
  /// In en, this message translates to:
  /// **'Full tank'**
  String get fuelSheetFullTankLabel;

  /// No description provided for @fuelSheetFullTankHint.
  ///
  /// In en, this message translates to:
  /// **'For precise consumption calculation'**
  String get fuelSheetFullTankHint;

  /// No description provided for @fuelSheetSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get fuelSheetSave;

  /// No description provided for @fuelSheetSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get fuelSheetSaving;

  /// No description provided for @remindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersTitle;

  /// No description provided for @remindersNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get remindersNew;

  /// No description provided for @remindersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No reminders'**
  String get remindersEmpty;

  /// No description provided for @remindersEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add a reminder for oil change, MOT and more.'**
  String get remindersEmptyHint;

  /// No description provided for @remindersMarkDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get remindersMarkDone;

  /// No description provided for @remindersMarkDoneConfirm.
  ///
  /// In en, this message translates to:
  /// **'Mark \"{label}\" as done?'**
  String remindersMarkDoneConfirm(String label);

  /// No description provided for @remindersMarkedDone.
  ///
  /// In en, this message translates to:
  /// **'Marked as done'**
  String get remindersMarkedDone;

  /// No description provided for @remindersDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete reminder?'**
  String get remindersDeleteTitle;

  /// No description provided for @remindersDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The reminder \"{label}\" and all associated notifications will be removed.'**
  String remindersDeleteBody(String label);

  /// No description provided for @remindersDeleted.
  ///
  /// In en, this message translates to:
  /// **'Reminder deleted'**
  String get remindersDeleted;

  /// No description provided for @remindersOverdue.
  ///
  /// In en, this message translates to:
  /// **'{days} days overdue'**
  String remindersOverdue(int days);

  /// No description provided for @remindersDueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today!'**
  String get remindersDueToday;

  /// No description provided for @remindersDueTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Due tomorrow'**
  String get remindersDueTomorrow;

  /// No description provided for @remindersDueInDays.
  ///
  /// In en, this message translates to:
  /// **'In {days} days · {date}'**
  String remindersDueInDays(int days, String date);

  /// No description provided for @remindersDueInWeeks.
  ///
  /// In en, this message translates to:
  /// **'In {weeks} weeks · {date}'**
  String remindersDueInWeeks(int weeks, String date);

  /// No description provided for @remindersKmOverdue.
  ///
  /// In en, this message translates to:
  /// **'Km threshold reached! ({km} km)'**
  String remindersKmOverdue(String km);

  /// No description provided for @remindersKmDueAt.
  ///
  /// In en, this message translates to:
  /// **'At {due} km · {kmLeft} km left (now {current} km)'**
  String remindersKmDueAt(String due, String kmLeft, String current);

  /// No description provided for @remindersKmWithWarning.
  ///
  /// In en, this message translates to:
  /// **'{base} · warning from {km} km'**
  String remindersKmWithWarning(String base, String km);

  /// No description provided for @addReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'New reminder'**
  String get addReminderTitle;

  /// No description provided for @addReminderTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Maintenance type'**
  String get addReminderTypeLabel;

  /// No description provided for @addReminderCustomLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom name'**
  String get addReminderCustomLabel;

  /// No description provided for @addReminderCustomPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Replace pollen filter'**
  String get addReminderCustomPlaceholder;

  /// No description provided for @addReminderDueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get addReminderDueDateLabel;

  /// No description provided for @addReminderDueDateHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to change'**
  String get addReminderDueDateHint;

  /// No description provided for @addReminderDueMileageLabel.
  ///
  /// In en, this message translates to:
  /// **'Due at mileage (optional)'**
  String get addReminderDueMileageLabel;

  /// No description provided for @addReminderDueMileageHint.
  ///
  /// In en, this message translates to:
  /// **'If the maintenance also depends on mileage'**
  String get addReminderDueMileageHint;

  /// No description provided for @addReminderKmOffsetLabel.
  ///
  /// In en, this message translates to:
  /// **'Km pre-warning'**
  String get addReminderKmOffsetLabel;

  /// No description provided for @addReminderKmOffsetHint.
  ///
  /// In en, this message translates to:
  /// **'Notify this many km before the due mileage'**
  String get addReminderKmOffsetHint;

  /// No description provided for @addReminderAtDue.
  ///
  /// In en, this message translates to:
  /// **'Exactly at due date'**
  String get addReminderAtDue;

  /// No description provided for @addReminderKmBefore.
  ///
  /// In en, this message translates to:
  /// **'{km} km before'**
  String addReminderKmBefore(int km);

  /// No description provided for @addReminderNotificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get addReminderNotificationsLabel;

  /// No description provided for @addReminderNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'When would you like to be reminded before the due date?'**
  String get addReminderNotificationsHint;

  /// No description provided for @addReminderCustomTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom time'**
  String get addReminderCustomTimeLabel;

  /// No description provided for @addReminderDaysSuffix.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get addReminderDaysSuffix;

  /// No description provided for @addReminderNoNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications active — the reminder will only appear in the list.'**
  String get addReminderNoNotifications;

  /// No description provided for @addReminderSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Create reminder'**
  String get addReminderSaveButton;

  /// No description provided for @addReminderSavingButton.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get addReminderSavingButton;

  /// No description provided for @addReminderCustomNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name for the custom reminder.'**
  String get addReminderCustomNameError;

  /// No description provided for @addReminderNotificationsDisabledTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled'**
  String get addReminderNotificationsDisabledTitle;

  /// No description provided for @addReminderNotificationsDisabledBody.
  ///
  /// In en, this message translates to:
  /// **'Without notifications AutoMate cannot remind you of upcoming maintenance. You can grant permission in the system settings.'**
  String get addReminderNotificationsDisabledBody;

  /// No description provided for @addReminderSaveAnyway.
  ///
  /// In en, this message translates to:
  /// **'Save anyway'**
  String get addReminderSaveAnyway;

  /// No description provided for @addReminderOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get addReminderOpenSettings;

  /// No description provided for @addReminderDay.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get addReminderDay;

  /// No description provided for @addReminderDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String addReminderDays(int days);

  /// No description provided for @addReminderWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get addReminderWeek;

  /// No description provided for @addReminderWeeks.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks'**
  String addReminderWeeks(int weeks);

  /// No description provided for @addReminderNotifDay.
  ///
  /// In en, this message translates to:
  /// **'1 day until due.'**
  String get addReminderNotifDay;

  /// No description provided for @addReminderNotifDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days until due.'**
  String addReminderNotifDays(int days);

  /// No description provided for @addReminderNotifWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week until due.'**
  String get addReminderNotifWeek;

  /// No description provided for @addReminderNotifWeeks.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks until due.'**
  String addReminderNotifWeeks(int weeks);

  /// No description provided for @addReminderSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String addReminderSaveFailed(String error);

  /// No description provided for @kmReminderBodyDue.
  ///
  /// In en, this message translates to:
  /// **'Maintenance due! Mileage threshold reached.'**
  String get kmReminderBodyDue;

  /// No description provided for @kmReminderBodyKmLeft.
  ///
  /// In en, this message translates to:
  /// **'{km} km until due.'**
  String kmReminderBodyKmLeft(int km);

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Maintenance history'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get historyEmpty;

  /// No description provided for @historyEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'When you mark a reminder as done, it will appear here.'**
  String get historyEmptyHint;

  /// No description provided for @historyDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete entry?'**
  String get historyDeleteTitle;

  /// No description provided for @historyDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The entry will be permanently removed from the history.'**
  String get historyDeleteBody;

  /// No description provided for @historyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Entry deleted'**
  String get historyDeleted;

  /// No description provided for @historyCompletedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed on {date}'**
  String historyCompletedOn(String date);

  /// No description provided for @historyMileageAt.
  ///
  /// In en, this message translates to:
  /// **'Mileage: {km} km'**
  String historyMileageAt(String km);

  /// No description provided for @historyWorkshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop: {name}'**
  String historyWorkshop(String name);

  /// No description provided for @historyCost.
  ///
  /// In en, this message translates to:
  /// **'Cost: {amount} €'**
  String historyCost(String amount);

  /// No description provided for @consumablesTitle.
  ///
  /// In en, this message translates to:
  /// **'Consumables'**
  String get consumablesTitle;

  /// No description provided for @consumablesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No specs yet'**
  String get consumablesEmpty;

  /// No description provided for @consumablesEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add oil, coolant and brake fluid specs for your car so you have them ready at the garage.'**
  String get consumablesEmptyHint;

  /// No description provided for @consumablesAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add specs'**
  String get consumablesAddButton;

  /// No description provided for @consumablesHintWithVehicle.
  ///
  /// In en, this message translates to:
  /// **'Specs for {year} {make} {model} — tap \"Copy\" to share with the garage.'**
  String consumablesHintWithVehicle(int year, String make, String model);

  /// No description provided for @consumablesHintGeneral.
  ///
  /// In en, this message translates to:
  /// **'Specs for the garage — tap \"Copy\" to share.'**
  String get consumablesHintGeneral;

  /// No description provided for @consumablesEngineOil.
  ///
  /// In en, this message translates to:
  /// **'Engine oil'**
  String get consumablesEngineOil;

  /// No description provided for @consumablesOilVolume.
  ///
  /// In en, this message translates to:
  /// **'Oil capacity'**
  String get consumablesOilVolume;

  /// No description provided for @consumablesCoolant.
  ///
  /// In en, this message translates to:
  /// **'Coolant'**
  String get consumablesCoolant;

  /// No description provided for @consumablesBrakeFluid.
  ///
  /// In en, this message translates to:
  /// **'Brake fluid'**
  String get consumablesBrakeFluid;

  /// No description provided for @consumablesTransmissionFluid.
  ///
  /// In en, this message translates to:
  /// **'Transmission fluid'**
  String get consumablesTransmissionFluid;

  /// No description provided for @consumablesCopyAll.
  ///
  /// In en, this message translates to:
  /// **'Copy all specs'**
  String get consumablesCopyAll;

  /// No description provided for @consumablesCopied.
  ///
  /// In en, this message translates to:
  /// **'Specs copied to clipboard'**
  String get consumablesCopied;

  /// No description provided for @consumablesEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit specs'**
  String get consumablesEditTitle;

  /// No description provided for @consumablesCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Add specs'**
  String get consumablesCreateTitle;

  /// No description provided for @consumablesOilGradeLabel.
  ///
  /// In en, this message translates to:
  /// **'Engine oil viscosity'**
  String get consumablesOilGradeLabel;

  /// No description provided for @consumablesOilGradePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. 5W-30'**
  String get consumablesOilGradePlaceholder;

  /// No description provided for @consumablesOilVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Oil capacity (litres)'**
  String get consumablesOilVolumeLabel;

  /// No description provided for @consumablesOilVolumePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. 4.5'**
  String get consumablesOilVolumePlaceholder;

  /// No description provided for @consumablesCoolantLabel.
  ///
  /// In en, this message translates to:
  /// **'Coolant'**
  String get consumablesCoolantLabel;

  /// No description provided for @consumablesCoolantPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. G12++'**
  String get consumablesCoolantPlaceholder;

  /// No description provided for @consumablesBrakeFluidLabel.
  ///
  /// In en, this message translates to:
  /// **'Brake fluid'**
  String get consumablesBrakeFluidLabel;

  /// No description provided for @consumablesBrakeFluidPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. DOT 4'**
  String get consumablesBrakeFluidPlaceholder;

  /// No description provided for @consumablesTransFluidLabel.
  ///
  /// In en, this message translates to:
  /// **'Transmission fluid'**
  String get consumablesTransFluidLabel;

  /// No description provided for @consumablesTransFluidPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. ATF 3+'**
  String get consumablesTransFluidPlaceholder;

  /// No description provided for @consumablesCopyHeader.
  ///
  /// In en, this message translates to:
  /// **'AutoMate – {header}'**
  String consumablesCopyHeader(String header);

  /// No description provided for @consumablesCopyOilGrade.
  ///
  /// In en, this message translates to:
  /// **'Engine oil: {value}'**
  String consumablesCopyOilGrade(String value);

  /// No description provided for @consumablesCopyOilVolume.
  ///
  /// In en, this message translates to:
  /// **'Oil capacity: {value} l'**
  String consumablesCopyOilVolume(String value);

  /// No description provided for @consumablesCopyCoolant.
  ///
  /// In en, this message translates to:
  /// **'Coolant: {value}'**
  String consumablesCopyCoolant(String value);

  /// No description provided for @consumablesCopyBrakeFluid.
  ///
  /// In en, this message translates to:
  /// **'Brake fluid: {value}'**
  String consumablesCopyBrakeFluid(String value);

  /// No description provided for @consumablesCopyTransFluid.
  ///
  /// In en, this message translates to:
  /// **'Transmission fluid: {value}'**
  String consumablesCopyTransFluid(String value);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsApiKeysSection.
  ///
  /// In en, this message translates to:
  /// **'API keys'**
  String get settingsApiKeysSection;

  /// No description provided for @settingsApiKeysHint.
  ///
  /// In en, this message translates to:
  /// **'Keys are stored locally on your device only. You need them to use the AI features and YouTube tutorials.'**
  String get settingsApiKeysHint;

  /// No description provided for @settingsGeminiKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Gemini API key (Google AI)'**
  String get settingsGeminiKeyLabel;

  /// No description provided for @settingsGeminiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'AIza…'**
  String get settingsGeminiKeyHint;

  /// No description provided for @settingsGeminiKeyLink.
  ///
  /// In en, this message translates to:
  /// **'Create key at Google AI Studio'**
  String get settingsGeminiKeyLink;

  /// No description provided for @settingsYouTubeKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'YouTube Data API v3 key'**
  String get settingsYouTubeKeyLabel;

  /// No description provided for @settingsYouTubeKeyLink.
  ///
  /// In en, this message translates to:
  /// **'Create key at Google Cloud'**
  String get settingsYouTubeKeyLink;

  /// No description provided for @settingsNotificationsSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsSection;

  /// No description provided for @settingsNotificationsActive.
  ///
  /// In en, this message translates to:
  /// **'Notifications are active'**
  String get settingsNotificationsActive;

  /// No description provided for @settingsNotificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications are disabled'**
  String get settingsNotificationsDisabled;

  /// No description provided for @settingsNotificationsActiveHint.
  ///
  /// In en, this message translates to:
  /// **'You will receive reminders for upcoming maintenance.'**
  String get settingsNotificationsActiveHint;

  /// No description provided for @settingsPwaNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'Only works while the PWA is open.'**
  String get settingsPwaNotificationsHint;

  /// No description provided for @settingsNotificationsNoPermission.
  ///
  /// In en, this message translates to:
  /// **'Without permission AutoMate cannot remind you.'**
  String get settingsNotificationsNoPermission;

  /// No description provided for @settingsAllowNotifications.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get settingsAllowNotifications;

  /// No description provided for @settingsSendTestNotification.
  ///
  /// In en, this message translates to:
  /// **'Send test notification'**
  String get settingsSendTestNotification;

  /// No description provided for @settingsScheduleTestNotification.
  ///
  /// In en, this message translates to:
  /// **'Schedule test in 2 minutes'**
  String get settingsScheduleTestNotification;

  /// No description provided for @settingsDefaultRemindersHint.
  ///
  /// In en, this message translates to:
  /// **'Default reminder times before due date. Can be overridden per reminder.'**
  String get settingsDefaultRemindersHint;

  /// No description provided for @settingsReportSection.
  ///
  /// In en, this message translates to:
  /// **'Workshop report'**
  String get settingsReportSection;

  /// No description provided for @settingsReportLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Report language'**
  String get settingsReportLanguageLabel;

  /// No description provided for @settingsReportLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Useful if you break down abroad.'**
  String get settingsReportLanguageHint;

  /// No description provided for @settingsSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSaveButton;

  /// No description provided for @settingsWebWarning.
  ///
  /// In en, this message translates to:
  /// **'You are using the web version. Voice assistant, OBD-II and camera scan only work in the mobile app.'**
  String get settingsWebWarning;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// No description provided for @settingsPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied. Open system settings to allow it.'**
  String get settingsPermissionDenied;

  /// No description provided for @settingsPermissionError.
  ///
  /// In en, this message translates to:
  /// **'Notifications not allowed.'**
  String get settingsPermissionError;

  /// No description provided for @settingsNotificationsWork.
  ///
  /// In en, this message translates to:
  /// **'Notifications working.'**
  String get settingsNotificationsWork;

  /// No description provided for @settingsTestSent.
  ///
  /// In en, this message translates to:
  /// **'Test notification sent'**
  String get settingsTestSent;

  /// No description provided for @settingsScheduledNotification.
  ///
  /// In en, this message translates to:
  /// **'Scheduled notification in 2 minutes.'**
  String get settingsScheduledNotification;

  /// No description provided for @settingsScheduledPwa.
  ///
  /// In en, this message translates to:
  /// **'Test in 2 min scheduled — keep the PWA open.'**
  String get settingsScheduledPwa;

  /// No description provided for @settingsScheduledMobile.
  ///
  /// In en, this message translates to:
  /// **'Test in 2 min scheduled.'**
  String get settingsScheduledMobile;

  /// No description provided for @settingsScheduleFailed.
  ///
  /// In en, this message translates to:
  /// **'Scheduling failed: {error}'**
  String settingsScheduleFailed(String error);

  /// No description provided for @settingsLangDe.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get settingsLangDe;

  /// No description provided for @settingsLangEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLangEn;

  /// No description provided for @settingsLangFr.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get settingsLangFr;

  /// No description provided for @settingsLangEs.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get settingsLangEs;

  /// No description provided for @settingsLangIt.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get settingsLangIt;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get profileTitle;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profileName;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get profileMemberSince;

  /// No description provided for @profileSkillLevel.
  ///
  /// In en, this message translates to:
  /// **'Skill level'**
  String get profileSkillLevel;

  /// No description provided for @profileMemberSinceDate.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String profileMemberSinceDate(String date);

  /// No description provided for @profileSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get profileSettingsSection;

  /// No description provided for @profileChangeSkillLevel.
  ///
  /// In en, this message translates to:
  /// **'Change skill level'**
  String get profileChangeSkillLevel;

  /// No description provided for @profileApiAndLanguage.
  ///
  /// In en, this message translates to:
  /// **'API keys & language'**
  String get profileApiAndLanguage;

  /// No description provided for @profileApiAndLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Gemini, YouTube, report language'**
  String get profileApiAndLanguageHint;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileChangeSkillLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Change skill level'**
  String get profileChangeSkillLevelTitle;

  /// No description provided for @profileChangeSkillLevelBody.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to adjust your skill level?\nAutoMate will adapt all recommendations and explanations accordingly.'**
  String get profileChangeSkillLevelBody;

  /// No description provided for @profileChangeSkillLevelYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, adjust'**
  String get profileChangeSkillLevelYes;

  /// No description provided for @profileSelectSkillLevel.
  ///
  /// In en, this message translates to:
  /// **'Choose your skill level'**
  String get profileSelectSkillLevel;

  /// No description provided for @skillLevelBeginnerFeatures.
  ///
  /// In en, this message translates to:
  /// **'Garage recommendations, simple explanations'**
  String get skillLevelBeginnerFeatures;

  /// No description provided for @skillLevelIntermediateFeatures.
  ///
  /// In en, this message translates to:
  /// **'Tutorials, DIY with guidance'**
  String get skillLevelIntermediateFeatures;

  /// No description provided for @skillLevelProFeatures.
  ///
  /// In en, this message translates to:
  /// **'Technical details, full control'**
  String get skillLevelProFeatures;

  /// No description provided for @tutorialsTitle.
  ///
  /// In en, this message translates to:
  /// **'Repair tutorials'**
  String get tutorialsTitle;

  /// No description provided for @tutorialsNoVehicle.
  ///
  /// In en, this message translates to:
  /// **'No vehicle'**
  String get tutorialsNoVehicle;

  /// No description provided for @tutorialsVehicleLabel.
  ///
  /// In en, this message translates to:
  /// **'For: {year} {make} {model}'**
  String tutorialsVehicleLabel(int year, String make, String model);

  /// No description provided for @tutorialsSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. replace brakes, oil change, spark plugs'**
  String get tutorialsSearchPlaceholder;

  /// No description provided for @tutorialsBeginnerTip.
  ///
  /// In en, this message translates to:
  /// **'Beginner tip: For complex repairs, work with a garage.'**
  String get tutorialsBeginnerTip;

  /// No description provided for @tutorialsIntermediateTip.
  ///
  /// In en, this message translates to:
  /// **'Easy step-by-step videos for your level are preferred.'**
  String get tutorialsIntermediateTip;

  /// No description provided for @tutorialsProTip.
  ///
  /// In en, this message translates to:
  /// **'For you: search specific terms (e.g. \"replace head gasket\").'**
  String get tutorialsProTip;

  /// No description provided for @tutorialsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Enter what you want to repair above and we\'ll find matching videos.'**
  String get tutorialsEmptyHint;

  /// No description provided for @tutorialsNothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get tutorialsNothingFound;

  /// No description provided for @videoPlayerTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: Watch the video all the way through before you start. Note the tools and parts you\'ll need.'**
  String get videoPlayerTip;

  /// No description provided for @workshopTitle.
  ///
  /// In en, this message translates to:
  /// **'Workshop report'**
  String get workshopTitle;

  /// No description provided for @workshopSharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share as PDF'**
  String get workshopSharePdf;

  /// No description provided for @workshopNoVehicle.
  ///
  /// In en, this message translates to:
  /// **'No vehicle'**
  String get workshopNoVehicle;

  /// No description provided for @workshopDescription.
  ///
  /// In en, this message translates to:
  /// **'Briefly describe the problem — the AI creates a structured report you can give to your mechanic.'**
  String get workshopDescription;

  /// No description provided for @workshopSymptomsLabel.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get workshopSymptomsLabel;

  /// No description provided for @workshopSymptomsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. \"Since yesterday the engine stutters at 60 km/h, the engine warning light is flashing yellow, smell of petrol.\"'**
  String get workshopSymptomsPlaceholder;

  /// No description provided for @workshopAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Analysing…'**
  String get workshopAnalyzing;

  /// No description provided for @workshopGenerateButton.
  ///
  /// In en, this message translates to:
  /// **'Generate report'**
  String get workshopGenerateButton;

  /// No description provided for @workshopAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get workshopAnalysisTitle;

  /// No description provided for @workshopPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'AutoMate — Workshop report'**
  String get workshopPdfTitle;

  /// No description provided for @workshopPdfSymptomsLabel.
  ///
  /// In en, this message translates to:
  /// **'Observed symptoms:'**
  String get workshopPdfSymptomsLabel;

  /// No description provided for @workshopPdfAnalysisLabel.
  ///
  /// In en, this message translates to:
  /// **'Analysis:'**
  String get workshopPdfAnalysisLabel;

  /// No description provided for @workshopPdfFooter.
  ///
  /// In en, this message translates to:
  /// **'Created with AutoMate · AI analysis for guidance only · Does not replace professional diagnosis.'**
  String get workshopPdfFooter;

  /// No description provided for @workshopPdfFilename.
  ///
  /// In en, this message translates to:
  /// **'workshop_report_{make}_{model}.pdf'**
  String workshopPdfFilename(String make, String model);

  /// No description provided for @breakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Breakdown assistant'**
  String get breakdownTitle;

  /// No description provided for @breakdownTts.
  ///
  /// In en, this message translates to:
  /// **'Text-to-speech'**
  String get breakdownTts;

  /// No description provided for @breakdownFindGarage.
  ///
  /// In en, this message translates to:
  /// **'Find garage'**
  String get breakdownFindGarage;

  /// No description provided for @breakdownNoVehicle.
  ///
  /// In en, this message translates to:
  /// **'No vehicle'**
  String get breakdownNoVehicle;

  /// No description provided for @breakdownPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What\'s wrong with your {make}?'**
  String breakdownPlaceholder(String make);

  /// No description provided for @breakdownExamplesTitle.
  ///
  /// In en, this message translates to:
  /// **'Speak or type your problem. Examples:'**
  String get breakdownExamplesTitle;

  /// No description provided for @breakdownExample1Beginner.
  ///
  /// In en, this message translates to:
  /// **'The engine warning light is flashing yellow'**
  String get breakdownExample1Beginner;

  /// No description provided for @breakdownExample2Beginner.
  ///
  /// In en, this message translates to:
  /// **'The car won\'t start'**
  String get breakdownExample2Beginner;

  /// No description provided for @breakdownExample3Beginner.
  ///
  /// In en, this message translates to:
  /// **'I hear a squeak when braking'**
  String get breakdownExample3Beginner;

  /// No description provided for @breakdownExample1Intermediate.
  ///
  /// In en, this message translates to:
  /// **'Fault code P0420 — what to do?'**
  String get breakdownExample1Intermediate;

  /// No description provided for @breakdownExample2Intermediate.
  ///
  /// In en, this message translates to:
  /// **'Replacing brakes — what do I need?'**
  String get breakdownExample2Intermediate;

  /// No description provided for @breakdownExample3Intermediate.
  ///
  /// In en, this message translates to:
  /// **'Doing an oil change myself — what to watch out for?'**
  String get breakdownExample3Intermediate;

  /// No description provided for @breakdownExample1Pro.
  ///
  /// In en, this message translates to:
  /// **'Front vs rear lambda sensor — differences'**
  String get breakdownExample1Pro;

  /// No description provided for @breakdownExample2Pro.
  ///
  /// In en, this message translates to:
  /// **'Compression values Bank 1 low, diagnostic steps'**
  String get breakdownExample2Pro;

  /// No description provided for @breakdownExample3Pro.
  ///
  /// In en, this message translates to:
  /// **'Replace dual-mass flywheel — tools needed'**
  String get breakdownExample3Pro;

  /// No description provided for @breakdownWebWarning.
  ///
  /// In en, this message translates to:
  /// **'Voice control and text-to-speech are only available in the mobile app. You can still type in the browser.'**
  String get breakdownWebWarning;

  /// No description provided for @breakdownInputPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Describe the problem…'**
  String get breakdownInputPlaceholder;

  /// No description provided for @garageFinderTitle.
  ///
  /// In en, this message translates to:
  /// **'Garages nearby'**
  String get garageFinderTitle;

  /// No description provided for @garageFinderDefault.
  ///
  /// In en, this message translates to:
  /// **'Garage'**
  String get garageFinderDefault;

  /// No description provided for @garageFinderShowOnMap.
  ///
  /// In en, this message translates to:
  /// **'Show on map'**
  String get garageFinderShowOnMap;

  /// No description provided for @garageFinderFound.
  ///
  /// In en, this message translates to:
  /// **'{count} garages found'**
  String garageFinderFound(int count);

  /// No description provided for @garageFinderNoLocation.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable — searching around centre of Germany.'**
  String get garageFinderNoLocation;

  /// No description provided for @settingsAppLanguageSection.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get settingsAppLanguageSection;

  /// No description provided for @settingsAppLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Interface language'**
  String get settingsAppLanguageLabel;

  /// No description provided for @settingsAppLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsAppLanguageSystem;

  /// No description provided for @settingsLangHr.
  ///
  /// In en, this message translates to:
  /// **'Croatian'**
  String get settingsLangHr;

  /// No description provided for @navGarage.
  ///
  /// In en, this message translates to:
  /// **'Garage'**
  String get navGarage;

  /// No description provided for @navMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get navMaintenance;

  /// No description provided for @navAssistant.
  ///
  /// In en, this message translates to:
  /// **'Assistant'**
  String get navAssistant;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navSelectVehicle.
  ///
  /// In en, this message translates to:
  /// **'Select a vehicle'**
  String get navSelectVehicle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'hr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'hr':
      return AppLocalizationsHr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
