import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../services/models/enums.dart';
import 'settings_service.dart';

const _endpoint = 'https://api.anthropic.com/v1/messages';
const _model = 'claude-sonnet-4-6';

class ClaudeMessage {
  final String role;
  final String content;
  const ClaudeMessage({required this.role, required this.content});

  Map<String, dynamic> toJson() => {'role': role, 'content': content};
}

class ClaudeService {
  final SettingsService settings;
  final http.Client _http;

  ClaudeService(this.settings, {http.Client? client})
      : _http = client ?? http.Client();

  Future<String> complete({
    required String systemPrompt,
    required List<ClaudeMessage> messages,
    int maxTokens = 1024,
  }) async {
    final apiKey = await settings.getClaudeKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw const ClaudeMissingKeyException();
    }

    final resp = await _http.post(
      Uri.parse(_endpoint),
      headers: {
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
        'content-type': 'application/json',
        'anthropic-dangerous-direct-browser-access': 'true',
      },
      body: jsonEncode({
        'model': _model,
        'max_tokens': maxTokens,
        'system': systemPrompt,
        'messages': messages.map((m) => m.toJson()).toList(),
      }),
    );

    if (resp.statusCode != 200) {
      throw ClaudeApiException(resp.statusCode, resp.body);
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final contentList = data['content'] as List<dynamic>;
    final text = contentList
        .whereType<Map<String, dynamic>>()
        .where((c) => c['type'] == 'text')
        .map((c) => c['text'] as String)
        .join('\n');
    return text.trim();
  }

  String buildBreakdownSystemPrompt({
    required String make,
    required String model,
    required int year,
    required FuelType fuelType,
    required SkillLevel skill,
  }) {
    final fuelLabel = switch (fuelType) {
      FuelType.petrol => 'Benziner',
      FuelType.diesel => 'Diesel',
      FuelType.electric => 'Elektroauto',
      FuelType.hybrid => 'Hybrid',
      FuelType.other => 'Sonstiges',
    };
    final skillGuide = switch (skill) {
      SkillLevel.beginner =>
        'Der Nutzer ist Einsteiger. Erkläre einfach ohne Fachbegriffe. '
            'Empfiehl bei komplexen Problemen klar eine Werkstatt oder einen Abschleppdienst. '
            'Verwende Beispiele aus dem Alltag. Keine DIY-Anleitungen für komplexe Arbeiten.',
      SkillLevel.intermediate =>
        'Der Nutzer ist fortgeschritten. Erkläre Fehlercodes verständlich, '
            'biete konkrete DIY-Schritte an wenn sinnvoll, mit Werkzeugliste. '
            'Nenne Risiken und wann man besser in die Werkstatt fährt.',
      SkillLevel.pro =>
        'Der Nutzer ist Profi. Liefere technische Details, OBD-II-Codes im Rohformat, '
            'Bauteilbezeichnungen und konkrete Messwerte. Keine Vereinfachungen, kein Hand-Holding.',
    };

    return '''Du bist AutoMate, ein deutscher Auto-Pannen-Assistent.

Fahrzeug: $year $make $model ($fuelLabel).

$skillGuide

Antworte immer auf Deutsch, prägnant, strukturiert.
Bei Gefahrensituationen (Rauch, Feuer, Verletzte) weise sofort auf Notruf 112 hin.''';
  }

  String buildWorkshopReportPrompt({
    required String make,
    required String model,
    required int year,
    required FuelType fuelType,
    required String language,
  }) {
    final languageName = switch (language) {
      'en' => 'English',
      'fr' => 'French',
      'es' => 'Spanish',
      'it' => 'Italian',
      _ => 'German',
    };

    return '''You write concise, professional workshop diagnostic reports.

Vehicle: $year $make $model ($fuelType).
Language: $languageName.

Given a user's symptom description, produce a structured report with:
1. Observed symptoms (bullet list)
2. Likely cause(s) with probability ranking
3. Affected components
4. Recommended inspection steps
5. Rough market repair cost range (EUR)

Use the technical vocabulary of a mechanic but remain understandable.
Avoid guesses presented as facts — flag uncertainty.''';
  }
}

// ── Exceptions ───────────────────────────────────────────────────────────────

class ClaudeMissingKeyException implements Exception {
  const ClaudeMissingKeyException();
  @override
  String toString() =>
      'Kein Claude-API-Key hinterlegt. Bitte in den Einstellungen eintragen.';
}

class ClaudeApiException implements Exception {
  final int statusCode;
  final String body;
  const ClaudeApiException(this.statusCode, this.body);
  @override
  String toString() => 'Claude API Fehler ($statusCode): $body';
}

// ── Provider ─────────────────────────────────────────────────────────────────

final claudeServiceProvider = Provider<ClaudeService>((ref) {
  final settings = ref.watch(settingsServiceProvider);
  return ClaudeService(settings);
});
