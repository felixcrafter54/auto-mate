import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/settings_service.dart';

const kSettingAppLocale = 'app_locale';

class LocaleNotifier extends StateNotifier<Locale?> {
  final SettingsService _svc;

  LocaleNotifier(this._svc) : super(null) {
    _load();
  }

  Future<void> _load() async {
    final code = await _svc.get(kSettingAppLocale);
    if (code != null && code.isNotEmpty) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      await _svc.clear(kSettingAppLocale);
    } else {
      await _svc.set(kSettingAppLocale, locale.languageCode);
    }
    state = locale;
  }
}

final localeNotifierProvider =
    StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier(ref.watch(settingsServiceProvider));
});
