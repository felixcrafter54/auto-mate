import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/session_provider.dart';
import '../../services/models/enums.dart';

// ============================================================================
// QUIZ DATA
// ============================================================================

class _Question {
  final String text;
  final List<String> options; // index 0 = beginner (0 pts), 1 = intermediate (1 pt), 2 = pro (2 pts)
  const _Question({required this.text, required this.options});
}

List<_Question> _buildQuestions(AppLocalizations l) => [
  _Question(
    text: l.skillQuiz1Question,
    options: [l.skillQuiz1Answer1, l.skillQuiz1Answer2, l.skillQuiz1Answer3],
  ),
  _Question(
    text: l.skillQuiz2Question,
    options: [l.skillQuiz2Answer1, l.skillQuiz2Answer2, l.skillQuiz2Answer3],
  ),
  _Question(
    text: l.skillQuiz3Question,
    options: [l.skillQuiz3Answer1, l.skillQuiz3Answer2, l.skillQuiz3Answer3],
  ),
  _Question(
    text: l.skillQuiz4Question,
    options: [l.skillQuiz4Answer1, l.skillQuiz4Answer2, l.skillQuiz4Answer3],
  ),
  _Question(
    text: l.skillQuiz5Question,
    options: [l.skillQuiz5Answer1, l.skillQuiz5Answer2, l.skillQuiz5Answer3],
  ),
];

SkillLevel _calcLevel(List<int> answers) {
  final total = answers.fold(0, (sum, a) => sum + a);
  if (total <= 3) return SkillLevel.beginner;
  if (total <= 6) return SkillLevel.intermediate;
  return SkillLevel.pro;
}

// ============================================================================
// SCREEN
// ============================================================================

class SkillQuizScreen extends ConsumerStatefulWidget {
  const SkillQuizScreen({super.key});

  @override
  ConsumerState<SkillQuizScreen> createState() => _SkillQuizScreenState();
}

class _SkillQuizScreenState extends ConsumerState<SkillQuizScreen> {
  int _current = 0;
  final List<int?> _answers = List.filled(5, null);

  void _select(int optionIndex) => setState(() => _answers[_current] = optionIndex);

  void _next(List<_Question> questions) {
    if (_answers[_current] == null) return;
    if (_current < questions.length - 1) {
      setState(() => _current++);
    } else {
      final level = _calcLevel(_answers.map((a) => a ?? 0).toList());
      context.go('/skill-result', extra: level);
    }
  }

  void _back() {
    if (_current > 0) setState(() => _current--);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final questions = _buildQuestions(l);
    final userAsync = ref.watch(currentUserProvider);
    final firstName = userAsync.valueOrNull?.name.split(' ').first ?? '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting (only on first question)
              if (_current == 0) ...[
                const SizedBox(height: 16),
                Text(
                  firstName.isNotEmpty ? l.skillQuizHello(firstName) : l.skillQuizHelloGeneric,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  l.skillQuizIntro,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                const SizedBox(height: 28),
              ] else
                const SizedBox(height: 16),

              // Progress bar
              Row(
                children: List.generate(questions.length, (i) {
                  final isDone = i < _current;
                  final isActive = i == _current;
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: (isDone || isActive)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surfaceContainerHighest,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),
              Text(
                l.skillQuizProgress(_current + 1, questions.length),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const SizedBox(height: 28),

              // Question text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Align(
                  key: ValueKey(_current),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    questions[_current].text,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Answer options
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: ListView(
                    key: ValueKey('opts_$_current'),
                    children: List.generate(
                      questions[_current].options.length,
                      (i) => _OptionTile(
                        text: questions[_current].options[i],
                        selected: _answers[_current] == i,
                        onTap: () => _select(i),
                      ),
                    ),
                  ),
                ),
              ),

              // Navigation buttons
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    if (_current > 0)
                      TextButton.icon(
                        icon: const Icon(Icons.arrow_back, size: 18),
                        label: Text(l.commonBack),
                        onPressed: _back,
                      ),
                    const Spacer(),
                    FilledButton.icon(
                      icon: Icon(
                        _current == questions.length - 1
                            ? Icons.check
                            : Icons.arrow_forward,
                        size: 18,
                      ),
                      label: Text(
                        _current == questions.length - 1
                            ? l.skillQuizEvaluate
                            : l.skillQuizNext,
                      ),
                      onPressed: _answers[_current] != null ? () => _next(questions) : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// OPTION TILE
// ============================================================================

class _OptionTile extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected ? 2 : 1,
          ),
          color: selected ? cs.primary.withValues(alpha: 0.08) : cs.surface,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? cs.primary : cs.outline,
                  width: 2,
                ),
                color: selected ? cs.primary : Colors.transparent,
              ),
              child: selected
                  ? Icon(Icons.check, size: 13, color: cs.onPrimary)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: selected ? cs.primary : cs.onSurface,
                  fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
