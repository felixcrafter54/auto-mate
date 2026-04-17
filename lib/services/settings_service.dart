import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/database_provider.dart';
import 'database/database.dart';

const kSettingGeminiApiKey = 'gemini_api_key';
const kSettingYoutubeApiKey = 'youtube_api_key';
const kSettingReportLanguage = 'report_language';
const kSettingDefaultNotifyOffsets = 'default_notify_offsets';

/// Default notification lead times in days (8w / 4w / 1w).
const List<int> kDefaultNotifyOffsetsDays = [56, 28, 7];

class SettingsService {
  final AppDatabase _db;
  SettingsService(this._db);

  Future<String?> get(String key) => _db.getSetting(key);
  Future<void> set(String key, String value) => _db.setSetting(key, value);
  Future<void> clear(String key) => _db.deleteSetting(key);

  Future<String?> getGeminiKey() => get(kSettingGeminiApiKey);
  Future<String?> getYoutubeKey() => get(kSettingYoutubeApiKey);
  Future<String> getReportLanguage() async =>
      (await get(kSettingReportLanguage)) ?? 'de';

  Future<List<int>> getDefaultNotifyOffsets() async {
    final raw = await get(kSettingDefaultNotifyOffsets);
    return _parseOffsets(raw) ?? kDefaultNotifyOffsetsDays;
  }

  Future<void> setDefaultNotifyOffsets(List<int> offsets) {
    return set(kSettingDefaultNotifyOffsets, encodeOffsets(offsets));
  }

  static String encodeOffsets(List<int> offsets) =>
      (offsets.toSet().toList()..sort((a, b) => b.compareTo(a))).join(',');

  static List<int>? _parseOffsets(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final parts = raw
        .split(',')
        .map((s) => int.tryParse(s.trim()))
        .whereType<int>()
        .where((n) => n > 0)
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));
    return parts.isEmpty ? null : parts;
  }

  static List<int>? parseOffsets(String? raw) => _parseOffsets(raw);
}

final settingsServiceProvider = Provider<SettingsService>((ref) {
  final db = ref.watch(databaseProvider);
  return SettingsService(db);
});

final geminiKeyProvider = FutureProvider<String?>((ref) async {
  return ref.watch(settingsServiceProvider).getGeminiKey();
});

final youtubeKeyProvider = FutureProvider<String?>((ref) async {
  return ref.watch(settingsServiceProvider).getYoutubeKey();
});

final reportLanguageProvider = FutureProvider<String>((ref) async {
  return ref.watch(settingsServiceProvider).getReportLanguage();
});

final defaultNotifyOffsetsProvider = FutureProvider<List<int>>((ref) async {
  return ref.watch(settingsServiceProvider).getDefaultNotifyOffsets();
});
