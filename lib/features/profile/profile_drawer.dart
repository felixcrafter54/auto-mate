import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/profile_provider.dart';
import '../../core/providers/session_provider.dart';
import '../../services/models/enums.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final skillLevel = ref.watch(skillLevelProvider);
    final user = userAsync.valueOrNull;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      user != null ? _initials(user.name) : '?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user?.name ?? '–',
                    style:
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  if (user != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Dabei seit ${_formatDate(user.createdAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ],
                  if (skillLevel != null) ...[
                    const SizedBox(height: 12),
                    _SkillBadge(level: skillLevel),
                  ],
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Profildaten ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'PROFIL',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      letterSpacing: 1.2,
                    ),
              ),
            ),
            if (user != null) ...[
              _InfoTile(
                icon: Icons.person_outline,
                label: 'Name',
                value: user.name,
              ),
              _InfoTile(
                icon: Icons.calendar_today_outlined,
                label: 'Mitglied seit',
                value: _formatDate(user.createdAt),
              ),
            ],
            if (skillLevel != null)
              _InfoTile(
                icon: Icons.tune,
                label: 'Skill Level',
                value: _skillLabel(skillLevel),
              ),

            const SizedBox(height: 8),
            const Divider(height: 1),

            // ── Aktionen ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'EINSTELLUNGEN',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      letterSpacing: 1.2,
                    ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.tune),
              title: const Text('Skill Level ändern'),
              trailing: const Icon(Icons.chevron_right, size: 18),
              onTap: () => _confirmChange(context, ref, skillLevel),
            ),
            ListTile(
              leading: const Icon(Icons.key_outlined),
              title: const Text('API-Keys & Sprache'),
              subtitle: const Text('Claude, YouTube, Berichtsprache'),
              trailing: const Icon(Icons.chevron_right, size: 18),
              onTap: () {
                Navigator.pop(context);
                context.push('/settings');
              },
            ),

            const Spacer(),
            const Divider(height: 1),

            // ── Abmelden ──────────────────────────────────────────────────────
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Abmelden',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () => _logout(context, ref),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  String _initials(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';

  String _skillLabel(SkillLevel level) => switch (level) {
        SkillLevel.beginner => 'Einsteiger',
        SkillLevel.intermediate => 'Fortgeschritten',
        SkillLevel.pro => 'Profi',
      };

  // ── Skill Level ändern (mit Bestätigungsdialog) ───────────────────────────

  void _confirmChange(
      BuildContext context, WidgetRef ref, SkillLevel? current) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Skill Level ändern'),
        content: const Text(
          'Möchtest du dein Skill Level wirklich anpassen?\n'
          'AutoMate passt alle Empfehlungen und Erklärungen entsprechend an.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showLevelPicker(context, ref, current);
            },
            child: const Text('Ja, anpassen'),
          ),
        ],
      ),
    );
  }

  void _showLevelPicker(
      BuildContext context, WidgetRef ref, SkillLevel? current) {
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
              'Wähle dein Skill Level',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            ...SkillLevel.values.map((level) {
              final cs = Theme.of(ctx).colorScheme;
              final (icon, label, desc, color) = switch (level) {
                SkillLevel.beginner => (
                    Icons.school_outlined,
                    'Einsteiger',
                    'Werkstatt-Empfehlungen, einfache Erklärungen',
                    cs.tertiary,
                  ),
                SkillLevel.intermediate => (
                    Icons.build_outlined,
                    'Fortgeschritten',
                    'Tutorials, DIY mit Anleitung',
                    cs.primary,
                  ),
                SkillLevel.pro => (
                    Icons.engineering_outlined,
                    'Profi',
                    'Technische Details, volle Kontrolle',
                    cs.error,
                  ),
              };
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.12),
                  child: Icon(icon, color: color, size: 20),
                ),
                title: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: level == current ? color : null,
                  ),
                ),
                subtitle: Text(desc),
                trailing: level == current
                    ? Icon(Icons.check_circle, color: color)
                    : const Icon(Icons.radio_button_unchecked),
                onTap: () async {
                  Navigator.pop(ctx);
                  await ref
                      .read(profileNotifierProvider.notifier)
                      .setSkillLevel(level);
                  if (context.mounted) Navigator.pop(context); // drawer
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    Navigator.pop(context); // close drawer
    await ref.read(sessionNotifierProvider.notifier).logout();
  }
}

// ============================================================================
// WIDGETS
// ============================================================================

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.outline),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillBadge extends StatelessWidget {
  final SkillLevel level;
  const _SkillBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (icon, label, color) = switch (level) {
      SkillLevel.beginner => (Icons.school_outlined, 'Einsteiger', cs.tertiary),
      SkillLevel.intermediate =>
        (Icons.build_outlined, 'Fortgeschritten', cs.primary),
      SkillLevel.pro => (Icons.engineering_outlined, 'Profi', cs.error),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
