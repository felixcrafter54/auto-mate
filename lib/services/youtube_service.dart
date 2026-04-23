import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'settings_service.dart';

const _endpoint = 'https://www.googleapis.com/youtube/v3/search';

class YoutubeVideo {
  final String id;
  final String title;
  final String channel;
  final String thumbnailUrl;
  final String description;
  final DateTime publishedAt;

  const YoutubeVideo({
    required this.id,
    required this.title,
    required this.channel,
    required this.thumbnailUrl,
    required this.description,
    required this.publishedAt,
  });
}

class YoutubeService {
  final SettingsService settings;
  final http.Client _http;

  YoutubeService(this.settings, {http.Client? client})
      : _http = client ?? http.Client();

  Future<List<YoutubeVideo>> searchTutorials({
    required String make,
    required String model,
    required int year,
    required String query,
    int maxResults = 12,
  }) async {
    final apiKey = await settings.getYoutubeKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw const YoutubeMissingKeyException();
    }

    final q = '$make $model $year $query'.trim();
    final uri = Uri.parse(_endpoint).replace(queryParameters: {
      'part': 'snippet',
      'type': 'video',
      'q': q,
      'maxResults': '$maxResults',
      'relevanceLanguage': 'de',
      'videoEmbeddable': 'true',
      'key': apiKey,
    });

    final resp = await _http.get(uri);
    if (resp.statusCode != 200) {
      throw YoutubeApiException(resp.statusCode, resp.body);
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final items = data['items'] as List<dynamic>? ?? [];
    return items.map((raw) {
      final item = raw as Map<String, dynamic>;
      final idObj = item['id'] as Map<String, dynamic>;
      final snippet = item['snippet'] as Map<String, dynamic>;
      final thumbs = snippet['thumbnails'] as Map<String, dynamic>;
      final thumb = (thumbs['high'] ?? thumbs['medium'] ?? thumbs['default'])
          as Map<String, dynamic>;
      return YoutubeVideo(
        id: idObj['videoId'] as String,
        title: snippet['title'] as String,
        channel: snippet['channelTitle'] as String,
        thumbnailUrl: thumb['url'] as String,
        description: snippet['description'] as String? ?? '',
        publishedAt: DateTime.parse(snippet['publishedAt'] as String),
      );
    }).toList();
  }
}

class YoutubeMissingKeyException implements Exception {
  const YoutubeMissingKeyException();
  @override
  String toString() =>
      'Kein YouTube-API-Key hinterlegt. Bitte in den Einstellungen eintragen.';
}

class YoutubeApiException implements Exception {
  final int statusCode;
  final String body;
  const YoutubeApiException(this.statusCode, this.body);
  @override
  String toString() => 'YouTube API Fehler ($statusCode): $body';
}

final youtubeServiceProvider = Provider<YoutubeService>((ref) {
  final settings = ref.watch(settingsServiceProvider);
  return YoutubeService(settings);
});
