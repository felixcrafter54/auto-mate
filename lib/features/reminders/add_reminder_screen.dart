import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/providers/database_provider.dart';
import '../../services/database/database.dart';
import '../../services/models/enums.dart';
import '../../services/notification_service.dart';

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
  bool _saving = false;

  @override
  void dispose() {
    _mileageCtrl.dispose();
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

  Future<void> _save() async {
    setState(() => _saving = true);
    final repo = ref.read(remindersRepositoryProvider);
    final mileage = int.tryParse(_mileageCtrl.text);

    final id = await repo.insertReminder(
      RemindersCompanion.insert(
        vehicleId: widget.vehicleId,
        type: _type.dbValue,
        dueDate: _dueDate,
        dueMileage: Value(mileage),
        createdAt: DateTime.now(),
      ),
    );

    // Schedule reminders 8w / 4w / 1w before due date.
    final svc = NotificationService();
    final offsets = [const Duration(days: 56), const Duration(days: 28), const Duration(days: 7)];
    for (var i = 0; i < offsets.length; i++) {
      final when = _dueDate.subtract(offsets[i]);
      await svc.schedule(
        id: id * 10 + i,
        title: 'AutoMate · ${_type.displayName}',
        body: i == 2
            ? 'Noch 1 Woche bis zur Fälligkeit.'
            : 'Noch ${offsets[i].inDays ~/ 7} Wochen bis zur Fälligkeit.',
        when: when,
      );
    }

    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd.MM.yyyy', 'de');

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
