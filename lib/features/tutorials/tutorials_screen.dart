import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/providers/database_provider.dart';
import '../../core/providers/profile_provider.dart';
import '../../services/database/database.dart';
import '../../services/models/enums.dart';
import '../../services/youtube_service.dart';

final _vehicleProvider = FutureProvider.family<Vehicle?, int>(
  (ref, id) => ref.read(vehiclesRepositoryProvider).getVehicleById(id),
);

class TutorialsScreen extends ConsumerStatefulWidget {
  final int vehicleId;
  const TutorialsScreen({super.key, required this.vehicleId});

  @override
  ConsumerState<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends ConsumerState<TutorialsScreen> {
  final _queryCtrl = TextEditingController();
  Future<List<YoutubeVideo>>? _future;
  String? _errorMessage;

  @override
  void dispose() {
    _queryCtrl.dispose();
    super.dispose();
  }

  Future<void> _search(Vehicle vehicle) async {
    final query = _queryCtrl.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _errorMessage = null;
      _future = ref.read(youtubeServiceProvider).searchTutorials(
            make: vehicle.make,
            model: vehicle.model,
            year: vehicle.year,
            query: query,
          );
    });
    try {
      await _future;
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicleAsync = ref.watch(_vehicleProvider(widget.vehicleId));
    final skill = ref.watch(skillLevelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reparatur-Tutorials')),
      body: vehicleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
        data: (vehicle) {
          if (vehicle == null) return const Center(child: Text('Kein Fahrzeug'));
          return Column(
            children: [
              _SearchBar(
                vehicle: vehicle,
                controller: _queryCtrl,
                onSubmit: () => _search(vehicle),
              ),
              if (skill != null) _SkillBanner(skill: skill),
              Expanded(child: _Results(future: _future, error: _errorMessage)),
            ],
          );
        },
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final Vehicle vehicle;
  final TextEditingController controller;
  final VoidCallback onSubmit;
  const _SearchBar({
    required this.vehicle,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Für: ${vehicle.year} ${vehicle.make} ${vehicle.model}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.outline),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'z. B. Bremsen wechseln, Ölwechsel, Zündkerzen',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: onSubmit,
              ),
            ),
            onSubmitted: (_) => onSubmit(),
          ),
        ],
      ),
    );
  }
}

class _SkillBanner extends StatelessWidget {
  final SkillLevel skill;
  const _SkillBanner({required this.skill});

  String get _hint => switch (skill) {
        SkillLevel.beginner =>
          'Einsteiger-Tipp: Arbeite bei komplexen Reparaturen lieber mit einer Werkstatt.',
        SkillLevel.intermediate =>
          'Lesbare Schritt-für-Schritt-Videos für dein Level werden bevorzugt.',
        SkillLevel.pro =>
          'Für dich: Suche ruhig spezifische Begriffe (z. B. "ZKD wechseln").',
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: cs.secondaryContainer,
      child: Text(
        _hint,
        style: TextStyle(color: cs.onSecondaryContainer, fontSize: 12),
      ),
    );
  }
}

class _Results extends StatelessWidget {
  final Future<List<YoutubeVideo>>? future;
  final String? error;
  const _Results({required this.future, required this.error});

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 56, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(error!, textAlign: TextAlign.center),
          ],
        ),
      );
    }

    if (future == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Gib oben ein, was du reparieren willst, und wir suchen passende Videos.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return FutureBuilder<List<YoutubeVideo>>(
      future: future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Fehler: ${snap.error}'));
        }
        final items = snap.data ?? [];
        if (items.isEmpty) return const Center(child: Text('Nichts gefunden'));
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, i) => _VideoCard(video: items[i]),
        );
      },
    );
  }
}

class _VideoCard extends StatelessWidget {
  final YoutubeVideo video;
  const _VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/video/${video.id}',
            extra: video.title),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(video.thumbnailUrl, fit: BoxFit.cover),
                  const Center(
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.play_arrow,
                          color: Colors.white, size: 32),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    '${video.channel} · ${DateFormat('dd.MM.yyyy', 'de').format(video.publishedAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
