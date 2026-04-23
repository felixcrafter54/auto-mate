import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/database_provider.dart';
import '../providers/session_provider.dart';
import '../../services/database/database.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _indexFor(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) => _onTap(context, ref, i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.directions_car_outlined),
            selectedIcon: const Icon(Icons.directions_car_rounded),
            label: l.navGarage,
          ),
          NavigationDestination(
            icon: const Icon(Icons.build_circle_outlined),
            selectedIcon: const Icon(Icons.build_circle),
            label: l.navMaintenance,
          ),
          NavigationDestination(
            icon: const Icon(Icons.mic_none_rounded),
            selectedIcon: const Icon(Icons.mic_rounded),
            label: l.navAssistant,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            label: l.navProfile,
          ),
        ],
      ),
    );
  }

  int _indexFor(String location) {
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  Future<void> _onTap(BuildContext context, WidgetRef ref, int index) async {
    switch (index) {
      case 0:
        context.go('/');
      case 1:
        await _navigateToVehicle(context, ref, 'reminders');
      case 2:
        await _navigateToVehicle(context, ref, 'breakdown');
      case 3:
        context.go('/profile');
    }
  }

  Future<void> _navigateToVehicle(
      BuildContext context, WidgetRef ref, String feature) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final vehicles = await ref
        .read(vehiclesRepositoryProvider)
        .watchVehiclesByUser(userId)
        .first;

    if (!context.mounted) return;

    if (vehicles.isEmpty) {
      context.go('/');
      return;
    }

    if (vehicles.length == 1) {
      context.push('/vehicle/${vehicles.first.id}/$feature');
      return;
    }

    final picked = await _pickVehicle(context, vehicles);
    if (picked != null && context.mounted) {
      context.push('/vehicle/${picked.id}/$feature');
    }
  }

  Future<Vehicle?> _pickVehicle(
      BuildContext context, List<Vehicle> vehicles) async {
    final l = AppLocalizations.of(context);
    return showModalBottomSheet<Vehicle>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(ctx)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(l.navSelectVehicle,
                style: Theme.of(ctx)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ...vehicles.map((v) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(ctx)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.directions_car_rounded,
                        color: Theme.of(ctx).colorScheme.primary, size: 20),
                  ),
                  title: Text('${v.make} ${v.model}',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${v.year}'),
                  onTap: () => Navigator.pop(ctx, v),
                )),
          ],
        ),
      ),
    );
  }
}
