import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../core/providers/database_provider.dart';
import '../../core/providers/profile_provider.dart';
import '../../services/gemini_service.dart';
import '../../services/database/database.dart';
import '../../services/models/enums.dart';

final _vehicleProvider = FutureProvider.family<Vehicle?, int>(
  (ref, id) => ref.read(vehiclesRepositoryProvider).getVehicleById(id),
);

class BreakdownScreen extends ConsumerStatefulWidget {
  final int vehicleId;
  const BreakdownScreen({super.key, required this.vehicleId});

  @override
  ConsumerState<BreakdownScreen> createState() => _BreakdownScreenState();
}

class _BreakdownScreenState extends ConsumerState<BreakdownScreen> {
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final List<GeminiMessage> _messages = [];
  bool _sending = false;

  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _speechAvailable = false;
  bool _listening = false;
  bool _ttsEnabled = true;

  @override
  void initState() {
    super.initState();
    _initVoice();
  }

  Future<void> _initVoice() async {
    if (kIsWeb) return;
    final ok = await _speech.initialize(onError: (_) {}, onStatus: (_) {});
    await _tts.setLanguage('de-DE');
    await _tts.setSpeechRate(0.5);
    if (mounted) setState(() => _speechAvailable = ok);
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    _speech.stop();
    _tts.stop();
    super.dispose();
  }

  Future<void> _toggleListen() async {
    if (!_speechAvailable) return;
    if (_listening) {
      await _speech.stop();
      setState(() => _listening = false);
      return;
    }
    setState(() => _listening = true);
    await _speech.listen(
      localeId: 'de_DE',
      onResult: (result) {
        _inputCtrl.text = result.recognizedWords;
        if (result.finalResult) {
          setState(() => _listening = false);
        }
      },
    );
  }

  Future<void> _send(Vehicle vehicle, SkillLevel skill) async {
    final l = AppLocalizations.of(context);
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;
    _inputCtrl.clear();

    setState(() {
      _messages.add(GeminiMessage(role: 'user', content: text));
      _sending = true;
    });
    _scrollToBottom();

    try {
      final service = ref.read(geminiServiceProvider);
      final systemPrompt = service.buildBreakdownSystemPrompt(
        make: vehicle.make,
        model: vehicle.model,
        year: vehicle.year,
        fuelType: FuelType.fromString(vehicle.fuelType),
        skill: skill,
      );

      final reply = await service.complete(
        systemPrompt: systemPrompt,
        messages: _messages,
        maxTokens: 1024,
      );
      if (!mounted) return;
      setState(() {
        _messages.add(GeminiMessage(role: 'assistant', content: reply));
        _sending = false;
      });
      _scrollToBottom();

      if (_ttsEnabled && !kIsWeb) {
        await _tts.speak(reply);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _messages.add(GeminiMessage(
          role: 'assistant',
          content: l.commonError(e.toString()),
        ));
        _sending = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final vehicleAsync = ref.watch(_vehicleProvider(widget.vehicleId));
    final skill = ref.watch(skillLevelProvider) ?? SkillLevel.beginner;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.breakdownTitle),
        actions: [
          if (!kIsWeb)
            IconButton(
              icon: Icon(_ttsEnabled ? Icons.volume_up : Icons.volume_off),
              tooltip: l.breakdownTts,
              onPressed: () async {
                setState(() => _ttsEnabled = !_ttsEnabled);
                if (!_ttsEnabled) await _tts.stop();
              },
            ),
          IconButton(
            icon: const Icon(Icons.local_hospital_outlined),
            tooltip: l.breakdownFindGarage,
            onPressed: () =>
                context.push('/vehicle/${widget.vehicleId}/garages'),
          ),
        ],
      ),
      body: vehicleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonError(e.toString()))),
        data: (vehicle) {
          if (vehicle == null) return Center(child: Text(l.breakdownNoVehicle));
          return Column(
            children: [
              Expanded(
                child: _messages.isEmpty
                    ? _EmptyIntro(vehicle: vehicle, skill: skill)
                    : ListView.builder(
                        controller: _scrollCtrl,
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length + (_sending ? 1 : 0),
                        itemBuilder: (context, i) {
                          if (i == _messages.length) {
                            return const _TypingBubble();
                          }
                          return _Bubble(message: _messages[i]);
                        },
                      ),
              ),
              _InputBar(
                controller: _inputCtrl,
                listening: _listening,
                canListen: _speechAvailable && !kIsWeb,
                sending: _sending,
                onSend: () => _send(vehicle, skill),
                onMic: _toggleListen,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyIntro extends StatelessWidget {
  final Vehicle vehicle;
  final SkillLevel skill;
  const _EmptyIntro({required this.vehicle, required this.skill});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final examples = switch (skill) {
      SkillLevel.beginner => [
          l.breakdownExample1Beginner,
          l.breakdownExample2Beginner,
          l.breakdownExample3Beginner,
        ],
      SkillLevel.intermediate => [
          l.breakdownExample1Intermediate,
          l.breakdownExample2Intermediate,
          l.breakdownExample3Intermediate,
        ],
      SkillLevel.pro => [
          l.breakdownExample1Pro,
          l.breakdownExample2Pro,
          l.breakdownExample3Pro,
        ],
    };

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mic_none, size: 56, color: cs.primary),
          const SizedBox(height: 12),
          Text(
            l.breakdownPlaceholder(vehicle.make),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l.breakdownExamplesTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ...examples.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('• $e',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cs.outline)),
              )),
          const SizedBox(height: 24),
          if (kIsWeb)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.tertiaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                l.breakdownWebWarning,
                style: TextStyle(color: cs.onTertiaryContainer),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final GeminiMessage message;
  const _Bubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';
    final cs = Theme.of(context).colorScheme;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? cs.primary : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: SelectableText(
          message.content,
          style: TextStyle(
            color: isUser ? cs.onPrimary : cs.onSurface,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const SizedBox(
          width: 40,
          height: 12,
          child: Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool listening;
  final bool canListen;
  final bool sending;
  final VoidCallback onSend;
  final VoidCallback onMic;

  const _InputBar({
    required this.controller,
    required this.listening,
    required this.canListen,
    required this.sending,
    required this.onSend,
    required this.onMic,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Row(
          children: [
            if (canListen)
              IconButton.filled(
                icon: Icon(listening ? Icons.stop : Icons.mic),
                color: listening ? Colors.red : null,
                onPressed: onMic,
              ),
            if (canListen) const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: l.breakdownInputPlaceholder,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              icon: sending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send),
              onPressed: sending ? null : onSend,
            ),
          ],
        ),
      ),
    );
  }
}
