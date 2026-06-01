import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/internship/presentation/screens/internship_list_screen.dart';
import '../../features/internship/presentation/screens/internship_detail_screen.dart';
import '../../features/moora/presentation/screens/moora_setup_screen.dart';
import '../../features/moora/presentation/screens/moora_scoring_screen.dart';
import '../../features/moora/presentation/screens/moora_result_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../storage/secure_storage_service.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: _guard,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const InternshipListScreen(),
        routes: [
          GoRoute(
            path: 'internships/:id',
            builder: (_, state) => InternshipDetailScreen(
              id: int.parse(state.pathParameters['id']!),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/moora/setup',
        builder: (_, __) => const MooraSetupScreen(),
      ),
      GoRoute(
        path: '/moora/scoring',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return MooraScoringScreen(setupData: extra);
        },
      ),
      GoRoute(
        path: '/moora/result',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return MooraResultScreen(resultData: extra);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (_, __) => const ProfileScreen(),
      ),
    ],
  );

  static final _publicRoutes = {'/splash', '/login'};

  static Future<String?> _guard(BuildContext context, GoRouterState state) async {
    final isPublic = _publicRoutes.contains(state.matchedLocation);
    final hasToken = await SecureStorageService.hasToken();

    if (!hasToken && !isPublic) return '/login';
    if (hasToken && state.matchedLocation == '/login') return '/home';
    return null;
  }
}
