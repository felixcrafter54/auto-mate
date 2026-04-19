import 'dart:convert';
import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class GarageFinderScreen extends StatefulWidget {
  const GarageFinderScreen({super.key});

  @override
  State<GarageFinderScreen> createState() => _GarageFinderScreenState();
}

class _Garage {
  final String? name;
  final LatLng position;
  final String? address;
  final String? phone;
  final String? website;
  const _Garage({
    this.name,
    required this.position,
    this.address,
    this.phone,
    this.website,
  });
}

class _GarageFinderScreenState extends State<GarageFinderScreen> {
  final _mapController = MapController();
  static const LatLng _fallbackCenter = LatLng(51.1657, 10.4515); // mid-Germany
  LatLng _center = _fallbackCenter;
  final List<_Garage> _garages = [];
  bool _loading = true;
  bool _usedFallback = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<LatLng> _resolveCenter() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return _fallbackCenter;
      }
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        return _fallbackCenter;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );
      return LatLng(pos.latitude, pos.longitude);
    } catch (_) {
      return _fallbackCenter;
    }
  }

  Future<void> _load() async {
    try {
      final center = await _resolveCenter();
      _center = center;
      _usedFallback = center == _fallbackCenter;

      // Use Overpass API to find nearby auto repair shops (OSM, free, no key).
      final around = '(around:8000,${_center.latitude},${_center.longitude})';
      final query = '''
[out:json][timeout:15];
(
  node["shop"="car_repair"]$around;
  way["shop"="car_repair"]$around;
  node["amenity"="car_rental"]["car"!~"^no\$"]$around;
);
out center 40;
''';

      final resp = await http.post(
        Uri.parse('https://overpass-api.de/api/interpreter'),
        body: {'data': query},
      );

      if (resp.statusCode != 200) {
        throw 'Overpass ${resp.statusCode}';
      }
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final elements = data['elements'] as List<dynamic>;
      final result = <_Garage>[];
      for (final raw in elements) {
        final el = raw as Map<String, dynamic>;
        final tags = (el['tags'] as Map?)?.cast<String, dynamic>() ?? {};
        final name = tags['name'] as String?;
        final lat = (el['lat'] ?? (el['center']?['lat'])) as num?;
        final lon = (el['lon'] ?? (el['center']?['lon'])) as num?;
        if (lat == null || lon == null) continue;
        result.add(_Garage(
          name: name,
          position: LatLng(lat.toDouble(), lon.toDouble()),
          address: tags['addr:street'] != null
              ? '${tags['addr:street']} ${tags['addr:housenumber'] ?? ''}'.trim()
              : null,
          phone: tags['phone'] as String?,
          website: tags['website'] as String?,
        ));
      }

      if (!mounted) return;
      setState(() {
        _garages
          ..clear()
          ..addAll(result);
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.garageFinderTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorState(error: _error!)
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: _center,
                          initialZoom: 11,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.automate.app',
                          ),
                          MarkerLayer(
                            markers: _garages
                                .map((g) => Marker(
                                      point: g.position,
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.location_on,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error,
                                        size: 32,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.garageFinderFound(_garages.length),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          if (_usedFallback) ...[
                            const SizedBox(height: 2),
                            Text(
                              l.garageFinderNoLocation,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outline,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: _garages.length,
                        itemBuilder: (context, i) =>
                            _GarageTile(garage: _garages[i], onFocus: _focus),
                      ),
                    ),
                  ],
                ),
    );
  }

  void _focus(_Garage g) {
    _mapController.move(g.position, 15);
  }
}

class _GarageTile extends StatelessWidget {
  final _Garage garage;
  final void Function(_Garage) onFocus;
  const _GarageTile({required this.garage, required this.onFocus});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final subtitle = [garage.address, garage.phone].whereType<String>().join(' · ');
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.build_outlined)),
      title: Text(garage.name ?? l.garageFinderDefault),
      subtitle: subtitle.isEmpty ? null : Text(subtitle),
      trailing: Wrap(
        spacing: 4,
        children: [
          if (garage.phone != null)
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () => _launch('tel:${garage.phone}'),
            ),
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => onFocus(garage),
          ),
        ],
      ),
      onTap: () => onFocus(garage),
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  const _ErrorState({required this.error});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline,
              size: 56, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 12),
          Text(error, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
