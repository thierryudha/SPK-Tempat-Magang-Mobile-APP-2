import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  final bool isEmbedded;
  const ProfileScreen({super.key, this.isEmbedded = false});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref.read(authProvider.notifier).logout();
    if (context.mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isEmbedded ? null : AppBar(title: const Text('Profil')),
      body: authAsync.when(
        loading: () => const LoadingWidget(message: 'Memuat profil...'),
        error: (err, _) => ErrorWidget2(
          message: err.toString(),
          onRetry: () => ref.invalidate(authProvider),
        ),
        data: (user) {
          if (user == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');
            });
            return const SizedBox();
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // ── Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Text(
                          user.name.isNotEmpty
                              ? user.name[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          user.role.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Info tiles
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            _InfoTile(
                              icon: Icons.person_outline,
                              label: 'Nama Lengkap',
                              value: user.name,
                            ),
                            const Divider(height: 1),
                            _InfoTile(
                              icon: Icons.email_outlined,
                              label: 'Email',
                              value: user.email,
                            ),
                            const Divider(height: 1),
                            _InfoTile(
                              icon: Icons.badge_outlined,
                              label: 'Role',
                              value: user.role[0].toUpperCase() +
                                  user.role.substring(1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tentang App
                      Card(
                        child: Column(
                          children: [
                            _InfoTile(
                              icon: Icons.info_outline,
                              label: 'Aplikasi',
                              value: 'SPK Magang - MOORA',
                            ),
                            const Divider(height: 1),
                            _InfoTile(
                              icon: Icons.code,
                              label: 'Versi',
                              value: '1.0.0',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Aksi Profil
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.edit_outlined, color: AppColors.primary),
                              title: const Text('Edit Profil'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => context.push('/profile/edit'),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.lock_outline, color: AppColors.primary),
                              title: const Text('Ubah Password'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => context.push('/profile/change-password'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Logout
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () => _logout(context, ref),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                          ),
                          icon: const Icon(Icons.logout),
                          label: const Text('Keluar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
