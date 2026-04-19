import 'package:auto_mate/l10n/app_localizations.dart';
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
    final l = AppLocalizations.of(context);
    final userAsync = ref.watch(currentUserProvider);
    final skillLevel = ref.watch(skillLevelProvider);
    final user = userAsync.valueOrNull;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user?.name ?? '–',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (user != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      l.profileMemberSinceDate(_formatDate(user.createdAt)),
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

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                l.profileTitle,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      letterSpacing: 1.2,
                    ),
              ),
            ),
            if (user != null) ...[
              _InfoTile(
                icon: Icons.person_outline,
                label: l.profileName,
                value: user.name,
              ),
              _InfoTile(
                icon: Icons.calendar_today_outlined,
                label: l.profileMemberSince,
                value: _formatDate(user.createdAt),
              ),
            ],
            if (skillLevel != null)
              _InfoTile(
                icon: Icons.tune,
                label: l.profileSkillLevel,
                value: _skillLabel(l, skillLevel),
              ),

            const SizedBox(height: 8),
            const Divider(height: 1),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                l.profileSettingsSection,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      letterSpacing: 1.2,
                    ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.tune),
              title: Text(l.profileChangeSkillLevel),
              trailing: const Icon(Icons.chevron_right, size: 18),
              onTap: () => _confirmChange(context, ref, skillLevel, l),
            ),
            ListTile(
              leading: const Icon(Icons.key_outlined),
              title: Text(l.profileApiAndLanguage),
              subtitle: Text(l.profileApiAndLanguageHint),
              trailing: const Icon(Icons.chevron_right, size: 18),
              onTap: () {
                Navigator.pop(context);
                context.push('/settings');
              },
            ),

            const Spacer(),
            const Divider(height: 1),

            ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
              title: Text(
                l.profileLogout,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () => _logout(context, ref),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';

  String _skillLabel(AppLocalizations l, SkillLevel level) => switch (level) {
        SkillLevel.beginner => l.skillLevelBeginner,
        SkillLevel.intermediate => l.skillLevelIntermediate,
        SkillLevel.pro => l.skillLevelPro,
      };

  void _confirmChange(
      BuildContext context, WidgetRef ref, SkillLevel? current, AppLocalizations l) {
    showDialog(
      context: context,
      builder: (ctx) {
        final lCtx = AppLocalizations.of(ctx);
        return AlertDialog(
          title: Text(lCtx.profileChangeSkillLevelTitle),
          content: Text(lCtx.profileChangeSkillLevelBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(lCtx.commonCancel),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                _showLevelPicker(context, ref, current);
              },
              child: Text(lCtx.profileChangeSkillLevelYes),
            ),
          ],
        );
      },
    );
  }

  void _showLevelPicker(BuildContext context, WidgetRef ref, SkillLevel? current) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final lCtx = AppLocalizations.of(ctx);
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lCtx.profileSelectSkillLevel,
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
                      lCtx.skillLevelBeginner,
                      lCtx.skillLevelBeginnerFeatures,
                      cs.tertiary,
                    ),
                  SkillLevel.intermediate => (
                      Icons.build_outlined,
                      lCtx.skillLevelIntermediate,
                      lCtx.skillLevelIntermediateFeatures,
                      cs.primary,
                    ),
                  SkillLevel.pro => (
                      Icons.engineering_outlined,
                      lCtx.skillLevelPro,
                      lCtx.skillLevelProFeatures,
                      cs.error,
                    ),
                };
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    Navigator.pop(context);
    await ref.read(sessionNotifierProvider.notifier).logout();
  }
}

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
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final (icon, label, color) = switch (level) {
      SkillLevel.beginner => (Icons.school_outlined, l.skillLevelBeginner, cs.tertiary),
      SkillLevel.intermediate => (Icons.build_outlined, l.skillLevelIntermediate, cs.primary),
      SkillLevel.pro => (Icons.engineering_outlined, l.skillLevelPro, cs.error),
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
