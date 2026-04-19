/// User skill level for vehicle maintenance
enum SkillLevel {
  beginner('beginner'),
  intermediate('intermediate'),
  pro('pro');

  final String value;
  const SkillLevel(this.value);

  factory SkillLevel.fromString(String value) {
    return SkillLevel.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SkillLevel.beginner,
    );
  }
}

/// Types of maintenance reminders
enum ReminderType {
  oilChange('oil_change'),
  tuev('tuev'),
  majorService('major_service'),
  minorService('minor_service'),
  tyreSwap('tyre_swap'),
  custom('custom');

  final String dbValue;
  const ReminderType(this.dbValue);

  factory ReminderType.fromString(String value) {
    return ReminderType.values.firstWhere(
      (e) => e.dbValue == value,
      orElse: () => ReminderType.custom,
    );
  }
}

/// Fuel type of a vehicle
enum FuelType {
  petrol('petrol', 'Petrol'),
  diesel('diesel', 'Diesel'),
  electric('electric', 'Electric'),
  hybrid('hybrid', 'Hybrid'),
  other('other', 'Other');

  final String value;
  final String displayName;
  const FuelType(this.value, this.displayName);

  factory FuelType.fromString(String value) {
    return FuelType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => FuelType.other,
    );
  }

  /// Whether this fuel type uses liquid fuel and supports a fuel log.
  bool get supportsFuelLog =>
      this == FuelType.petrol ||
      this == FuelType.diesel ||
      this == FuelType.hybrid;

  /// Applicable fuel grades for vehicles of this type.
  List<FuelGrade> get applicableGrades => switch (this) {
        FuelType.diesel => [FuelGrade.dieselB7, FuelGrade.dieselPremium],
        FuelType.hybrid => [
            FuelGrade.superE5,
            FuelGrade.superE10,
            FuelGrade.superPlus,
            FuelGrade.premium,
          ],
        _ => [
            FuelGrade.superE5,
            FuelGrade.superE10,
            FuelGrade.superPlus,
            FuelGrade.premium,
          ],
      };
}

/// Grade / product of fuel that was refuelled.
enum FuelGrade {
  superE5('super_e5'),
  superE10('super_e10'),
  superPlus('super_plus'),
  premium('premium'),
  dieselB7('diesel_b7'),
  dieselPremium('diesel_premium');

  final String value;
  const FuelGrade(this.value);

  factory FuelGrade.fromString(String value) {
    return FuelGrade.values.firstWhere(
      (e) => e.value == value,
      orElse: () => FuelGrade.superE5,
    );
  }
}
