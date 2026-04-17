import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../services/models/enums.dart';
import 'settings_service.dart';

const _model = 'gemini-2.5-flash';
const _endpoint =
    'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent';

class GeminiMessage {
  final String role;
  final String content;
  const GeminiMessage({required this.role, required this.content});

  Map<String, dynamic> toJson() => {
        'role': role == 'assistant' ? 'model' : role,
        'parts': [
          {'text': content},
        ],
      };
}

class GeminiService {
  final SettingsService settings;
  final http.Client _http;

  GeminiService(this.settings, {http.Client? client})
      : _http = client ?? http.Client();

  Future<String> complete({
    required String systemPrompt,
    required List<GeminiMessage> messages,
    int maxTokens = 1024,
  }) async {
    final apiKey = await settings.getGeminiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw const GeminiMissingKeyException();
    }

    final resp = await _http.post(
      Uri.parse(_endpoint),
      headers: {
        'x-goog-api-key': apiKey,
        'content-type': 'application/json',
      },
      body: jsonEncode({
        'systemInstruction': {
          'parts': [
            {'text': systemPrompt},
          ],
        },
        'contents': messages.map((m) => m.toJson()).toList(),
        'generationConfig': {
          'maxOutputTokens': maxTokens,
        },
      }),
    );

    if (resp.statusCode != 200) {
      throw GeminiApiException(resp.statusCode, resp.body);
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final candidates = data['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      throw GeminiApiException(resp.statusCode, resp.body);
    }
    final first = candidates.first as Map<String, dynamic>;
    final content = first['content'] as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;
    if (parts == null) {
      throw GeminiApiException(resp.statusCode, resp.body);
    }
    final text = parts
        .whereType<Map<String, dynamic>>()
        .map((p) => p['text'] as String? ?? '')
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

class GeminiMissingKeyException implements Exception {
  const GeminiMissingKeyException();
  @override
  String toString() =>
      'Kein Gemini-API-Key hinterlegt. Bitte in den Einstellungen eintragen.';
}

class GeminiApiException implements Exception {
  final int statusCode;
  final String body;
  const GeminiApiException(this.statusCode, this.body);
  @override
  String toString() => 'Gemini API Fehler ($statusCode): $body';
}

// ── Provider ─────────────────────────────────────────────────────────────────

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final settings = ref.watch(settingsServiceProvider);
  return GeminiService(settings);
});
