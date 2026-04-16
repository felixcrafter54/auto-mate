import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/database/database.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/providers/session_provider.dart';
import '../../../services/models/enums.dart';
import '../../../services/nhtsa_service.dart';

// ============================================================================
// FORM STATE
// ============================================================================

class VehicleFormState {
  final String? make;
  final String? model;
  final int? year;
  final String vin;
  final FuelType fuelType;
  final int mileage;
  final bool isSaving;
  final String? error;

  const VehicleFormState({
    this.make,
    this.model,
    this.year,
    this.vin = '',
    this.fuelType = FuelType.petrol,
    this.mileage = 0,
    this.isSaving = false,
    this.error,
  });

  bool get isValid =>
      make != null && model != null && year != null && mileage >= 0;

  VehicleFormState copyWith({
    String? make,
    String? model,
    int? year,
    String? vin,
    FuelType? fuelType,
    int? mileage,
    bool? isSaving,
    String? error,
    bool clearModel = false,
  }) {
    return VehicleFormState(
      make: make ?? this.make,
      model: clearModel ? null : (model ?? this.model),
      year: year ?? this.year,
      vin: vin ?? this.vin,
      fuelType: fuelType ?? this.fuelType,
      mileage: mileage ?? this.mileage,
      isSaving: isSaving ?? this.isSaving,
      error: error,
    );
  }
}

// ============================================================================
// NOTIFIER
// ============================================================================

final vehicleFormProvider =
    NotifierProvider<VehicleFormNotifier, VehicleFormState>(
  VehicleFormNotifier.new,
);

class VehicleFormNotifier extends Notifier<VehicleFormState> {
  @override
  VehicleFormState build() => const VehicleFormState();

  void setMake(String make) {
    state = state.copyWith(make: make, clearModel: true);
  }

  void setModel(String model) {
    state = state.copyWith(model: model);
  }

  void setYear(int year) {
    state = state.copyWith(year: year, clearModel: true);
  }

  void setVin(String vin) {
    state = state.copyWith(vin: vin);
  }

  void setFuelType(FuelType ft) {
    state = state.copyWith(fuelType: ft);
  }

  void setMileage(int km) {
    state = state.copyWith(mileage: km);
  }

  Future<bool> save() async {
    if (!state.isValid) return false;

    state = state.copyWith(isSaving: true);

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      state = state.copyWith(isSaving: false, error: 'No user session found.');
      return false;
    }

    try {
      final repo = ref.read(vehiclesRepositoryProvider);
      final now = DateTime.now();
      await repo.insertVehicle(VehiclesCompanion(
        userId: Value(userId),
        make: Value(state.make!),
        model: Value(state.model!),
        year: Value(state.year!),
        vin: Value(state.vin.isEmpty ? null : state.vin),
        fuelType: Value(state.fuelType.value),
        currentMileage: Value(state.mileage),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));

      state = const VehicleFormState(); // reset
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      return false;
    }
  }

  void reset() => state = const VehicleFormState();
}

// ============================================================================
// NHTSA YEAR OPTIONS
// ============================================================================

final yearOptionsProvider = Provider<List<int>>((ref) {
  final currentYear = DateTime.now().year;
  return List.generate(currentYear - 1989, (i) => currentYear - i);
});

// Models depend on selected make + year
final availableModelsProvider = FutureProvider<List<String>>((ref) {
  final form = ref.watch(vehicleFormProvider);
  if (form.make == null || form.year == null) return Future.value([]);
  return ref
      .read(nhtsaServiceProvider)
      .fetchModels(form.make!, form.year!);
});
