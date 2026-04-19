import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/providers/locale_provider.dart';
import '../../services/notification_service.dart';
import '../../services/settings_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _geminiCtrl = TextEditingController();
  final _youtubeCtrl = TextEditingController();
  final _customOffsetCtrl = TextEditingController();
  String _language = 'de';
  Locale? _appLocale;
  Set<int> _notifyOffsets = {56, 28, 7};
  bool _notifyPermissionGranted = false;
  bool _loading = true;
  bool _revealGemini = false;
  bool _revealYoutube = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final svc = ref.read(settingsServiceProvider);
    final gemini = await svc.getGeminiKey();
    final yt = await svc.getYoutubeKey();
    final lang = await svc.getReportLanguage();
    final offsets = await svc.getDefaultNotifyOffsets();
    final permGranted = await NotificationService().hasPermission();
    final localeCode = await svc.get(kSettingAppLocale);
    if (!mounted) return;
    setState(() {
      _geminiCtrl.text = gemini ?? '';
      _youtubeCtrl.text = yt ?? '';
      _language = lang;
      _appLocale = localeCode != null && localeCode.isNotEmpty ? Locale(localeCode) : null;
      _notifyOffsets = offsets.toSet();
      _notifyPermissionGranted = permGranted;
      _loading = false;
    });
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final svc = ref.read(settingsServiceProvider);
    await svc.set(kSettingGeminiApiKey, _geminiCtrl.text.trim());
    await svc.set(kSettingYoutubeApiKey, _youtubeCtrl.text.trim());
    await svc.set(kSettingReportLanguage, _language);
    await svc.setDefaultNotifyOffsets(_notifyOffsets.toList());
    await ref.read(localeNotifierProvider.notifier).setLocale(_appLocale);
    ref.invalidate(geminiKeyProvider);
    ref.invalidate(youtubeKeyProvider);
    ref.invalidate(reportLanguageProvider);
    ref.invalidate(defaultNotifyOffsetsProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.settingsSaved)),
    );
  }

  Future<void> _requestNotifyPermission() async {
    final l = AppLocalizations.of(context);
    final granted = await NotificationService().requestPermission();
    if (!mounted) return;
    setState(() => _notifyPermissionGranted = granted);
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.settingsPermissionDenied),
          action: SnackBarAction(
            label: l.settingsTitle,
            onPressed: () => NotificationService().openSystemSettings(),
          ),
        ),
      );
    }
  }

  Future<void> _scheduleTwoMinuteTest() async {
    final l = AppLocalizations.of(context);
    final svc = NotificationService();
    var granted = await svc.hasPermission();
    if (!granted) granted = await svc.requestPermission();
    if (!mounted) return;
    setState(() => _notifyPermissionGranted = granted);
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.settingsPermissionError)),
      );
      return;
    }
    final when = DateTime.now().add(const Duration(minutes: 2));
    try {
      await svc.cancel(999998);
      await svc.schedule(
        id: 999998,
        title: 'AutoMate · Test',
        body: l.settingsScheduledNotification,
        when: when,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            kIsWeb ? l.settingsScheduledPwa : l.settingsScheduledMobile,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.settingsScheduleFailed(e.toString()))),
      );
    }
  }

  Future<void> _sendTestNotification() async {
    final l = AppLocalizations.of(context);
    final svc = NotificationService();
    var granted = await svc.hasPermission();
    if (!granted) granted = await svc.requestPermission();
    if (!mounted) return;
    setState(() => _notifyPermissionGranted = granted);
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.settingsPermissionError)),
      );
      return;
    }
    await svc.showNow(
      id: 999999,
      title: 'AutoMate · Test',
      body: l.settingsNotificationsWork,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.settingsTestSent)),
    );
  }

  void _addCustomOffset() {
    final n = int.tryParse(_customOffsetCtrl.text.trim());
    if (n == null || n <= 0) return;
    setState(() {
      _notifyOffsets.add(n);
      _customOffsetCtrl.clear();
    });
  }

  String _offsetLabel(AppLocalizations l, int days) {
    if (days == 1) return l.addReminderDay;
    if (days < 7) return l.addReminderDays(days);
    if (days == 7) return l.addReminderWeek;
    if (days % 7 == 0) return l.addReminderWeeks(days ~/ 7);
    return l.addReminderDays(days);
  }

  @override
  void dispose() {
    _geminiCtrl.dispose();
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

    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionTitle(l.settingsApiKeysSection),
          const SizedBox(height: 4),
          Text(
            l.settingsApiKeysHint,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: cs.outline),
          ),
          const SizedBox(height: 16),

          // Gemini
          TextField(
            controller: _geminiCtrl,
            obscureText: !_revealGemini,
            decoration: InputDecoration(
              labelText: l.settingsGeminiKeyLabel,
              hintText: l.settingsGeminiKeyHint,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.psychology_outlined),
              suffixIcon: IconButton(
                icon: Icon(_revealGemini ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _revealGemini = !_revealGemini),
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            icon: const Icon(Icons.open_in_new, size: 16),
            label: Text(l.settingsGeminiKeyLink),
            onPressed: () => _open('https://aistudio.google.com/app/apikey'),
          ),
          const SizedBox(height: 16),

          // YouTube
          TextField(
            controller: _youtubeCtrl,
            obscureText: !_revealYoutube,
            decoration: InputDecoration(
              labelText: l.settingsYouTubeKeyLabel,
              hintText: l.settingsGeminiKeyHint,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.play_circle_outline),
              suffixIcon: IconButton(
                icon: Icon(_revealYoutube ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _revealYoutube = !_revealYoutube),
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            icon: const Icon(Icons.open_in_new, size: 16),
            label: Text(l.settingsYouTubeKeyLink),
            onPressed: () => _open('https://console.cloud.google.com/apis/credentials'),
          ),
          const SizedBox(height: 28),

          _SectionTitle(l.settingsNotificationsSection),
          const SizedBox(height: 8),
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
                  ? l.settingsNotificationsActive
                  : l.settingsNotificationsDisabled),
              subtitle: Text(_notifyPermissionGranted
                  ? (kIsWeb
                      ? l.settingsPwaNotificationsHint
                      : l.settingsNotificationsActiveHint)
                  : l.settingsNotificationsNoPermission),
              trailing: _notifyPermissionGranted
                  ? null
                  : FilledButton(
                      onPressed: _requestNotifyPermission,
                      child: Text(l.settingsAllowNotifications),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.notifications_outlined),
            label: Text(l.settingsSendTestNotification),
            onPressed: _sendTestNotification,
          ),
          const SizedBox(height: 6),
          OutlinedButton.icon(
            icon: const Icon(Icons.timer_outlined),
            label: Text(l.settingsScheduleTestNotification),
            onPressed: _scheduleTwoMinuteTest,
          ),
          const SizedBox(height: 12),
          Text(
            l.settingsDefaultRemindersHint,
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
                  label: Text(_offsetLabel(l, d)),
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
          const SizedBox(height: 28),

          _SectionTitle(l.settingsAppLanguageSection),
          const SizedBox(height: 12),
          DropdownButtonFormField<String?>(
            decoration: InputDecoration(
              labelText: l.settingsAppLanguageLabel,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.language),
            ),
            initialValue: _appLocale?.languageCode,
            items: [
              DropdownMenuItem(
                value: null,
                child: Row(children: [
                  const Icon(Icons.language, size: 24),
                  const SizedBox(width: 10),
                  Text(l.settingsAppLanguageSystem),
                ]),
              ),
              DropdownMenuItem(
                value: 'de',
                child: Row(children: [
                  CountryFlag.fromCountryCode('DE', height: 20, width: 28, shape: const RoundedRectangle(4)),
                  const SizedBox(width: 10),
                  Text(l.settingsLangDe),
                ]),
              ),
              DropdownMenuItem(
                value: 'en',
                child: Row(children: [
                  CountryFlag.fromCountryCode('GB', height: 20, width: 28, shape: const RoundedRectangle(4)),
                  const SizedBox(width: 10),
                  Text(l.settingsLangEn),
                ]),
              ),
              DropdownMenuItem(
                value: 'hr',
                child: Row(children: [
                  CountryFlag.fromCountryCode('HR', height: 20, width: 28, shape: const RoundedRectangle(4)),
                  const SizedBox(width: 10),
                  Text(l.settingsLangHr),
                ]),
              ),
            ],
            onChanged: (v) => setState(
              () => _appLocale = v != null ? Locale(v) : null,
            ),
          ),
          const SizedBox(height: 28),

          _SectionTitle(l.settingsReportSection),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: l.settingsReportLanguageLabel,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.translate),
              helperText: l.settingsReportLanguageHint,
            ),
            initialValue: _language,
            items: [
              DropdownMenuItem(value: 'de', child: Text(l.settingsLangDe)),
              DropdownMenuItem(value: 'en', child: Text(l.settingsLangEn)),
              DropdownMenuItem(value: 'fr', child: Text(l.settingsLangFr)),
              DropdownMenuItem(value: 'es', child: Text(l.settingsLangEs)),
              DropdownMenuItem(value: 'it', child: Text(l.settingsLangIt)),
            ],
            onChanged: (v) => setState(() => _language = v ?? 'de'),
          ),
          const SizedBox(height: 32),

          FilledButton.icon(
            icon: const Icon(Icons.save),
            label: Text(l.settingsSaveButton),
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
                        l.settingsWebWarning,
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
