import 'package:auto_mate/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/profile_provider.dart';
import '../../core/providers/session_provider.dart';
import '../../core/widgets/action_tile.dart';
import '../../core/widgets/info_row.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/status_badge.dart';
import '../../services/models/enums.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final userAsync = ref.watch(currentUserProvider);
    final skillLevel = ref.watch(skillLevelProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final user = userAsync.valueOrNull;

    return Scaffold(
      appBar: AppBar(title: Text(l.navProfile)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        children: [
          // Avatar header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: cs.primaryContainer,
                  child: Text(
                    user != null ? _initials(user.name) : '?',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  user?.name ?? '–',
                  style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (user != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    l.profileMemberSinceDate(_formatDate(user.createdAt)),
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
                if (skillLevel != null) ...[
                  const SizedBox(height: 12),
                  StatusBadge(
                    label: _skillLabel(l, skillLevel),
                    color: _skillColor(cs, skillLevel),
                    icon: _skillIcon(skillLevel),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Info section
          if (user != null) ...[
            SectionHeader(l.profileTitle),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    InfoRow(
                      icon: Icons.person_outline_rounded,
                      label: l.profileName,
                      value: user.name,
                    ),
                    const Divider(height: 1),
                    InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: l.profileMemberSince,
                      value: _formatDate(user.createdAt),
                    ),
                    if (skillLevel != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.tune_rounded,
                        label: l.profileSkillLevel,
                        value: _skillLabel(l, skillLevel),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Settings section
          SectionHeader(l.profileSettingsSection),
          const SizedBox(height: 8),
          ActionTile(
            icon: Icons.tune_rounded,
            title: l.profileChangeSkillLevel,
            onTap: () => _confirmChange(context, ref, skillLevel, l),
            accentColor: cs.primary,
          ),
          ActionTile(
            icon: Icons.key_outlined,
            title: l.profileApiAndLanguage,
            subtitle: l.profileApiAndLanguageHint,
            onTap: () => context.push('/settings'),
            accentColor: cs.primary,
          ),
          const SizedBox(height: 20),

          // Logout
          Card(
            color: cs.errorContainer.withValues(alpha: 0.5),
            child: InkWell(
              onTap: () => _logout(context, ref),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded, color: cs.error),
                    const SizedBox(width: 14),
                    Text(
                      l.profileLogout,
                      style: tt.bodyLarge?.copyWith(
                        color: cs.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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

  Color _skillColor(ColorScheme cs, SkillLevel level) => switch (level) {
        SkillLevel.beginner => cs.tertiary,
        SkillLevel.intermediate => cs.primary,
        SkillLevel.pro => cs.error,
      };

  IconData _skillIcon(SkillLevel level) => switch (level) {
        SkillLevel.beginner => Icons.school_outlined,
        SkillLevel.intermediate => Icons.build_outlined,
        SkillLevel.pro => Icons.engineering_outlined,
      };

  void _confirmChange(BuildContext context, WidgetRef ref, SkillLevel? current,
      AppLocalizations l) {
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

  void _showLevelPicker(
      BuildContext context, WidgetRef ref, SkillLevel? current) {
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
                style: Theme.of(ctx)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  leading: CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.12),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  title: Text(label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: level == current ? color : null,
                      )),
                  subtitle: Text(desc),
                  trailing: level == current
                      ? Icon(Icons.check_circle, color: color)
                      : const Icon(Icons.radio_button_unchecked),
                  onTap: () async {
                    Navigator.pop(ctx);
                    await ref
                        .read(profileNotifierProvider.notifier)
                        .setSkillLevel(level);
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
    await ref.read(sessionNotifierProvider.notifier).logout();
  }
}
