import '../../l10n/app_localizations.dart';
import '../../services/models/enums.dart';

/// Localized display name for a FuelType.
String fuelTypeLabel(AppLocalizations l, FuelType type) => switch (type) {
      FuelType.petrol => l.fuelTypePetrol,
      FuelType.diesel => l.fuelTypeDiesel,
      FuelType.electric => l.fuelTypeElectric,
      FuelType.hybrid => l.fuelTypeHybrid,
      FuelType.other => l.fuelTypeOther,
    };

/// Localized display name for a FuelGrade.
String fuelGradeLabel(AppLocalizations l, FuelGrade grade) => switch (grade) {
      FuelGrade.superE5 => l.fuelGradeSuperE5,
      FuelGrade.superE10 => l.fuelGradeSuperE10,
      FuelGrade.superPlus => l.fuelGradeSuperPlus,
      FuelGrade.premium => l.fuelGradePremium,
      FuelGrade.dieselB7 => l.fuelGradeDieselB7,
      FuelGrade.dieselPremium => l.fuelGradeDieselPremium,
    };
