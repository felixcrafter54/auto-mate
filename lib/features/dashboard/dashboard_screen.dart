import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/fuel_labels.dart';
import '../../core/providers/database_provider.dart';
import '../../core/providers/session_provider.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/status_badge.dart';
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
            icon: const Icon(Icons.add_rounded),
            tooltip: l.dashboardAddVehicle,
            onPressed: () => context.push('/vehicle-setup'),
          ),
        ],
      ),
      body: vehiclesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonError(e.toString()))),
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return EmptyState(
              icon: Icons.directions_car_outlined,
              title: l.dashboardNoVehicle,
              subtitle: l.dashboardNoVehicleHint,
              action: FilledButton.icon(
                icon: const Icon(Icons.add_rounded),
                label: Text(l.dashboardAddVehicle),
                onPressed: () => context.push('/vehicle-setup'),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: vehicles.length,
            itemBuilder: (context, i) => _VehicleCard(vehicle: vehicles[i]),
          );
        },
      ),
      floatingActionButton: vehiclesAsync.maybeWhen(
        data: (v) => v.isEmpty
            ? null
            : FloatingActionButton.extended(
                onPressed: () => context.push('/vehicle-setup'),
                icon: const Icon(Icons.add_rounded),
                label: Text(l.dashboardAddVehicle),
              ),
        orElse: () => null,
      ),
    );
  }
}

final _vehiclesStreamProvider =
    StreamProvider.family<List<Vehicle>, int>((ref, userId) {
  return ref.read(vehiclesRepositoryProvider).watchVehiclesByUser(userId);
});

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  const _VehicleCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final fuelType = FuelType.fromString(vehicle.fuelType);

    return GestureDetector(
      onTap: () => context.push('/vehicle/${vehicle.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              cs.primaryContainer,
              cs.surfaceContainerHighest,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () => context.push('/vehicle/${vehicle.id}'),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: cs.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(_fuelIcon(fuelType),
                            color: cs.primary, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${vehicle.make} ${vehicle.model}',
                              style: tt.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${vehicle.year}',
                              style: tt.bodySmall
                                  ?.copyWith(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded,
                          color: cs.onSurfaceVariant),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.speed_rounded,
                          size: 16, color: cs.onSurfaceVariant),
                      const SizedBox(width: 6),
                      Text(
                        '${_formatKm(vehicle.currentMileage)} km',
                        style: tt.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      StatusBadge(
                        label: fuelTypeLabel(l, fuelType),
                        color: _fuelColor(cs, fuelType),
                        icon: _fuelIcon(fuelType),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _fuelIcon(FuelType ft) {
    return switch (ft) {
      FuelType.electric => Icons.bolt_rounded,
      FuelType.hybrid => Icons.eco_rounded,
      _ => Icons.local_gas_station_rounded,
    };
  }

  Color _fuelColor(ColorScheme cs, FuelType ft) {
    return switch (ft) {
      FuelType.electric => cs.tertiary,
      FuelType.hybrid => cs.tertiary,
      _ => cs.primary,
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
