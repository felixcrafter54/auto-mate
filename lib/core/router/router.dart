import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/session_provider.dart';
import '../providers/profile_provider.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/onboarding/skill_quiz_screen.dart';
import '../../features/onboarding/skill_result_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/vehicle_setup/presentation/vehicle_setup_screen.dart';
import '../../features/vehicle_detail/vehicle_detail_screen.dart';
import '../../features/reminders/reminders_screen.dart';
import '../../features/reminders/add_reminder_screen.dart';
import '../../features/reminders/history_screen.dart';
import '../../features/consumables/consumables_screen.dart';
import '../../features/tutorials/tutorials_screen.dart';
import '../../features/tutorials/video_player_screen.dart';
import '../../features/workshop_report/workshop_report_screen.dart';
import '../../features/breakdown/breakdown_screen.dart';
import '../../features/breakdown/garage_finder_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../services/models/enums.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final persistedAsync = ref.watch(persistedUserIdProvider);
  final userAsync = ref.watch(currentUserProvider);

  // Splash while loading session
  if (persistedAsync.isLoading || userAsync.isLoading) {
    return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const _SplashScreen()),
      ],
    );
  }

  final userId = ref.watch(currentUserIdProvider);
  final onboardingComplete = ref.watch(onboardingCompleteProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final loggedIn = userId != null;
      final loc = state.matchedLocation;

      if (!loggedIn) {
        if (loc != '/onboarding') return '/onboarding';
        return null;
      }

      if (!onboardingComplete) {
        if (loc != '/skill-quiz' && loc != '/skill-result') return '/skill-quiz';
        return null;
      }

      if (loc == '/onboarding' || loc == '/skill-quiz' || loc == '/skill-result') {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: '/', builder: (_, _) => const DashboardScreen()),
      GoRoute(path: '/skill-quiz', builder: (_, _) => const SkillQuizScreen()),
      GoRoute(
        path: '/skill-result',
        builder: (_, state) {
          final level = state.extra as SkillLevel;
          return SkillResultScreen(detectedLevel: level);
        },
      ),
      GoRoute(
        path: '/vehicle-setup',
        builder: (_, _) => const VehicleSetupScreen(),
      ),
      GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
      GoRoute(
        path: '/vehicle/:id',
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return VehicleDetailScreen(vehicleId: id);
        },
        routes: [
          GoRoute(
            path: 'reminders',
            builder: (_, state) {
              final id = int.parse(state.pathParameters['id']!);
              return RemindersScreen(vehicleId: id);
            },
            routes: [
              GoRoute(
                path: 'add',
                builder: (_, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return AddReminderScreen(vehicleId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'history',
            builder: (_, state) {
              final id = int.parse(state.pathParameters['id']!);
              return HistoryScreen(vehicleId: id);
            },
          ),
          GoRoute(
            path: 'consumables',
            builder: (_, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ConsumablesScreen(vehicleId: id);
            },
          ),
          GoRoute(
            path: 'tutorials',
            builder: (_, state) {
              final id = int.parse(state.pathParameters['id']!);
              return TutorialsScreen(vehicleId: id);
            },
          ),
          GoRoute(
            path: 'report',
            builder: (_, state) {
              final id = int.parse(state.pathParameters['id']!);
              return WorkshopReportScreen(vehicleId: id);
            },
          ),
          GoRoute(
            path: 'breakdown',
            builder: (_, state) {
              final id = int.parse(state.pathParameters['id']!);
              return BreakdownScreen(vehicleId: id);
            },
          ),
          GoRoute(
            path: 'garages',
            builder: (_, _) => const GarageFinderScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/video/:id',
        builder: (_, state) {
          final videoId = state.pathParameters['id']!;
          final title = (state.extra as String?) ?? 'Video';
          return VideoPlayerScreen(videoId: videoId, title: title);
        },
      ),
    ],
  );
});

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
