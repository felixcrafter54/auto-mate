import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/settings_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _claudeCtrl = TextEditingController();
  final _youtubeCtrl = TextEditingController();
  String _language = 'de';
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
    if (!mounted) return;
    setState(() {
      _claudeCtrl.text = claude ?? '';
      _youtubeCtrl.text = yt ?? '';
      _language = lang;
      _loading = false;
    });
  }

  Future<void> _save() async {
    final svc = ref.read(settingsServiceProvider);
    await svc.set(kSettingClaudeApiKey, _claudeCtrl.text.trim());
    await svc.set(kSettingYoutubeApiKey, _youtubeCtrl.text.trim());
    await svc.set(kSettingReportLanguage, _language);
    ref.invalidate(claudeKeyProvider);
    ref.invalidate(youtubeKeyProvider);
    ref.invalidate(reportLanguageProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Einstellungen gespeichert')),
    );
  }

  @override
  void dispose() {
    _claudeCtrl.dispose();
    _youtubeCtrl.dispose();
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
