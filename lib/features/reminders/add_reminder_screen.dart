import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
  DateTime _dueDate = DateTime.now().add(const Duration(days: 180));
  final _mileageCtrl = TextEditingController();
  final _customLabelCtrl = TextEditingController();
  final _customOffsetCtrl = TextEditingController();
  Set<int> _offsets = {56, 28, 7};
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
      locale: const Locale('de'),
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
      builder: (ctx) => AlertDialog(
        title: const Text('Benachrichtigungen deaktiviert'),
        content: const Text(
          'Ohne Benachrichtigungen können wir dich nicht an anstehende '
          'Wartungen erinnern. In den Systemeinstellungen kannst du die '
          'Freigabe nachträglich erteilen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Trotzdem speichern'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Einstellungen öffnen'),
          ),
        ],
      ),
    );
    if (openSettings == true) {
      await svc.openSystemSettings();
    }
    return false;
  }

  Future<void> _save() async {
    if (_type == ReminderType.custom &&
        _customLabelCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte gib einen Namen für die eigene Erinnerung ein.')),
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
          notifyOffsetsDays: Value(SettingsService.encodeOffsets(sortedOffsets)),
          createdAt: DateTime.now(),
        ),
      );

      if (hasPermission && sortedOffsets.isNotEmpty) {
        final svc = NotificationService();
        final title = customLabel ?? _type.displayName;
        for (var i = 0; i < sortedOffsets.length; i++) {
          final days = sortedOffsets[i];
          final when = _dueDate.subtract(Duration(days: days));
          try {
            await svc.schedule(
              id: id * 100 + i,
              title: 'AutoMate · $title',
              body: _offsetLabel(days, short: false),
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
        SnackBar(content: Text('Speichern fehlgeschlagen: $e')),
      );
    }
  }

  String _offsetLabel(int days, {bool short = true}) {
    if (days == 1) return short ? '1 Tag' : 'Noch 1 Tag bis zur Fälligkeit.';
    if (days < 7) return short ? '$days Tage' : 'Noch $days Tage bis zur Fälligkeit.';
    if (days == 7) return short ? '1 Woche' : 'Noch 1 Woche bis zur Fälligkeit.';
    if (days % 7 == 0) {
      final w = days ~/ 7;
      return short ? '$w Wochen' : 'Noch $w Wochen bis zur Fälligkeit.';
    }
    return short ? '$days Tage' : 'Noch $days Tage bis zur Fälligkeit.';
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final fmt = DateFormat('dd.MM.yyyy', 'de');
    final cs = Theme.of(context).colorScheme;
    final sortedOffsets = _offsets.toList()..sort((a, b) => b.compareTo(a));
    const presets = [1, 3, 7, 14, 28, 56, 90];

    return Scaffold(
      appBar: AppBar(title: const Text('Neue Erinnerung')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Art der Wartung',
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
              decoration: const InputDecoration(
                labelText: 'Eigene Bezeichnung',
                hintText: 'z.B. Pollenfilter wechseln',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Text('Fälligkeitsdatum',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(fmt.format(_dueDate)),
              subtitle: const Text('Zum Ändern tippen'),
              trailing: const Icon(Icons.edit_calendar),
              onTap: _pickDate,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _mileageCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Fällig bei Kilometerstand (optional)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.speed),
              suffixText: 'km',
              helperText: 'Falls die Wartung auch vom Kilometerstand abhängt',
            ),
          ),
          const SizedBox(height: 24),
          Text('Benachrichtigungen',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          Text(
            'Wann möchtest du vor der Fälligkeit erinnert werden?',
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
                  label: Text(_offsetLabel(d)),
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
                  decoration: const InputDecoration(
                    labelText: 'Eigener Zeitpunkt',
                    border: OutlineInputBorder(),
                    suffixText: 'Tage',
                    isDense: true,
                  ),
                  onSubmitted: (_) => _addCustomOffset(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                onPressed: _addCustomOffset,
                icon: const Icon(Icons.add),
                tooltip: 'Hinzufügen',
              ),
            ],
          ),
          if (sortedOffsets.isEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Keine Benachrichtigungen aktiv — die Erinnerung wird nur in der Liste angezeigt.',
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
              label: Text(_saving ? 'Speichere ...' : 'Erinnerung anlegen'),
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
      ReminderType.oilChange => 'Ölwechsel',
      ReminderType.tuev => 'TÜV / HU',
      ReminderType.majorService => 'Große Inspektion',
      ReminderType.minorService => 'Kleine Inspektion',
      ReminderType.tyreSwap => 'Reifenwechsel',
      ReminderType.custom => 'Sonstiges',
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
