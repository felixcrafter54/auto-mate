import '../../services/models/enums.dart';

/// Localized display name for a FuelType.
/// Replace with proper AppLocalizations calls when multilingual support is added.
String fuelTypeLabel(FuelType type) => switch (type) {
      FuelType.petrol => 'Benzin',
      FuelType.diesel => 'Diesel',
      FuelType.electric => 'Elektro',
      FuelType.hybrid => 'Hybrid',
      FuelType.other => 'Sonstiges',
    };

/// Localized display name for a FuelGrade.
/// Replace with proper AppLocalizations calls when multilingual support is added.
String fuelGradeLabel(FuelGrade grade) => switch (grade) {
      FuelGrade.superE5 => 'Super E5 (95)',
      FuelGrade.superE10 => 'Super E10 (95)',
      FuelGrade.superPlus => 'Super Plus (98)',
      FuelGrade.premium => 'Premium (100)',
      FuelGrade.dieselB7 => 'Diesel B7',
      FuelGrade.dieselPremium => 'Premium Diesel',
    };

// ---------------------------------------------------------------------------
// FuelScreen UI strings
// Replace with proper AppLocalizations calls when multilingual support is added.
// ---------------------------------------------------------------------------

const fuelScreenTitle = 'Tanken & Verbrauch';
const fuelScreenAddButton = 'Tankfüllung';
const fuelScreenAllEntries = 'Alle Tankfüllungen';
const fuelScreenEmptyTitle = 'Noch keine Tankfüllungen';
const fuelScreenEmptyBody =
    'Trage deine erste Tankfüllung ein\num den Verbrauch zu berechnen.';

const fuelScreenNotAvailableTitle = 'Nicht verfügbar';
const fuelScreenNotAvailableBody =
    'Das Tanktagebuch steht nur für Benzin-, Diesel- und Hybridfahrzeuge zur Verfügung.';

const fuelScreenStatConsumption = 'Ø Verbrauch';
const fuelScreenStatKmPerYear = 'Ø km/Jahr';
const fuelScreenStatTotalCost = 'Kosten ges.';

const fuelScreenDeleteTitle = 'Eintrag löschen?';
const fuelScreenDeleteCancel = 'Abbrechen';
const fuelScreenDeleteConfirm = 'Löschen';

const fuelSheetTitle = 'Tankfüllung eintragen';
const fuelSheetFieldGrade = 'Kraftstoffsorte';
const fuelSheetFieldLiters = 'Getankte Liter';
const fuelSheetFieldTotalPrice = 'Gesamtpreis';
const fuelSheetFieldOdometer = 'Kilometerstand beim Tanken';
const fuelSheetFullTankLabel = 'Volltank';
const fuelSheetFullTankHint = 'Für präzise Verbrauchsberechnung';
const fuelSheetSave = 'Speichern';
const fuelSheetSaving = 'Speichere...';
