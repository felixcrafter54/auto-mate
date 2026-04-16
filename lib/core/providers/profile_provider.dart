import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/database/database.dart';
import '../../services/models/enums.dart';
import 'database_provider.dart';
import 'session_provider.dart';

// ── Derived state from current user ──────────────────────────────────────────

final skillLevelProvider = Provider<SkillLevel?>((ref) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user?.skillLevel == null) return null;
  return SkillLevel.fromString(user!.skillLevel!);
});

final onboardingCompleteProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  return user?.onboardingComplete ?? false;
});

// ── Loading state (are we still fetching the user?) ───────────────────────────

final profileLoadingProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider).isLoading;
});

// ── Mutations ─────────────────────────────────────────────────────────────────

final profileNotifierProvider =
    NotifierProvider<ProfileNotifier, void>(ProfileNotifier.new);

class ProfileNotifier extends Notifier<void> {
  @override
  void build() {}

  AppDatabase get _db => ref.read(databaseProvider);
  int? get _userId => ref.read(currentUserIdProvider);

  Future<void> completeOnboarding(SkillLevel level) async {
    final uid = _userId;
    if (uid == null) return;
    await _db.completeUserOnboarding(uid, level.value);
    // Re-fetch the user so all derived providers update
    ref.invalidate(currentUserProvider);
  }

  Future<void> setSkillLevel(SkillLevel level) async {
    final uid = _userId;
    if (uid == null) return;
    await _db.updateUserSkillLevel(uid, level.value);
    ref.invalidate(currentUserProvider);
  }
}
