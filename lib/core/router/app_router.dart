import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/internship/presentation/screens/internship_list_screen.dart';
import '../../features/internship/presentation/screens/internship_detail_screen.dart';
import '../../features/internship/presentation/screens/internship_form_screen.dart';
import '../../features/moora/presentation/screens/moora_setup_screen.dart';
import '../../features/moora/presentation/screens/moora_scoring_screen.dart';
import '../../features/moora/presentation/screens/moora_result_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../storage/secure_storage_service.dart';

// Shell widget: membungkus halaman dengan BottomNavigationBar & FAB chatbot
class _AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const _AppShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1D4880),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Magang'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'MOORA'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
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

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: _guard,
    routes: [
      // Halaman publik
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

      // StatefulShellRoute untuk BottomNavigationBar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => _AppShell(navigationShell: navigationShell),
        branches: [
          // Branch 0: Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (_, __) => const DashboardScreen(),
              ),
            ],
          ),
          // Branch 1: Magang
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/internships',
                builder: (_, __) => const InternshipListScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (_, __) => const InternshipFormScreen(),
                  ),
                  GoRoute(
                    path: 'edit/:id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (_, state) => InternshipFormScreen(
                      internshipId: int.parse(state.pathParameters['id']!),
                    ),
                  ),
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (_, state) => InternshipDetailScreen(
                      id: int.parse(state.pathParameters['id']!),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Branch 2: MOORA
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/moora/setup',
                builder: (_, __) => const MooraSetupScreen(),
              ),
            ],
          ),
          // Branch 3: Profil
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (_, __) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (_, __) => const EditProfileScreen(),
                  ),
                  GoRoute(
                    path: 'change-password',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (_, __) => const ChangePasswordScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // Routes yang menutupi BottomNavBar (menggunakan root navigator)
      GoRoute(
        path: '/moora/scoring',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return MooraScoringScreen(setupData: extra);
        },
      ),
      GoRoute(
        path: '/moora/result',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return MooraResultScreen(resultData: extra);
        },
      ),
      GoRoute(
        path: '/chat',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const ChatScreen(),
      ),
    ],
  );

  static final _publicRoutes = {'/splash', '/login', '/register', '/forgot-password'};

  static Future<String?> _guard(BuildContext context, GoRouterState state) async {
    final isPublic = _publicRoutes.contains(state.matchedLocation);
    final hasToken = await SecureStorageService.hasToken();

    if (!hasToken && !isPublic) return '/login';
    // Redirect ke dashboard sebagai ganti /home
    if (hasToken && isPublic && state.matchedLocation != '/splash') return '/dashboard';
    
    // Redirect /home ke /internships jika ada yang masih mengarah ke sana
    if (state.matchedLocation == '/home') return '/dashboard';
    return null;
  }
}
