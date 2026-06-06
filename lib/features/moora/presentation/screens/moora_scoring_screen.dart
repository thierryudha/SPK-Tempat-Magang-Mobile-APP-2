import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../providers/moora_provider.dart';
import '../../data/models/moora_models.dart';

class MooraScoringScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? setupData;
  const MooraScoringScreen({super.key, this.setupData});

  @override
  ConsumerState<MooraScoringScreen> createState() => _MooraScoringScreenState();
}

class _MooraScoringScreenState extends ConsumerState<MooraScoringScreen> {
  bool _isSubmitting = false;

  Future<void> _calculate() async {
    final criterias = ref.read(criteriasProvider).valueOrNull ?? [];
    final weights = ref.read(weightNotifierProvider);
    final internships = ref.read(selectedInternshipsProvider);
    final scores = ref.read(scoresNotifierProvider);
    final scoresNotifier = ref.read(scoresNotifierProvider.notifier);

    // Validasi completeness
    if (!scoresNotifier.isComplete(internships, criterias)) {
      AppSnackBar.showError(context, 'Semua skor harus diisi terlebih dahulu');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final payload = CalculateRequestModel(
        criteria: {for (final c in criterias) c.id.toString(): true},
        weights: weights,
        internships: internships.map((i) => i.id).toList(),
        scores: scores,
      );

      await ref.read(mooraCalculationProvider.notifier).calculate(payload);

      final result = ref.read(mooraCalculationProvider);
      if (!mounted) return;

      result.when(
        data: (_) => context.go('/moora/result'),
        error: (err, _) => AppSnackBar.showError(context, err.toString()),
        loading: () {},
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final criteriasAsync = ref.watch(criteriasProvider);
    final internships = ref.watch(selectedInternshipsProvider);
    final scores = ref.watch(scoresNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Input Skor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/moora/setup'),
        ),
      ),
      body: criteriasAsync.when(
        loading: () => const LoadingWidget(),
        error: (err, _) => ErrorWidget2(message: err.toString()),
        data: (criterias) {
          if (internships.isEmpty) {
            return const EmptyWidget(
              message: 'Tidak ada tempat magang yang dipilih.\nKembali ke Setup.',
              icon: Icons.list_alt,
            );
          }

          return Column(
            children: [
              // Progress indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: AppColors.primary.withOpacity(0.05),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        size: 16, color: AppColors.primaryLight),
                    const SizedBox(width: 8),
                    Text(
                      '${internships.length} tempat magang • ${criterias.length} kriteria',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.primaryLight),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: internships.length,
                  itemBuilder: (_, idx) {
                    final internship = internships[idx];
                    return _InternshipScoringCard(
                      internshipId: internship.id.toString(),
                      internshipName: internship.name,
                      internshipCity: internship.city,
                      criterias: criterias,
                      scores: scores[internship.id.toString()] ?? {},
                      onScoreChanged: (criteriaId, score) {
                        ref.read(scoresNotifierProvider.notifier).setScore(
                              internship.id.toString(),
                              criteriaId,
                              score,
                            );
                      },
                    );
                  },
                ),
              ),

              // Bottom bar
              Container(
                padding:
                    const EdgeInsets.fromLTRB(16, 12, 16, 24),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(top: BorderSide(color: AppColors.divider)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _calculate,
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.calculate_outlined),
                    label: Text(_isSubmitting ? 'Menghitung...' : 'Hitung MOORA'),
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

// ─── Card skor per internship ─────────────────────────────────
class _InternshipScoringCard extends StatelessWidget {
  final String internshipId;
  final String internshipName;
  final String internshipCity;
  final List<CriteriaModel> criterias;
  final Map<String, int> scores;
  final void Function(String criteriaId, int score) onScoreChanged;

  const _InternshipScoringCard({
    required this.internshipId,
    required this.internshipName,
    required this.internshipCity,
    required this.criterias,
    required this.scores,
    required this.onScoreChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filledCount =
        criterias.where((c) => scores.containsKey(c.id.toString())).length;
    final isComplete = filledCount == criterias.length;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                const Icon(Icons.business_outlined,
                    size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        internshipName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        internshipCity,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isComplete
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$filledCount/${criterias.length}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isComplete ? AppColors.success : AppColors.warning,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Criteria scoring rows
          ...criterias.map((c) => _CriteriaScoringRow(
                criteria: c,
                selectedScore: scores[c.id.toString()],
                onScoreSelected: (score) =>
                    onScoreChanged(c.id.toString(), score),
              )),
        ],
      ),
    );
  }
}

// ─── Satu baris kriteria dengan tombol skor 1-5 ───────────────
class _CriteriaScoringRow extends StatelessWidget {
  final CriteriaModel criteria;
  final int? selectedScore;
  final ValueChanged<int> onScoreSelected;

  const _CriteriaScoringRow({
    required this.criteria,
    required this.selectedScore,
    required this.onScoreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
          child: Row(
            children: [
              // Code + type
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  criteria.code,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  criteria.name,
                  style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: criteria.isBenefit
                      ? AppColors.benefit.withOpacity(0.1)
                      : AppColors.cost.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  criteria.isBenefit ? 'B' : 'C',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: criteria.isBenefit ? AppColors.benefit : AppColors.cost,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Dropdown Score Selection
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
          child: DropdownButtonFormField<int>(
            value: selectedScore,
            hint: const Text(
              'Pilih Skor Nilai...',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
            items: criteria.scales.isNotEmpty
                ? criteria.scales.map((scale) {
                    return DropdownMenuItem<int>(
                      value: scale.score,
                      child: Text(
                        scale.description,
                        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList()
                : List.generate(5, (i) {
                    final score = i + 1;
                    return DropdownMenuItem<int>(
                      value: score,
                      child: Text(
                        'Skor $score',
                        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                      ),
                    );
                  }),
            onChanged: (value) {
              if (value != null) {
                onScoreSelected(value);
              }
            },
          ),
        ),
      ],
    );
  }
}
