import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/notification_service.dart';
import '../../services/settings_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _claudeCtrl = TextEditingController();
  final _youtubeCtrl = TextEditingController();
  final _customOffsetCtrl = TextEditingController();
  String _language = 'de';
  Set<int> _notifyOffsets = {56, 28, 7};
  bool _notifyPermissionGranted = false;
  bool _loading = true;
  bool _revealClaude = false;
  bool _revealYoutube = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final svc = ref.read(settingsServiceProvider);
    final claude = await svc.getClaudeKey();
    final yt = await svc.getYoutubeKey();
    final lang = await svc.getReportLanguage();
    final offsets = await svc.getDefaultNotifyOffsets();
    final permGranted = await NotificationService().hasPermission();
    if (!mounted) return;
    setState(() {
      _claudeCtrl.text = claude ?? '';
      _youtubeCtrl.text = yt ?? '';
      _language = lang;
      _notifyOffsets = offsets.toSet();
      _notifyPermissionGranted = permGranted;
      _loading = false;
    });
  }

  Future<void> _save() async {
    final svc = ref.read(settingsServiceProvider);
    await svc.set(kSettingClaudeApiKey, _claudeCtrl.text.trim());
    await svc.set(kSettingYoutubeApiKey, _youtubeCtrl.text.trim());
    await svc.set(kSettingReportLanguage, _language);
    await svc.setDefaultNotifyOffsets(_notifyOffsets.toList());
    ref.invalidate(claudeKeyProvider);
    ref.invalidate(youtubeKeyProvider);
    ref.invalidate(reportLanguageProvider);
    ref.invalidate(defaultNotifyOffsetsProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Einstellungen gespeichert')),
    );
  }

  Future<void> _requestNotifyPermission() async {
    final granted = await NotificationService().requestPermission();
    if (!mounted) return;
    setState(() => _notifyPermissionGranted = granted);
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Berechtigung abgelehnt. Öffne die Systemeinstellungen, um sie zu erlauben.'),
          action: SnackBarAction(
            label: 'Einstellungen',
            onPressed: () => NotificationService().openSystemSettings(),
          ),
        ),
      );
    }
  }

  void _addCustomOffset() {
    final n = int.tryParse(_customOffsetCtrl.text.trim());
    if (n == null || n <= 0) return;
    setState(() {
      _notifyOffsets.add(n);
      _customOffsetCtrl.clear();
    });
  }

  String _offsetLabel(int days) {
    if (days == 1) return '1 Tag';
    if (days < 7) return '$days Tage';
    if (days == 7) return '1 Woche';
    if (days % 7 == 0) return '${days ~/ 7} Wochen';
    return '$days Tage';
  }

  @override
  void dispose() {
    _claudeCtrl.dispose();
    _youtubeCtrl.dispose();
    _customOffsetCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionTitle('API-Schlüssel'),
          const SizedBox(height: 4),
          Text(
            'Die Schlüssel werden nur lokal auf deinem Gerät gespeichert. '
            'Du brauchst sie, um die KI-Features und die YouTube-Tutorials zu nutzen.',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: cs.outline),
          ),
          const SizedBox(height: 16),

          // Claude
          TextField(
            controller: _claudeCtrl,
            obscureText: !_revealClaude,
            decoration: InputDecoration(
              labelText: 'Claude API-Key (Anthropic)',
              hintText: 'sk-ant-...',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.psychology_outlined),
              suffixIcon: IconButton(
                icon: Icon(_revealClaude ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _revealClaude = !_revealClaude),
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            icon: const Icon(Icons.open_in_new, size: 16),
            label: const Text('Key bei Anthropic anlegen'),
            onPressed: () =>
                _open('https://console.anthropic.com/settings/keys'),
          ),
          const SizedBox(height: 16),

          // YouTube
          TextField(
            controller: _youtubeCtrl,
            obscureText: !_revealYoutube,
            decoration: InputDecoration(
              labelText: 'YouTube Data API v3 Key',
              hintText: 'AIza...',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.play_circle_outline),
              suffixIcon: IconButton(
                icon:
                    Icon(_revealYoutube ? Icons.visibility_off : Icons.visibility),
                onPressed: () =>
                    setState(() => _revealYoutube = !_revealYoutube),
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            icon: const Icon(Icons.open_in_new, size: 16),
            label: const Text('Key bei Google Cloud anlegen'),
            onPressed: () => _open('https://console.cloud.google.com/apis/credentials'),
          ),
          const SizedBox(height: 28),

          _SectionTitle('Benachrichtigungen'),
          const SizedBox(height: 8),
          if (!kIsWeb) ...[
            Card(
              color: _notifyPermissionGranted
                  ? cs.primaryContainer.withValues(alpha: 0.35)
                  : cs.errorContainer.withValues(alpha: 0.35),
              child: ListTile(
                leading: Icon(
                  _notifyPermissionGranted
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: _notifyPermissionGranted ? cs.primary : cs.error,
                ),
                title: Text(_notifyPermissionGranted
                    ? 'Benachrichtigungen sind aktiv'
                    : 'Benachrichtigungen sind deaktiviert'),
                subtitle: Text(_notifyPermissionGranted
                    ? 'Du bekommst Erinnerungen zu fälligen Wartungen.'
                    : 'Ohne Berechtigung kann AutoMate dich nicht erinnern.'),
                trailing: _notifyPermissionGranted
                    ? null
                    : FilledButton(
                        onPressed: _requestNotifyPermission,
                        child: const Text('Erlauben'),
                      ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            'Standard-Erinnerungszeitpunkte vor Fälligkeit. Lässt sich pro Erinnerung überschreiben.',
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
              for (final d in {...const [1, 3, 7, 14, 28, 56, 90], ..._notifyOffsets}
                  .toList()
                ..sort((a, b) => a.compareTo(b)))
                FilterChip(
                  label: Text(_offsetLabel(d)),
                  selected: _notifyOffsets.contains(d),
                  onSelected: (sel) => setState(() {
                    if (sel) {
                      _notifyOffsets.add(d);
                    } else {
                      _notifyOffsets.remove(d);
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
          const SizedBox(height: 28),

          _SectionTitle('Werkstattbericht'),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Berichtsprache',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.translate),
              helperText: 'Nützlich wenn du im Ausland liegen bleibst.',
            ),
            initialValue: _language,
            items: const [
              DropdownMenuItem(value: 'de', child: Text('Deutsch')),
              DropdownMenuItem(value: 'en', child: Text('Englisch')),
              DropdownMenuItem(value: 'fr', child: Text('Französisch')),
              DropdownMenuItem(value: 'es', child: Text('Spanisch')),
              DropdownMenuItem(value: 'it', child: Text('Italienisch')),
            ],
            onChanged: (v) => setState(() => _language = v ?? 'de'),
          ),
          const SizedBox(height: 32),

          FilledButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Speichern'),
            onPressed: _save,
          ),

          if (kIsWeb) ...[
            const SizedBox(height: 32),
            Card(
              color: cs.tertiaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: cs.onTertiaryContainer),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Du nutzt die Web-Version. Sprach-Assistent, OBD-II und Kamera-Scan '
                        'funktionieren nur in der Mobile-App.',
                        style: TextStyle(color: cs.onTertiaryContainer),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
