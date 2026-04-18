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
}
