import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/internship/presentation/screens/internship_list_screen.dart';
import '../../features/internship/presentation/screens/internship_detail_screen.dart';
import '../../features/moora/presentation/screens/moora_setup_screen.dart';
import '../../features/moora/presentation/screens/moora_scoring_screen.dart';
import '../../features/moora/presentation/screens/moora_result_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../storage/secure_storage_service.dart';

// Shell widget: membungkus semua halaman yang butuh floating button chatbot
class _AppShell extends StatelessWidget {
  final Widget child;
  const _AppShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70.0, right: 14.0),
        child: FloatingActionButton(
          heroTag: 'globalChatBtn',
          backgroundColor: const Color(0xFF1D4880),
          onPressed: () => context.push('/chat'),
          child: const Icon(Icons.chat_bubble, color: Colors.white),
        ),
      ),
    );
  }
}

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: _guard,
    routes: [
      // Halaman publik (tanpa FAB chatbot)
      GoRoute(
        path: '/splash',
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (_, __) => const ForgotPasswordScreen(),
      ),

      // ShellRoute: semua halaman private dibungkus _AppShell yang punya FAB chatbot
      ShellRoute(
        builder: (_, __, child) => _AppShell(child: child),
        routes: [
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
            routes: [
              GoRoute(
                path: 'edit',
                builder: (_, __) => const EditProfileScreen(),
              ),
              GoRoute(
                path: 'change-password',
                builder: (_, __) => const ChangePasswordScreen(),
              ),
            ],
          ),
        ],
      ),

      // Halaman chat (di luar ShellRoute agar tampil full screen tanpa FAB ganda)
      GoRoute(
        path: '/chat',
        builder: (_, __) => const ChatScreen(),
      ),
    ],
  );

  static final _publicRoutes = {'/splash', '/login', '/register', '/forgot-password'};

  static Future<String?> _guard(BuildContext context, GoRouterState state) async {
    final isPublic = _publicRoutes.contains(state.matchedLocation);
    final hasToken = await SecureStorageService.hasToken();

    if (!hasToken && !isPublic) return '/login';
    if (hasToken && isPublic && state.matchedLocation != '/splash') return '/home';
    return null;
  }
}
