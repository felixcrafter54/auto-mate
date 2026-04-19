import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/fuel_labels.dart';
import '../../core/providers/database_provider.dart';
import '../../core/providers/session_provider.dart';
import '../../features/profile/profile_drawer.dart';
import '../../services/database/database.dart';
import '../../services/models/enums.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final userId = ref.watch(currentUserIdProvider);

    if (userId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final vehiclesAsync = ref.watch(_vehiclesStreamProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l.dashboardAddVehicle,
            onPressed: () => context.push('/vehicle-setup'),
          ),
        ],
      ),
      drawer: const ProfileDrawer(),
      body: vehiclesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonError(e.toString()))),
        data: (vehicles) {
          if (vehicles.isEmpty) return _EmptyState();
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vehicles.length,
            itemBuilder: (context, i) => _VehicleCard(vehicle: vehicles[i]),
          );
        },
      ),
    );
  }
}

final _vehiclesStreamProvider =
    StreamProvider.family<List<Vehicle>, int>((ref, userId) {
  return ref.read(vehiclesRepositoryProvider).watchVehiclesByUser(userId);
});

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 72,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            l.dashboardNoVehicle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l.dashboardNoVehicleHint,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: Text(l.dashboardAddVehicle),
            onPressed: () => context.push('/vehicle-setup'),
          ),
        ],
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  const _VehicleCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fuelType = FuelType.fromString(vehicle.fuelType);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(child: Icon(_fuelIcon(fuelType))),
        title: Text(
          '${vehicle.year} ${vehicle.make} ${vehicle.model}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${_formatKm(vehicle.currentMileage)} km  •  ${fuelTypeLabel(l, fuelType)}',
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/vehicle/${vehicle.id}'),
      ),
    );
  }

  IconData _fuelIcon(FuelType ft) {
    return switch (ft) {
      FuelType.electric => Icons.bolt,
      FuelType.hybrid => Icons.eco,
      _ => Icons.local_gas_station,
    };
  }

  String _formatKm(int km) {
    final s = km.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
