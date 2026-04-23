import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
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
    final l = AppLocalizations.of(context);
    final vehicleAsync = ref.watch(_vehicleProvider(widget.vehicleId));
    final skill = ref.watch(skillLevelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.tutorialsTitle)),
      body: vehicleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonError(e.toString()))),
        data: (vehicle) {
          if (vehicle == null) return Center(child: Text(l.tutorialsNoVehicle));
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
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.tutorialsVehicleLabel(vehicle.year, vehicle.make, vehicle.model),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.outline),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: l.tutorialsSearchPlaceholder,
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

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final hint = switch (skill) {
      SkillLevel.beginner => l.tutorialsBeginnerTip,
      SkillLevel.intermediate => l.tutorialsIntermediateTip,
      SkillLevel.pro => l.tutorialsProTip,
    };
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: cs.secondaryContainer,
      child: Text(
        hint,
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
    final l = AppLocalizations.of(context);

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
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(l.tutorialsEmptyHint, textAlign: TextAlign.center),
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
          return Center(
            child: Text(l.commonError(snap.error.toString())),
          );
        }
        final items = snap.data ?? [];
        if (items.isEmpty) {
          return Center(child: Text(l.tutorialsNothingFound));
        }
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

  Future<void> _openYoutube() async {
    final uri = Uri.parse('https://www.youtube.com/watch?v=${video.id}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _openYoutube,
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
                      child: Icon(Icons.play_arrow, color: Colors.white, size: 32),
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
                    '${video.channel} · ${DateFormat('dd.MM.yyyy').format(video.publishedAt)}',
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
