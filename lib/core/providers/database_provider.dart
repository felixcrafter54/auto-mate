import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/database/database.dart';

/// Global database instance provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// Users repository provider
final usersRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return UsersRepository(db);
});

/// Vehicles repository provider
final vehiclesRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return VehiclesRepository(db);
});

/// Reminders repository provider
final remindersRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return RemindersRepository(db);
});

/// Maintenance history repository provider
final maintenanceHistoryRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return MaintenanceHistoryRepository(db);
});

/// Consumables repository provider
final consumablesRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return ConsumablesRepository(db);
});

/// Fuel entries repository provider
final fuelEntriesRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return FuelEntriesRepository(db);
});

/// Reactive vehicle stream — updates everywhere when mileage or other fields change
final vehicleStreamProvider = StreamProvider.family<Vehicle?, int>((ref, vehicleId) {
  return ref.read(vehiclesRepositoryProvider).watchVehicleById(vehicleId);
});

// ============================================================================
// REPOSITORY CLASSES
// ============================================================================

class UsersRepository {
  final AppDatabase db;
  UsersRepository(this.db);

  Future<int> createUser({required String name, required String email}) =>
      db.createUser(name: name, email: email);

  Future<User?> getUserByEmail(String email) =>
      db.getUserByEmail(email);
}

class VehiclesRepository {
  final AppDatabase db;
  VehiclesRepository(this.db);

  Stream<List<Vehicle>> watchVehiclesByUser(int userId) =>
      db.watchVehiclesByUser(userId);

  Stream<Vehicle?> watchVehicleById(int vehicleId) =>
      db.watchVehicleById(vehicleId);

  Future<Vehicle?> getVehicleById(int vehicleId) =>
      db.getVehicleById(vehicleId);

  Future<int> insertVehicle(VehiclesCompanion vehicle) =>
      db.insertVehicle(vehicle);

  Future<bool> updateVehicle(VehiclesCompanion vehicle) =>
      db.updateVehicle(vehicle);

  Future<void> updateMileage(int vehicleId, int mileage) =>
      db.updateVehicleMileage(vehicleId, mileage);

  Future<List<int>> deleteVehicle(int vehicleId) =>
      db.deleteVehicleCascade(vehicleId);
}

class RemindersRepository {
  final AppDatabase db;
  RemindersRepository(this.db);

  Stream<List<Reminder>> watchRemindersByVehicle(int vehicleId) =>
      db.watchRemindersByVehicle(vehicleId);

  Future<List<Reminder>> getUpcomingReminders(int vehicleId) =>
      db.getUpcomingReminders(vehicleId);

  Future<int> insertReminder(RemindersCompanion reminder) =>
      db.insertReminder(reminder);

  Future<void> markReminderNotified(int reminderId) =>
      db.markReminderNotified(reminderId);

  Future<List<Reminder>> getKmRemindersToCheck(int vehicleId) =>
      db.getKmRemindersToCheck(vehicleId);
}

class MaintenanceHistoryRepository {
  final AppDatabase db;
  MaintenanceHistoryRepository(this.db);

  Stream<List<MaintenanceHistoryTableData>> watchMaintenanceHistory(
    int vehicleId,
  ) =>
      db.watchMaintenanceHistory(vehicleId);

  Future<int> insertMaintenanceHistory(
    MaintenanceHistoryTableCompanion history,
  ) =>
      db.insertMaintenanceHistory(history);

  Future<int> deleteEntry(int id) => db.deleteMaintenanceHistoryEntry(id);
}

class ConsumablesRepository {
  final AppDatabase db;
  ConsumablesRepository(this.db);

  Stream<ConsumablesTableData?> watchConsumablesByVehicle(int vehicleId) =>
      db.watchConsumablesByVehicle(vehicleId);

  Future<int> insertConsumables(ConsumablesTableCompanion consumables) =>
      db.insertConsumables(consumables);

  Future<bool> updateConsumables(ConsumablesTableCompanion consumables) =>
      db.updateConsumables(consumables);
}

class FuelEntriesRepository {
  final AppDatabase db;
  FuelEntriesRepository(this.db);

  Stream<List<FuelEntry>> watchFuelEntriesByVehicle(int vehicleId) =>
      db.watchFuelEntriesByVehicle(vehicleId);

  Future<int> insertFuelEntry(FuelEntriesCompanion entry) =>
      db.insertFuelEntry(entry);

  Future<int> deleteFuelEntry(int id) => db.deleteFuelEntry(id);
}
