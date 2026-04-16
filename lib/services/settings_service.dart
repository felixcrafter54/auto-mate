import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/database_provider.dart';
import 'database/database.dart';

const kSettingClaudeApiKey = 'claude_api_key';
const kSettingYoutubeApiKey = 'youtube_api_key';
const kSettingReportLanguage = 'report_language';

class SettingsService {
  final AppDatabase _db;
  SettingsService(this._db);

  Future<String?> get(String key) => _db.getSetting(key);
  Future<void> set(String key, String value) => _db.setSetting(key, value);
  Future<void> clear(String key) => _db.deleteSetting(key);

  Future<String?> getClaudeKey() => get(kSettingClaudeApiKey);
  Future<String?> getYoutubeKey() => get(kSettingYoutubeApiKey);
  Future<String> getReportLanguage() async =>
      (await get(kSettingReportLanguage)) ?? 'de';
}

final settingsServiceProvider = Provider<SettingsService>((ref) {
  final db = ref.watch(databaseProvider);
  return SettingsService(db);
});

final claudeKeyProvider = FutureProvider<String?>((ref) async {
  return ref.watch(settingsServiceProvider).getClaudeKey();
});

final youtubeKeyProvider = FutureProvider<String?>((ref) async {
  return ref.watch(settingsServiceProvider).getYoutubeKey();
});

final reportLanguageProvider = FutureProvider<String>((ref) async {
  return ref.watch(settingsServiceProvider).getReportLanguage();
});
