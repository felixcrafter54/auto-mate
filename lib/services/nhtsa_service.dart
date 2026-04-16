import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const _baseUrl = 'https://vpic.nhtsa.dot.gov/api/vehicles';

final nhtsaServiceProvider = Provider<NhtsaService>((ref) => NhtsaService());

class NhtsaService {
  final http.Client _client;
  NhtsaService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetch all available makes (brands).
  Future<List<String>> fetchMakes() async {
    final uri = Uri.parse('$_baseUrl/GetAllMakes?format=json');
    final response = await _client.get(uri);
    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['Results'] as List<dynamic>;
    return results
        .map((e) => e['Make_Name'] as String)
        .toSet()
        .toList()
      ..sort();
  }

  /// Fetch models for a given make and year.
  Future<List<String>> fetchModels(String make, int year) async {
    final uri = Uri.parse(
      '$_baseUrl/GetModelsForMakeYear/make/$make/modelyear/$year?format=json',
    );
    final response = await _client.get(uri);
    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['Results'] as List<dynamic>;
    return results
        .map((e) => e['Model_Name'] as String)
        .toSet()
        .toList()
      ..sort();
  }

  /// Decode a VIN — returns a map of field name → value.
  Future<Map<String, String>> decodeVin(String vin) async {
    final uri = Uri.parse('$_baseUrl/DecodeVin/$vin?format=json');
    final response = await _client.get(uri);
    if (response.statusCode != 200) return {};

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['Results'] as List<dynamic>;
    final Map<String, String> decoded = {};
    for (final item in results) {
      final variable = item['Variable'] as String? ?? '';
      final value = item['Value'] as String? ?? '';
      if (value.isNotEmpty && value != 'Not Applicable') {
        decoded[variable] = value;
      }
    }
    return decoded;
  }
}

// ============================================================================
// RIVERPOD PROVIDERS FOR ASYNC DATA
// ============================================================================

final makesProvider = FutureProvider<List<String>>((ref) {
  return ref.read(nhtsaServiceProvider).fetchMakes();
});

final modelsProvider =
    FutureProvider.family<List<String>, ({String make, int year})>((
  ref,
  params,
) {
  return ref.read(nhtsaServiceProvider).fetchModels(params.make, params.year);
});

final vinDecodeProvider =
    FutureProvider.family<Map<String, String>, String>((ref, vin) {
  return ref.read(nhtsaServiceProvider).decodeVin(vin);
});
