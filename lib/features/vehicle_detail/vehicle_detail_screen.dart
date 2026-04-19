import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/fuel_labels.dart';
import '../../core/providers/database_provider.dart';
import '../../core/providers/profile_provider.dart';
import '../../services/database/database.dart';
import '../../services/km_reminder_service.dart';
import '../../services/models/enums.dart';
import '../../services/notification_service.dart';

class VehicleDetailScreen extends ConsumerWidget {
  final int vehicleId;
  const VehicleDetailScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final vehicleAsync = ref.watch(vehicleStreamProvider(vehicleId));

    return vehicleAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(body: Center(child: Text(l.commonError(e.toString())))),
      data: (vehicle) {
        if (vehicle == null) {
          return Scaffold(
            body: Center(child: Text(l.vehicleDetailNotFound)),
          );
        }
        return _VehicleDetailView(vehicle: vehicle);
      },
    );
  }
}

class _VehicleDetailView extends ConsumerWidget {
  final Vehicle vehicle;
  const _VehicleDetailView({required this.vehicle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final fuelType = FuelType.fromString(vehicle.fuelType);
    final skill = ref.watch(skillLevelProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('${vehicle.make} ${vehicle.model}'),
        actions: [
          PopupMenuButton<String>(
            tooltip: l.vehicleDetailMoreActions,
            onSelected: (v) {
              switch (v) {
                case 'mileage':
                  _editMileage(context, ref, vehicle);
                case 'delete':
                  _confirmDelete(context, ref, vehicle);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'mileage',
                child: ListTile(
                  leading: const Icon(Icons.speed),
                  title: Text(l.vehicleDetailUpdateMileage),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: Text(l.vehicleDetailDeleteVehicle,
                      style: const TextStyle(color: Colors.red)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: cs.primaryContainer,
                    child: Icon(
                      _fuelIcon(fuelType),
                      size: 32,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${vehicle.year} ${vehicle.make} ${vehicle.model}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fuelTypeLabel(l, fuelType),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Info grid
          _InfoGrid(
            vehicle: vehicle,
            onEditMileage: () => _editMileage(context, ref, vehicle),
          ),
          const SizedBox(height: 20),

          _SectionTitle(l.vehicleDetailSectionMaintenance),
          const SizedBox(height: 8),
          if (fuelType.supportsFuelLog)
            _ActionTile(
              icon: Icons.local_gas_station,
              iconColor: cs.primary,
              title: l.vehicleDetailFuelTitle,
              subtitle: l.vehicleDetailFuelSubtitle,
              onTap: () => context.push('/vehicle/${vehicle.id}/fuel'),
            ),
          _ActionTile(
            icon: Icons.notifications_outlined,
            iconColor: cs.primary,
            title: l.vehicleDetailRemindersTitle,
            subtitle: l.vehicleDetailRemindersSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/reminders'),
          ),
          _ActionTile(
            icon: Icons.history,
            iconColor: cs.primary,
            title: l.vehicleDetailHistoryTitle,
            subtitle: l.vehicleDetailHistorySubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/history'),
          ),
          _ActionTile(
            icon: Icons.oil_barrel_outlined,
            iconColor: cs.primary,
            title: l.vehicleDetailConsumablesTitle,
            subtitle: l.vehicleDetailConsumablesSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/consumables'),
          ),
          const SizedBox(height: 20),

          _SectionTitle(l.vehicleDetailSectionRepair),
          const SizedBox(height: 8),
          if (skill != SkillLevel.beginner)
            _ActionTile(
              icon: Icons.play_circle_outline,
              iconColor: cs.secondary,
              title: l.vehicleDetailTutorialsTitle,
              subtitle: l.vehicleDetailTutorialsSubtitle,
              onTap: () => context.push('/vehicle/${vehicle.id}/tutorials'),
            ),
          _ActionTile(
            icon: Icons.description_outlined,
            iconColor: cs.secondary,
            title: l.vehicleDetailReportTitle,
            subtitle: l.vehicleDetailReportSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/report'),
          ),
          _ActionTile(
            icon: Icons.mic_outlined,
            iconColor: cs.error,
            title: l.vehicleDetailBreakdownTitle,
            subtitle: l.vehicleDetailBreakdownSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/breakdown'),
          ),
          _ActionTile(
            icon: Icons.location_on_outlined,
            iconColor: cs.error,
            title: l.vehicleDetailGaragesTitle,
            subtitle: l.vehicleDetailGaragesSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/garages'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  IconData _fuelIcon(FuelType ft) => switch (ft) {
        FuelType.electric => Icons.bolt,
        FuelType.hybrid => Icons.eco,
        _ => Icons.local_gas_station,
      };

  Future<void> _editMileage(
      BuildContext context, WidgetRef ref, Vehicle vehicle) async {
    final l = AppLocalizations.of(context);
    final controller = TextEditingController(text: '${vehicle.currentMileage}');
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) {
        final lCtx = AppLocalizations.of(ctx);
        return AlertDialog(
          title: Text(lCtx.vehicleDetailUpdateMileageTitle),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: lCtx.vehicleDetailCurrentMileageLabel,
              suffixText: 'km',
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(lCtx.commonCancel),
            ),
            FilledButton(
              onPressed: () {
                final v = int.tryParse(controller.text.trim());
                if (v == null || v < 0) return;
                Navigator.pop(ctx, v);
              },
              child: Text(lCtx.commonSave),
            ),
          ],
        );
      },
    );

    if (result == null) return;
    await ref.read(vehiclesRepositoryProvider).updateMileage(vehicle.id, result);
    await checkKmReminders(ref.read(databaseProvider), vehicle.id, result, l);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.vehicleDetailMileageUpdated(_formatKm(result)))),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Vehicle vehicle) async {
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final lCtx = AppLocalizations.of(ctx);
        return AlertDialog(
          title: Text(lCtx.vehicleDetailDeleteTitle),
          content: Text(
            lCtx.vehicleDetailDeleteBody(vehicle.year, vehicle.make, vehicle.model),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(lCtx.commonCancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error,
              ),
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(lCtx.commonDelete),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    final reminderIds = await ref
        .read(vehiclesRepositoryProvider)
        .deleteVehicle(vehicle.id);

    final svc = NotificationService();
    for (final rid in reminderIds) {
      for (var i = 0; i < 3; i++) {
        await svc.cancel(rid * 10 + i);
      }
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.vehicleDetailDeleted)),
    );
    context.go('/');
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

class _InfoGrid extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onEditMileage;
  const _InfoGrid({required this.vehicle, required this.onEditMileage});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 2.4,
      children: [
        _InfoTile(
          icon: Icons.speed,
          label: l.vehicleDetailKmLabel,
          value: '${_formatKm(vehicle.currentMileage)} km',
          trailing: Icon(Icons.edit, size: 14,
              color: Theme.of(context).colorScheme.outline),
          onTap: onEditMileage,
        ),
        _InfoTile(
          icon: Icons.calendar_today,
          label: l.vehicleDetailYearLabel,
          value: '${vehicle.year}',
        ),
        if (vehicle.vin != null)
          _InfoTile(
            icon: Icons.qr_code,
            label: l.vehicleDetailVinLabel,
            value: vehicle.vin!,
          ),
      ],
    );
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainerHighest,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(icon, size: 18, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: cs.outline)),
                    Text(value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold));
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
