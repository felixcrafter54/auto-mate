import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/database/database.dart';
import 'database_provider.dart';

const _kUserIdKey = 'current_user_id';

/// Loads the persisted userId from SharedPreferences on startup.
final persistedUserIdProvider = FutureProvider<int?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(_kUserIdKey);
});

/// Holds the currently active userId in memory. Initialised from storage.
final currentUserIdProvider = StateProvider<int?>((ref) {
  final persisted = ref.watch(persistedUserIdProvider);
  return persisted.valueOrNull;
});

/// Full user data for the current session — refreshed on demand via invalidate.
final currentUserProvider = FutureProvider<User?>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return null;
  final db = ref.read(databaseProvider);
  return (db.select(db.users)..where((u) => u.id.equals(userId)))
      .getSingleOrNull();
});

/// Session notifier — handles login and user creation.
final sessionNotifierProvider =
    AsyncNotifierProvider<SessionNotifier, User?>(SessionNotifier.new);

class SessionNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return null;
    final db = ref.read(databaseProvider);
    return (db.select(db.users)..where((u) => u.id.equals(userId)))
        .getSingleOrNull();
  }

  Future<void> createAndLogin({
    required String name,
    required String email,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(usersRepositoryProvider);

    User? user = await repo.getUserByEmail(email);
    if (user == null) {
      await repo.createUser(name: name, email: email);
      user = await repo.getUserByEmail(email);
    }

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_kUserIdKey, user.id);
      ref.read(currentUserIdProvider.notifier).state = user.id;
    }

    state = AsyncData(user);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kUserIdKey);
    ref.read(currentUserIdProvider.notifier).state = null;
    state = const AsyncData(null);
  }
}
