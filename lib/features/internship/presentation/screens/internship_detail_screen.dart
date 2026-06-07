import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../providers/internship_provider.dart';

class InternshipDetailScreen extends ConsumerWidget {
  final int id;
  const InternshipDetailScreen({super.key, required this.id});

  Future<void> _launchURL(BuildContext context, String urlString) async {
    if (urlString.isEmpty) return;

    var uriString = urlString.trim();
    if (!uriString.startsWith('http://') && !uriString.startsWith('https://')) {
      uriString = 'https://$uriString';
    }

    final uri = Uri.tryParse(uriString);
    if (uri != null) {
      try {
        final success = await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (!success) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tidak dapat membuka link: $urlString')),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error membuka link: $e')),
          );
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Format link tidak valid: $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internshipAsync = ref.watch(internshipDetailProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: internshipAsync.when(
        loading: () => const Scaffold(
          body: LoadingWidget(message: 'Memuat detail...'),
        ),
        error: (err, _) => Scaffold(
          appBar: AppBar(title: const Text('Detail Magang')),
          body: ErrorWidget2(message: err.toString()),
        ),
        data: (internship) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () => context.go('/home/internships/edit/${internship.id}'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Hapus Data'),
                          content: const Text('Yakin ingin menghapus tempat magang ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                ref.read(internshipActionProvider.notifier).deleteInternship(internship.id);
                                context.pop();
                              },
                              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    internship.name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryLight],
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.business, size: 64, color: Colors.white30),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badges
                      Row(
                        children: [
                          if (internship.websiteLink != null && internship.websiteLink!.isNotEmpty)
                            InkWell(
                              onTap: () => _launchURL(context, internship.websiteLink!),
                              borderRadius: BorderRadius.circular(20),
                              child: _Badge(
                                icon: Icons.language_outlined,
                                label: 'Website',
                                color: AppColors.primaryLight,
                              ),
                            ),
                          const SizedBox(width: 8),
                          if (internship.category != null)
                            _Badge(
                              icon: Icons.category_outlined,
                              label: internship.category!.name,
                              color: AppColors.accent,
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Tidak ada deskripsi di backend, bisa dihilangkan
                      const SizedBox(height: 20),

                      // Info detail
                      _SectionTitle(title: 'Informasi'),
                      const SizedBox(height: 8),
                      Card(
                        child: Column(
                          children: [
                            _InfoRow(
                                icon: Icons.business_outlined,
                                label: 'Nama',
                                value: internship.name),
                            if (internship.websiteLink != null && internship.websiteLink!.isNotEmpty) ...[
                              const Divider(height: 1),
                              _InfoRow(
                                icon: Icons.language_outlined,
                                label: 'Website',
                                value: internship.websiteLink!,
                                onTap: () => _launchURL(context, internship.websiteLink!),
                              ),
                            ],
                            if (internship.category != null) ...[
                              const Divider(height: 1),
                              _InfoRow(
                                  icon: Icons.category_outlined,
                                  label: 'Kategori',
                                  value: internship.category!.name),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Badge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: onTap != null ? Colors.blue : AppColors.textPrimary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      decoration: onTap != null ? TextDecoration.underline : null,
    );

    final rowContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: onTap != null ? Colors.blue : AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: textStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 4),
            const Icon(Icons.open_in_new, size: 16, color: Colors.blue),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: rowContent,
      );
    }

    return rowContent;
  }
}
