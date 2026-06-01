import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../providers/moora_provider.dart';
import '../../data/models/moora_models.dart';

class MooraResultScreen extends ConsumerWidget {
  final Map<String, dynamic>? resultData;
  const MooraResultScreen({super.key, this.resultData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(mooraCalculationProvider);
    final criterias = ref.watch(criteriasProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hasil Rekomendasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/moora/scoring'),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              ref.read(mooraCalculationProvider.notifier).reset();
              ref.read(scoresNotifierProvider.notifier).clear();
              ref.read(selectedInternshipsProvider.notifier).clear();
              context.go('/home');
            },
            icon: const Icon(Icons.home_outlined, color: Colors.white, size: 18),
            label: const Text('Selesai', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: resultAsync.when(
        loading: () =>
            const LoadingWidget(message: 'Menghitung rekomendasi...'),
        error: (err, _) => ErrorWidget2(
          message: err.toString(),
          onRetry: () => context.go('/moora/scoring'),
        ),
        data: (results) {
          if (results.isEmpty) {
            return const EmptyWidget(
              message: 'Belum ada hasil perhitungan.',
              icon: Icons.analytics_outlined,
            );
          }

          final winner = results.first; // rank 1

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Winner card
                _WinnerCard(winner: winner),
                const SizedBox(height: 20),

                // ── Ranking label
                const Text(
                  'Semua Ranking',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),

                // ── All results
                ...results.map((r) => _ResultCard(
                      result: r,
                      criterias: criterias,
                      isWinner: r.rank == 1,
                    )),

                const SizedBox(height: 20),

                // ── Hitung ulang
                OutlinedButton.icon(
                  onPressed: () {
                    ref.read(mooraCalculationProvider.notifier).reset();
                    ref.read(scoresNotifierProvider.notifier).clear();
                    context.go('/moora/setup');
                  },
                  icon: const Icon(Icons.refresh, color: AppColors.primary),
                  label: const Text('Hitung Ulang',
                      style: TextStyle(color: AppColors.primary)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
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

// ─── Winner highlight card ────────────────────────────────────
class _WinnerCard extends StatelessWidget {
  final MooraResultModel winner;
  const _WinnerCard({required this.winner});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber, size: 40),
          const SizedBox(height: 8),
          const Text(
            'Rekomendasi Terbaik',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            winner.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Nilai Optimasi: ${winner.optimizationValue.toStringAsFixed(4)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Individual result card ───────────────────────────────────
class _ResultCard extends StatefulWidget {
  final MooraResultModel result;
  final List<CriteriaModel> criterias;
  final bool isWinner;

  const _ResultCard({
    required this.result,
    required this.criterias,
    required this.isWinner,
  });

  @override
  State<_ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<_ResultCard> {
  bool _expanded = false;

  Color get _rankColor {
    switch (widget.result.rank) {
      case 1:
        return const Color(0xFFFFD700); // gold
      case 2:
        return const Color(0xFFC0C0C0); // silver
      case 3:
        return const Color(0xFFCD7F32); // bronze
      default:
        return AppColors.textHint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Rank badge
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _rankColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: _rankColor, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '#${widget.result.rank}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: _rankColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.result.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            if (widget.isWinner)
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Nilai: ${widget.result.optimizationValue.toStringAsFixed(4)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.textHint,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          // Expanded detail
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Skor Normalisasi per Kriteria',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.criterias.map((c) {
                    final normalizedData =
                        widget.result.normalizedScores[c.id.toString()];
                    final rawScore =
                        widget.result.scores[c.id.toString()];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 32,
                            child: Text(
                              c.code,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              c.name,
                              style: const TextStyle(
                                  fontSize: 11, color: AppColors.textSecondary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (rawScore != null)
                            Text(
                              'Skor: $rawScore',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          if (normalizedData != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              'N: ${normalizedData.normalized.toStringAsFixed(3)}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }),

                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(
                          label: 'Benefit',
                          value: widget.result.sumBenefit.toStringAsFixed(4),
                          color: AppColors.benefit),
                      _StatChip(
                          label: 'Cost',
                          value: widget.result.sumCost.toStringAsFixed(4),
                          color: AppColors.cost),
                      _StatChip(
                          label: 'Optimasi',
                          value:
                              widget.result.optimizationValue.toStringAsFixed(4),
                          color: AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}
