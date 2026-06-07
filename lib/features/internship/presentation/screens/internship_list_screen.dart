import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../providers/internship_provider.dart';
import '../widgets/internship_card.dart';

class InternshipListScreen extends ConsumerStatefulWidget {
  const InternshipListScreen({super.key});

  @override
  ConsumerState<InternshipListScreen> createState() => _InternshipListScreenState();
}

class _InternshipListScreenState extends ConsumerState<InternshipListScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final internshipsAsync = ref.watch(internshipsProvider);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      appBar: AppBar(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/internships/create'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: internshipsAsync.when(
        loading: () => const LoadingWidget(message: 'Memuat data magang...'),
        error: (err, _) => ErrorWidget2(
          message: err.toString(),
          onRetry: () => ref.invalidate(internshipsProvider),
        ),
        data: (internships) {
          final filtered = _searchQuery.isEmpty
              ? internships
              : internships
                  .where((i) =>
                      i.name.toLowerCase().contains(_searchQuery.toLowerCase()))
                  .toList();

          if (filtered.isEmpty) {
            return EmptyWidget(
              message: _searchQuery.isEmpty
                  ? 'Belum ada data tempat magang.'
                  : 'Tidak ditemukan untuk "$_searchQuery"',
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
                onTap: () => context.go('/internships/${filtered[i].id}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
