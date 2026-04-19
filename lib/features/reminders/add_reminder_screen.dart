import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/l10n/reminder_labels.dart';
import '../../core/providers/database_provider.dart';
import '../../services/database/database.dart';
import '../../services/models/enums.dart';
import '../../services/notification_service.dart';
import '../../services/settings_service.dart';

class AddReminderScreen extends ConsumerStatefulWidget {
  final int vehicleId;
  const AddReminderScreen({super.key, required this.vehicleId});

  @override
  ConsumerState<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends ConsumerState<AddReminderScreen> {
  ReminderType _type = ReminderType.oilChange;
  DateTime _dueDate = DateTime.now();
  final _mileageCtrl = TextEditingController();
  final _customLabelCtrl = TextEditingController();
  final _customOffsetCtrl = TextEditingController();
  Set<int> _offsets = {56, 28, 7};
  int _notifyOffsetKm = 0;
  bool _loaded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadDefaults();
  }

  Future<void> _loadDefaults() async {
    final offsets = await ref.read(settingsServiceProvider).getDefaultNotifyOffsets();
    if (!mounted) return;
    setState(() {
      _offsets = offsets.toSet();
      _loaded = true;
    });
  }

  @override
  void dispose() {
    _mileageCtrl.dispose();
    _customLabelCtrl.dispose();
    _customOffsetCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
      locale: Localizations.localeOf(context),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  void _addCustomOffset() {
    final n = int.tryParse(_customOffsetCtrl.text.trim());
    if (n == null || n <= 0) return;
    setState(() {
      _offsets.add(n);
      _customOffsetCtrl.clear();
    });
  }

  Future<bool> _ensurePermission() async {
    final svc = NotificationService();
    if (await svc.hasPermission()) return true;
    final granted = await svc.requestPermission();
    if (granted) return true;
    if (!mounted) return false;
    final openSettings = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final lCtx = AppLocalizations.of(ctx);
        return AlertDialog(
          title: Text(lCtx.addReminderNotificationsDisabledTitle),
          content: Text(lCtx.addReminderNotificationsDisabledBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(lCtx.addReminderSaveAnyway),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(lCtx.addReminderOpenSettings),
            ),
          ],
        );
      },
    );
    if (openSettings == true) {
      await svc.openSystemSettings();
    }
    return false;
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    if (_type == ReminderType.custom &&
        _customLabelCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.addReminderCustomNameError)),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      final sortedOffsets = _offsets.toList()..sort((a, b) => b.compareTo(a));
      final hasPermission = await _ensurePermission();

      final repo = ref.read(remindersRepositoryProvider);
      final mileage = int.tryParse(_mileageCtrl.text);
      final customLabel = _type == ReminderType.custom
          ? _customLabelCtrl.text.trim()
          : null;

      final id = await repo.insertReminder(
        RemindersCompanion.insert(
          vehicleId: widget.vehicleId,
          type: _type.dbValue,
          customLabel: Value(customLabel),
          dueDate: _dueDate,
          dueMileage: Value(mileage),
          notifyOffsetKm: Value(mileage != null ? _notifyOffsetKm : null),
          notifyOffsetsDays: Value(SettingsService.encodeOffsets(sortedOffsets)),
          createdAt: DateTime.now(),
        ),
      );

      if (hasPermission && sortedOffsets.isNotEmpty) {
        final svc = NotificationService();
        final title = reminderLabel(l, _type, customLabel: customLabel);
        for (var i = 0; i < sortedOffsets.length; i++) {
          final days = sortedOffsets[i];
          final when = _dueDate.subtract(Duration(days: days));
          try {
            await svc.schedule(
              id: id * 100 + i,
              title: 'AutoMate · $title',
              body: _offsetLabelLong(l, days),
              when: when,
            );
          } catch (_) {
            // Scheduling a single notification failed (e.g. exact-alarm
            // permission on Android 12+). Continue with the rest — the
            // reminder itself is already persisted.
          }
        }
      }

      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).addReminderSaveFailed(e.toString()))),
      );
    }
  }

  String _offsetLabel(AppLocalizations l, int days) {
    if (days == 1) return l.addReminderDay;
    if (days < 7) return l.addReminderDays(days);
    if (days == 7) return l.addReminderWeek;
    if (days % 7 == 0) return l.addReminderWeeks(days ~/ 7);
    return l.addReminderDays(days);
  }

  String _offsetLabelLong(AppLocalizations l, int days) {
    if (days == 1) return l.addReminderNotifDay;
    if (days < 7) return l.addReminderNotifDays(days);
    if (days == 7) return l.addReminderNotifWeek;
    if (days % 7 == 0) return l.addReminderNotifWeeks(days ~/ 7);
    return l.addReminderNotifDays(days);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final l = AppLocalizations.of(context);
    final fmt = DateFormat('dd.MM.yyyy', 'de');
    final cs = Theme.of(context).colorScheme;
    final sortedOffsets = _offsets.toList()..sort((a, b) => b.compareTo(a));
    const presets = [1, 3, 7, 14, 28, 56, 90];

    return Scaffold(
      appBar: AppBar(title: Text(l.addReminderTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l.addReminderTypeLabel,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(height: 8),
          ...ReminderType.values.map((t) => _TypeTile(
                type: t,
                selected: t == _type,
                onTap: () => setState(() => _type = t),
              )),
          if (_type == ReminderType.custom) ...[
            const SizedBox(height: 16),
            TextField(
              controller: _customLabelCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l.addReminderCustomLabel,
                hintText: l.addReminderCustomPlaceholder,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.edit_note),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Text(l.addReminderDueDateLabel,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(fmt.format(_dueDate)),
              subtitle: Text(l.addReminderDueDateHint),
              trailing: const Icon(Icons.edit_calendar),
              onTap: _pickDate,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _mileageCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l.addReminderDueMileageLabel,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.speed),
              suffixText: 'km',
              helperText: l.addReminderDueMileageHint,
            ),
            onChanged: (_) => setState(() {}),
          ),
          if (_mileageCtrl.text.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              l.addReminderKmOffsetLabel,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              l.addReminderKmOffsetHint,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: cs.outline),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final km in [0, 500, 1000, 2000, 5000])
                  ChoiceChip(
                    label: Text(km == 0 ? l.addReminderAtDue : l.addReminderKmBefore(km)),
                    selected: _notifyOffsetKm == km,
                    onSelected: (_) => setState(() => _notifyOffsetKm = km),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          Text(l.addReminderNotificationsLabel,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          Text(
            l.addReminderNotificationsHint,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: cs.outline),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final d in {...presets, ..._offsets}.toList()
                ..sort((a, b) => a.compareTo(b)))
                FilterChip(
                  label: Text(_offsetLabel(l, d)),
                  selected: _offsets.contains(d),
                  onSelected: (sel) => setState(() {
                    if (sel) {
                      _offsets.add(d);
                    } else {
                      _offsets.remove(d);
                    }
                  }),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _customOffsetCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l.addReminderCustomTimeLabel,
                    border: const OutlineInputBorder(),
                    suffixText: l.addReminderDaysSuffix,
                    isDense: true,
                  ),
                  onSubmitted: (_) => _addCustomOffset(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                onPressed: _addCustomOffset,
                icon: const Icon(Icons.add),
                tooltip: l.commonAdd,
              ),
            ],
          ),
          if (sortedOffsets.isEmpty) ...[
            const SizedBox(height: 8),
            Text(
              l.addReminderNoNotifications,
              style: TextStyle(color: cs.outline),
            ),
          ],
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.check),
              label: Text(_saving ? l.addReminderSavingButton : l.addReminderSaveButton),
              onPressed: _saving ? null : _save,
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeTile extends StatelessWidget {
  final ReminderType type;
  final bool selected;
  final VoidCallback onTap;
  const _TypeTile({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final icon = switch (type) {
      ReminderType.oilChange => Icons.oil_barrel,
      ReminderType.tuev => Icons.verified_outlined,
      ReminderType.majorService => Icons.build,
      ReminderType.minorService => Icons.build_outlined,
      ReminderType.tyreSwap => Icons.tire_repair,
      ReminderType.custom => Icons.notifications_active_outlined,
    };
    final label = switch (type) {
      ReminderType.oilChange => l.reminderTypeOilChange,
      ReminderType.tuev => l.reminderTypeTuev,
      ReminderType.majorService => l.reminderTypeMajorService,
      ReminderType.minorService => l.reminderTypeMinorService,
      ReminderType.tyreSwap => l.reminderTypeTyreSwap,
      ReminderType.custom => l.reminderTypeCustom,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: selected
            ? BorderSide(color: cs.primary, width: 2)
            : BorderSide.none,
      ),
      color: selected ? cs.primaryContainer : null,
      child: ListTile(
        leading: Icon(icon, color: selected ? cs.primary : null),
        title: Text(label,
            style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            )),
        trailing: selected
            ? Icon(Icons.check_circle, color: cs.primary)
            : const Icon(Icons.radio_button_unchecked),
        onTap: onTap,
      ),
    );
  }
}
