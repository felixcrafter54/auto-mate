import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/fuel_labels.dart';
import '../../core/providers/database_provider.dart';
import '../../core/providers/profile_provider.dart';
import '../../core/widgets/action_tile.dart';
import '../../core/widgets/info_row.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/status_badge.dart';
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
      error: (e, _) =>
          Scaffold(body: Center(child: Text(l.commonError(e.toString())))),
      data: (vehicle) {
        if (vehicle == null) {
          return Scaffold(body: Center(child: Text(l.vehicleDetailNotFound)));
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
    final tt = Theme.of(context).textTheme;

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
                  leading: const Icon(Icons.speed_rounded),
                  title: Text(l.vehicleDetailUpdateMileage),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete_outline,
                      color: cs.error),
                  title: Text(l.vehicleDetailDeleteVehicle,
                      style: TextStyle(color: cs.error)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          // Hero header
          _HeroCard(vehicle: vehicle, fuelType: fuelType, onEditMileage: () => _editMileage(context, ref, vehicle)),
          const SizedBox(height: 20),

          // Maintenance section
          SectionHeader(l.vehicleDetailSectionMaintenance),
          const SizedBox(height: 8),
          if (fuelType.supportsFuelLog)
            ActionTile(
              icon: Icons.local_gas_station_rounded,
              title: l.vehicleDetailFuelTitle,
              subtitle: l.vehicleDetailFuelSubtitle,
              onTap: () => context.push('/vehicle/${vehicle.id}/fuel'),
              accentColor: cs.primary,
            ),
          ActionTile(
            icon: Icons.notifications_outlined,
            title: l.vehicleDetailRemindersTitle,
            subtitle: l.vehicleDetailRemindersSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/reminders'),
            accentColor: cs.primary,
          ),
          ActionTile(
            icon: Icons.history_rounded,
            title: l.vehicleDetailHistoryTitle,
            subtitle: l.vehicleDetailHistorySubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/history'),
            accentColor: cs.primary,
          ),
          ActionTile(
            icon: Icons.oil_barrel_outlined,
            title: l.vehicleDetailConsumablesTitle,
            subtitle: l.vehicleDetailConsumablesSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/consumables'),
            accentColor: cs.primary,
          ),
          const SizedBox(height: 12),

          // Repair section
          SectionHeader(l.vehicleDetailSectionRepair),
          const SizedBox(height: 8),
          if (skill != SkillLevel.beginner)
            ActionTile(
              icon: Icons.play_circle_outline_rounded,
              title: l.vehicleDetailTutorialsTitle,
              subtitle: l.vehicleDetailTutorialsSubtitle,
              onTap: () => context.push('/vehicle/${vehicle.id}/tutorials'),
              accentColor: cs.tertiary,
            ),
          ActionTile(
            icon: Icons.description_outlined,
            title: l.vehicleDetailReportTitle,
            subtitle: l.vehicleDetailReportSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/report'),
            accentColor: cs.tertiary,
          ),
          ActionTile(
            icon: Icons.mic_rounded,
            title: l.vehicleDetailBreakdownTitle,
            subtitle: l.vehicleDetailBreakdownSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/breakdown'),
            accentColor: cs.error,
          ),
          ActionTile(
            icon: Icons.location_on_outlined,
            title: l.vehicleDetailGaragesTitle,
            subtitle: l.vehicleDetailGaragesSubtitle,
            onTap: () => context.push('/vehicle/${vehicle.id}/garages'),
            accentColor: cs.error,
          ),
        ],
      ),
    );
  }

  Future<void> _editMileage(
      BuildContext context, WidgetRef ref, Vehicle vehicle) async {
    final l = AppLocalizations.of(context);
    final controller =
        TextEditingController(text: '${vehicle.currentMileage}');
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
      SnackBar(
          content: Text(l.vehicleDetailMileageUpdated(_formatKm(result)))),
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
            lCtx.vehicleDetailDeleteBody(
                vehicle.year, vehicle.make, vehicle.model),
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

    final reminderIds =
        await ref.read(vehiclesRepositoryProvider).deleteVehicle(vehicle.id);

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

class _HeroCard extends StatelessWidget {
  final Vehicle vehicle;
  final FuelType fuelType;
  final VoidCallback onEditMileage;

  const _HeroCard({
    required this.vehicle,
    required this.fuelType,
    required this.onEditMileage,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [cs.primaryContainer, cs.surfaceContainerHighest],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: cs.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(_fuelIcon(fuelType),
                        color: cs.primary, size: 26),
                  ),
                  const SizedBox(width: 14),
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
                  StatusBadge(
                    label: fuelTypeLabel(l, fuelType),
                    color: fuelType == FuelType.electric ||
                            fuelType == FuelType.hybrid
                        ? cs.tertiary
                        : cs.primary,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),
              InfoRow(
                icon: Icons.speed_rounded,
                label: l.vehicleDetailKmLabel,
                value: '${_formatKm(vehicle.currentMileage)} km',
                trailing: GestureDetector(
                  onTap: onEditMileage,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_formatKm(vehicle.currentMileage)} km',
                        style: tt.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.edit_rounded,
                          size: 14, color: cs.onSurfaceVariant),
                    ],
                  ),
                ),
              ),
              if (vehicle.vin != null)
                InfoRow(
                  icon: Icons.qr_code_rounded,
                  label: l.vehicleDetailVinLabel,
                  value: vehicle.vin!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _fuelIcon(FuelType ft) => switch (ft) {
        FuelType.electric => Icons.bolt_rounded,
        FuelType.hybrid => Icons.eco_rounded,
        _ => Icons.local_gas_station_rounded,
      };

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
