import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

// ============================================================================
// DATABASE TABLES
// ============================================================================

/// Users table
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get skillLevel => text().nullable()();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Vehicles table
class Vehicles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get make => text()();
  TextColumn get model => text()();
  IntColumn get year => integer()();
  TextColumn get vin => text().nullable()();
  TextColumn get fuelType => text()(); // FuelType.value
  IntColumn get currentMileage => integer()();
  IntColumn get annualKmEstimate => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Fuel entries table — each refuelling event
class FuelEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId => integer().references(Vehicles, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get liters => real()();
  IntColumn get odometerKm => integer()();
  TextColumn get fuelGrade => text().nullable()(); // FuelGrade.value
  RealColumn get pricePerLiter => real().nullable()();
  BoolColumn get fullTank => boolean().withDefault(const Constant(false))();
}

/// Maintenance reminders table
class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId => integer().references(Vehicles, #id)();
  TextColumn get type => text()(); // ReminderType.dbValue
  TextColumn get customLabel => text().nullable()();
  DateTimeColumn get dueDate => dateTime()();
  IntColumn get dueMileage => integer().nullable()();
  IntColumn get notifyOffsetKm => integer().nullable()(); // km before due mileage to notify
  TextColumn get notifyOffsetsDays => text().nullable()(); // CSV of ints
  BoolColumn get notified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

/// Maintenance history table
class MaintenanceHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId => integer().references(Vehicles, #id)();
  TextColumn get type => text()(); // ReminderType.dbValue
  TextColumn get customLabel => text().nullable()();
  DateTimeColumn get completedDate => dateTime()();
  IntColumn get mileageAtCompletion => integer()();
  TextColumn get notes => text().nullable()();
  TextColumn get workshopName => text().nullable()();
  RealColumn get cost => real().nullable()();
}

/// App-wide key-value settings (replaces SharedPreferences)
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

/// Consumables specifications table
class ConsumablesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId => integer().unique().references(Vehicles, #id)();
  TextColumn get engineOilGrade => text()();
  RealColumn get engineOilVolume => real()();
  TextColumn get coolantType => text()();
  TextColumn get brakeFluidSpec => text()();
  TextColumn get transmissionFluid => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

// ============================================================================
// DATABASE CLASS
// ============================================================================

@DriftDatabase(tables: [
  Users,
  Vehicles,
  Reminders,
  MaintenanceHistoryTable,
  ConsumablesTable,
  AppSettings,
  FuelEntries,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(users, users.skillLevel);
            await m.addColumn(users, users.onboardingComplete);
          }
          if (from < 3) {
            await m.createTable(appSettings);
          }
          if (from < 4) {
            // Drop vehicles.skill_level — skill level is now per user.
            await customStatement('ALTER TABLE vehicles DROP COLUMN skill_level');
          }
          if (from < 5) {
            await m.addColumn(reminders, reminders.customLabel);
            await m.addColumn(reminders, reminders.notifyOffsetsDays);
          }
          if (from < 6) {
            await m.addColumn(vehicles, vehicles.annualKmEstimate);
            await m.createTable(fuelEntries);
          }
          if (from < 7) {
            await m.addColumn(reminders, reminders.notifyOffsetKm);
          }
          if (from < 8) {
            await m.addColumn(maintenanceHistoryTable, maintenanceHistoryTable.customLabel);
          }
          if (from < 9) {
            await m.addColumn(fuelEntries, fuelEntries.fuelGrade);
            await m.addColumn(fuelEntries, fuelEntries.pricePerLiter);
            await m.addColumn(fuelEntries, fuelEntries.fullTank);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'automate_db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  // =========================================================================
  // USERS REPOSITORY
  // =========================================================================

  Future<int> createUser({
    required String name,
    required String email,
  }) {
    final now = DateTime.now();
    return into(users).insert(
      UsersCompanion(
        name: Value(name),
        email: Value(email),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<User?> getUserByEmail(String email) {
    return (select(users)..where((u) => u.email.equals(email)))
        .getSingleOrNull();
  }

  Future<void> updateUserSkillLevel(int userId, String skillLevel) {
    return (update(users)..where((u) => u.id.equals(userId))).write(
      UsersCompanion(
        skillLevel: Value(skillLevel),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> completeUserOnboarding(int userId, String skillLevel) {
    return (update(users)..where((u) => u.id.equals(userId))).write(
      UsersCompanion(
        skillLevel: Value(skillLevel),
        onboardingComplete: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  // =========================================================================
  // SETTINGS REPOSITORY
  // =========================================================================

  Future<String?> getSetting(String key) async {
    final row = await (select(appSettings)
          ..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setSetting(String key, String value) {
    return into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
  }

  Future<void> deleteSetting(String key) {
    return (delete(appSettings)..where((s) => s.key.equals(key))).go();
  }

  // =========================================================================
  // VEHICLES REPOSITORY
  // =========================================================================

  Future<int> insertVehicle(VehiclesCompanion vehicle) {
    return into(vehicles).insert(vehicle);
  }

  Stream<List<Vehicle>> watchVehiclesByUser(int userId) {
    return (select(vehicles)..where((v) => v.userId.equals(userId)))
        .watch();
  }

  Future<Vehicle?> getVehicleById(int vehicleId) {
    return (select(vehicles)..where((v) => v.id.equals(vehicleId)))
        .getSingleOrNull();
  }

  Stream<Vehicle?> watchVehicleById(int vehicleId) {
    return (select(vehicles)..where((v) => v.id.equals(vehicleId)))
        .watchSingleOrNull();
  }

  Future<bool> updateVehicle(VehiclesCompanion vehicle) {
    return update(vehicles).replace(vehicle);
  }

  Future<void> updateVehicleMileage(int vehicleId, int mileage) {
    return (update(vehicles)..where((v) => v.id.equals(vehicleId))).write(
      VehiclesCompanion(
        currentMileage: Value(mileage),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Deletes a vehicle and all of its dependent rows in a single transaction.
  /// Returns the IDs of reminders that were removed, so the caller can cancel
  /// their scheduled local notifications.
  Future<List<int>> deleteVehicleCascade(int vehicleId) {
    return transaction(() async {
      final reminderIds = await (selectOnly(reminders)
            ..addColumns([reminders.id])
            ..where(reminders.vehicleId.equals(vehicleId)))
          .map((row) => row.read(reminders.id)!)
          .get();

      await (delete(reminders)..where((r) => r.vehicleId.equals(vehicleId))).go();
      await (delete(maintenanceHistoryTable)
            ..where((h) => h.vehicleId.equals(vehicleId)))
          .go();
      await (delete(consumablesTable)
            ..where((c) => c.vehicleId.equals(vehicleId)))
          .go();
      await (delete(fuelEntries)..where((f) => f.vehicleId.equals(vehicleId))).go();
      await (delete(vehicles)..where((v) => v.id.equals(vehicleId))).go();

      return reminderIds;
    });
  }

  // =========================================================================
  // REMINDERS REPOSITORY
  // =========================================================================

  Future<int> insertReminder(RemindersCompanion reminder) {
    return into(reminders).insert(reminder);
  }

  Stream<List<Reminder>> watchRemindersByVehicle(int vehicleId) {
    return (select(reminders)..where((r) => r.vehicleId.equals(vehicleId)))
        .watch();
  }

  Future<List<Reminder>> getUpcomingReminders(int vehicleId) {
    final now = DateTime.now();
    return (select(reminders)
          ..where((r) =>
              r.vehicleId.equals(vehicleId) &
              r.dueDate.isBiggerOrEqualValue(now))
          ..orderBy([(r) => OrderingTerm(expression: r.dueDate)]))
        .get();
  }

  Future<void> markReminderNotified(int reminderId) {
    return (update(reminders)..where((r) => r.id.equals(reminderId)))
        .write(const RemindersCompanion(notified: Value(true)));
  }

  Future<List<Reminder>> getKmRemindersToCheck(int vehicleId) {
    return (select(reminders)
          ..where((r) =>
              r.vehicleId.equals(vehicleId) &
              r.dueMileage.isNotNull() &
              r.notified.equals(false)))
        .get();
  }

  // =========================================================================
  // MAINTENANCE HISTORY REPOSITORY
  // =========================================================================

  Future<int> insertMaintenanceHistory(
      MaintenanceHistoryTableCompanion history) {
    return into(maintenanceHistoryTable).insert(history);
  }

  Future<int> deleteMaintenanceHistoryEntry(int id) {
    return (delete(maintenanceHistoryTable)..where((h) => h.id.equals(id))).go();
  }

  Stream<List<MaintenanceHistoryTableData>> watchMaintenanceHistory(
      int vehicleId) {
    return (select(maintenanceHistoryTable)
          ..where((h) => h.vehicleId.equals(vehicleId))
          ..orderBy([(h) => OrderingTerm(expression: h.completedDate, mode: OrderingMode.desc)]))
        .watch();
  }

  // =========================================================================
  // FUEL ENTRIES REPOSITORY
  // =========================================================================

  Future<int> insertFuelEntry(FuelEntriesCompanion entry) {
    return into(fuelEntries).insert(entry);
  }

  Stream<List<FuelEntry>> watchFuelEntriesByVehicle(int vehicleId) {
    return (select(fuelEntries)
          ..where((f) => f.vehicleId.equals(vehicleId))
          ..orderBy([(f) => OrderingTerm(expression: f.date, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<int> deleteFuelEntry(int id) {
    return (delete(fuelEntries)..where((f) => f.id.equals(id))).go();
  }

  // =========================================================================
  // CONSUMABLES REPOSITORY
  // =========================================================================

  Future<int> insertConsumables(ConsumablesTableCompanion consumables) {
    return into(consumablesTable).insert(consumables);
  }

  Stream<ConsumablesTableData?> watchConsumablesByVehicle(int vehicleId) {
    return (select(consumablesTable)
          ..where((c) => c.vehicleId.equals(vehicleId)))
        .watchSingleOrNull();
  }

  Future<bool> updateConsumables(ConsumablesTableCompanion consumables) {
    return update(consumablesTable).replace(consumables);
  }
}
