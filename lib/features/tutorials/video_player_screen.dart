import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final String title;
  const VideoPlayerScreen({
    super.key,
    required this.videoId,
    required this.title,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final YoutubePlayerController _controller;
  bool _notEmbeddable = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        strictRelatedVideos: true,
        mute: false,
      ),
    );
    _controller.listen((value) {
      if (!mounted) return;
      if (value.error == YoutubeError.notEmbeddable && !_notEmbeddable) {
        setState(() => _notEmbeddable = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Future<void> _openInYoutube() async {
    final uri = Uri.parse(
      'https://www.youtube.com/watch?v=${widget.videoId}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title, overflow: TextOverflow.ellipsis),
            actions: [
              IconButton(
                icon: const Icon(Icons.open_in_new),
                tooltip: l.videoPlayerOpenInYoutube,
                onPressed: _openInYoutube,
              ),
            ],
          ),
          body: _notEmbeddable
              ? _NotEmbeddableFallback(
                  title: widget.title,
                  onOpen: _openInYoutube,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    player,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(l.videoPlayerTip),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _NotEmbeddableFallback extends StatelessWidget {
  final String title;
  final VoidCallback onOpen;
  const _NotEmbeddableFallback({
    required this.title,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videocam_off_outlined, size: 64, color: cs.outline),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(
              l.videoPlayerNotEmbeddable,
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.outline),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              icon: const Icon(Icons.open_in_new),
              label: Text(l.videoPlayerOpenInYoutube),
              onPressed: onOpen,
            ),
          ],
        ),
      ),
    );
  }
}
