import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../providers/internship_provider.dart';
import '../widgets/internship_card.dart';
import '../../../moora/presentation/screens/moora_setup_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class InternshipListScreen extends ConsumerStatefulWidget {
  const InternshipListScreen({super.key});

  @override
  ConsumerState<InternshipListScreen> createState() => _InternshipListScreenState();
}

class _InternshipListScreenState extends ConsumerState<InternshipListScreen> {
  int _currentIndex = 0;
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      _InternshipTab(searchQuery: _searchQuery),
      const MooraSetupScreen(isEmbedded: true),
      const ProfileScreen(isEmbedded: true),
    ];

    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              title: const Text('Tempat Magang'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => ref.invalidate(internshipsProvider),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Cari tempat magang...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      prefixIcon: Icon(Icons.search,
                          color: Colors.white.withOpacity(0.7), size: 20),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: screens[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => context.go('/home/internships/create'),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            activeIcon: Icon(Icons.business),
            label: 'Magang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'SPK',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _InternshipTab extends ConsumerWidget {
  final String searchQuery;
  const _InternshipTab({required this.searchQuery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internshipsAsync = ref.watch(internshipsProvider);

    return internshipsAsync.when(
      loading: () => const LoadingWidget(message: 'Memuat data magang...'),
      error: (err, _) => ErrorWidget2(
        message: err.toString(),
        onRetry: () => ref.invalidate(internshipsProvider),
      ),
      data: (internships) {
        final filtered = searchQuery.isEmpty
            ? internships
            : internships
                .where((i) =>
                    i.name.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();

        if (filtered.isEmpty) {
          return EmptyWidget(
            message: searchQuery.isEmpty
                ? 'Belum ada data tempat magang.'
                : 'Tidak ditemukan untuk "$searchQuery"',
            icon: Icons.business_outlined,
          );
        }

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(internshipsProvider),
          color: AppColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            itemBuilder: (_, i) => InternshipCard(
              internship: filtered[i],
              onTap: () => context.go('/home/internships/${filtered[i].id}'),
            ),
          ),
        );
      },
    );
  }
}
