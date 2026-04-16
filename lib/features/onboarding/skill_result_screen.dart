import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/profile_provider.dart';
import '../../core/providers/session_provider.dart';
import '../../services/models/enums.dart';

class SkillResultScreen extends ConsumerWidget {
  final SkillLevel detectedLevel;
  const SkillResultScreen({super.key, required this.detectedLevel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final firstName = userAsync.valueOrNull?.name.split(' ').first ?? '';

    final meta = _levelMeta(context, detectedLevel);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Icon circle
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: meta.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(meta.icon, size: 48, color: meta.color),
              ),
              const SizedBox(height: 28),
              Text(
                'Dein Skill-Level:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                meta.label,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: meta.color,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                meta.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 48),
              Text(
                firstName.isNotEmpty
                    ? 'Passt das für dich, $firstName?'
                    : 'Passt das für dich?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Ja, das passt!'),
                  onPressed: () async {
                    await ref
                        .read(profileNotifierProvider.notifier)
                        .completeOnboarding(detectedLevel);
                    if (context.mounted) context.go('/');
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.tune),
                  label: const Text('Nein, ich möchte es anpassen'),
                  onPressed: () => _showLevelPicker(context, ref),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showLevelPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wähle dein Level',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Du kannst es jederzeit im Profil anpassen.',
              style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(ctx).colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 20),
            ...SkillLevel.values.map((level) {
              final m = _levelMeta(ctx, level);
              return _LevelTile(
                meta: m,
                selected: level == detectedLevel,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ref
                      .read(profileNotifierProvider.notifier)
                      .completeOnboarding(level);
                  if (context.mounted) context.go('/');
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// HELPERS
// ============================================================================

class _LevelMeta {
  final IconData icon;
  final String label;
  final String description;
  final String shortDesc;
  final Color color;
  const _LevelMeta({
    required this.icon,
    required this.label,
    required this.description,
    required this.shortDesc,
    required this.color,
  });
}

_LevelMeta _levelMeta(BuildContext context, SkillLevel level) {
  final cs = Theme.of(context).colorScheme;
  return switch (level) {
    SkillLevel.beginner => _LevelMeta(
        icon: Icons.school_outlined,
        label: 'Einsteiger',
        description:
            'Du verlässt dich auf Fachleute – das ist klug und sicher. '
            'AutoMate gibt dir klare Hinweise, wann du in die Werkstatt solltest, '
            'und erklärt alles verständlich ohne Fachchinesisch.',
        shortDesc: 'Werkstatt-Empfehlungen, einfache Erklärungen',
        color: cs.tertiary,
      ),
    SkillLevel.intermediate => _LevelMeta(
        icon: Icons.build_outlined,
        label: 'Fortgeschritten',
        description:
            'Du kennst dein Auto gut und packst gerne selbst mit an. '
            'AutoMate zeigt dir passende Repair-Tutorials und hilft dir, '
            'die richtigen Teile zu finden – Schritt für Schritt.',
        shortDesc: 'Tutorials, DIY mit Anleitung',
        color: cs.primary,
      ),
    SkillLevel.pro => _LevelMeta(
        icon: Icons.engineering_outlined,
        label: 'Profi',
        description:
            'Du weißt genau, was unter der Motorhaube passiert. '
            'AutoMate liefert dir technische Details, Fehlercodes im Rohformat '
            'und volle Kontrolle – ganz ohne Vereinfachungen.',
        shortDesc: 'Technische Details, OBD-Daten, volle Kontrolle',
        color: cs.error,
      ),
  };
}

class _LevelTile extends StatelessWidget {
  final _LevelMeta meta;
  final bool selected;
  final VoidCallback onTap;

  const _LevelTile({
    required this.meta,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: meta.color.withValues(alpha: 0.12),
        child: Icon(meta.icon, color: meta.color, size: 20),
      ),
      title: Text(
        meta.label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? meta.color : null,
        ),
      ),
      subtitle: Text(meta.shortDesc),
      trailing: selected
          ? Icon(Icons.check_circle, color: meta.color)
          : const Icon(Icons.radio_button_unchecked),
      onTap: onTap,
    );
  }
}
