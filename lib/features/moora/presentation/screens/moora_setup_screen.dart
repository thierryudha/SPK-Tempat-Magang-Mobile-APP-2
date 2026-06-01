import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../providers/moora_provider.dart';
import '../../../internship/presentation/providers/internship_provider.dart';
import '../../data/models/moora_models.dart';

class MooraSetupScreen extends ConsumerStatefulWidget {
  final bool isEmbedded;
  const MooraSetupScreen({super.key, this.isEmbedded = false});

  @override
  ConsumerState<MooraSetupScreen> createState() => _MooraSetupScreenState();
}

class _MooraSetupScreenState extends ConsumerState<MooraSetupScreen> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // addPostFrameCallback = "jalankan ini SETELAH frame pertama selesai digambar"
    // Ini satu-satunya cara aman untuk modifikasi provider dari lifecycle widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initWeights();
    });
  }

  void _initWeights() {
    if (_initialized) return;

    final criteriasAsync = ref.read(criteriasProvider);
    final savedWeightsAsync = ref.read(savedWeightsProvider);

    criteriasAsync.whenData((criterias) {
      final saved = savedWeightsAsync.valueOrNull ?? {};
      ref.read(weightNotifierProvider.notifier).setFromSaved(saved, criterias);
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final criteriasAsync = ref.watch(criteriasProvider);
    final savedWeightsAsync = ref.watch(savedWeightsProvider);
    final weights = ref.watch(weightNotifierProvider);
    final weightNotifier = ref.read(weightNotifierProvider.notifier);
    final internshipsAsync = ref.watch(internshipsProvider);
    final selectedInternships = ref.watch(selectedInternshipsProvider);
    final selectedNotifier = ref.read(selectedInternshipsProvider.notifier);

    // Ketika data criteria baru selesai load, init weights
    // Tapi hanya dari listener, BUKAN dari dalam build langsung
    ref.listen(criteriasProvider, (prev, next) {
      next.whenData((criterias) {
        if (!_initialized) {
          final saved = ref.read(savedWeightsProvider).valueOrNull ?? {};
          WidgetsBinding.instance.addPostFrameCallback((_) {
            weightNotifier.setFromSaved(saved, criterias);
            _initialized = true;
          });
        }
      });
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: widget.isEmbedded
          ? null
          : AppBar(title: const Text('Setup SPK MOORA')),
      body: criteriasAsync.when(
        loading: () => const LoadingWidget(message: 'Memuat kriteria...'),
        error: (err, _) => ErrorWidget2(
          message: err.toString(),
          onRetry: () {
            _initialized = false;
            ref.invalidate(criteriasProvider);
            ref.invalidate(savedWeightsProvider);
          },
        ),
        data: (criterias) {
          final total = weightNotifier.total;
          final isValid = weightNotifier.isValid;

          return Column(
            children: [
              // ── Header total bobot
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: isValid
                    ? AppColors.success.withOpacity(0.08)
                    : AppColors.warning.withOpacity(0.08),
                child: Row(
                  children: [
                    Icon(
                      isValid ? Icons.check_circle : Icons.info_outline,
                      size: 18,
                      color: isValid ? AppColors.success : AppColors.warning,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        isValid
                            ? 'Total bobot 100% — siap dilanjutkan'
                            : 'Total bobot: ${total.toStringAsFixed(1)}% (harus tepat 100%)',
                        style: TextStyle(
                          fontSize: 13,
                          color: isValid ? AppColors.success : AppColors.warning,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Bagian 1: Bobot Kriteria
                      _SectionHeader(
                        title: 'Bobot Kriteria',
                        subtitle:
                            'Atur persentase bobot tiap kriteria (total harus 100%)',
                      ),
                      const SizedBox(height: 12),

                      if (savedWeightsAsync.isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: LoadingWidget(message: 'Memuat bobot tersimpan...'),
                        )
                      else
                        ...criterias.map((c) => _CriteriaWeightCard(
                              criteria: c,
                              weight: weights[c.id.toString()] ?? 0,
                              onChanged: (v) =>
                                  weightNotifier.updateWeight(c.id.toString(), v),
                            )),

                      const SizedBox(height: 24),

                      // ── Bagian 2: Pilih Internship
                      _SectionHeader(
                        title: 'Pilih Tempat Magang',
                        subtitle:
                            'Pilih yang ingin dibandingkan (minimal 1)',
                      ),
                      const SizedBox(height: 12),
                      internshipsAsync.when(
                        loading: () => const LoadingWidget(),
                        error: (err, _) =>
                            ErrorWidget2(message: err.toString()),
                        data: (internships) => Column(
                          children: internships
                              .map((i) => _InternshipCheckCard(
                                    name: i.name,
                                    city: i.city,
                                    category: i.category?.name,
                                    isSelected:
                                        selectedNotifier.isSelected(i.id),
                                    onToggle: () => selectedNotifier.toggle(i),
                                  ))
                              .toList(),
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: criteriasAsync.whenOrNull(
        data: (_) {
          final isWeightValid =
              ref.watch(weightNotifierProvider.notifier).isValid;
          final hasInternships = selectedInternships.isNotEmpty;
          final canProceed = isWeightValid && hasInternships;

          return FloatingActionButton.extended(
            onPressed: canProceed
                ? () => context.go('/moora/scoring')
                : () {
                    final msg = !isWeightValid
                        ? 'Total bobot harus tepat 100%'
                        : 'Pilih minimal 1 tempat magang';
                    AppSnackBar.showError(context, msg);
                  },
            backgroundColor:
                canProceed ? AppColors.primary : AppColors.textHint,
            icon: const Icon(Icons.arrow_forward),
            label: Text('Lanjut Scoring (${selectedInternships.length})'),
          );
        },
      ),
    );
  }
}

// ─── Criteria Weight Card ─────────────────────────────────────
class _CriteriaWeightCard extends StatefulWidget {
  final CriteriaModel criteria;
  final double weight;
  final ValueChanged<double> onChanged;

  const _CriteriaWeightCard({
    required this.criteria,
    required this.weight,
    required this.onChanged,
  });

  @override
  State<_CriteriaWeightCard> createState() => _CriteriaWeightCardState();
}

class _CriteriaWeightCardState extends State<_CriteriaWeightCard> {
  late TextEditingController _ctrl;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.weight == 0 ? '' : widget.weight.toStringAsFixed(0),
    );
  }

  @override
  void didUpdateWidget(_CriteriaWeightCard old) {
    super.didUpdateWidget(old);
    if (!_hasFocus) {
      final newText =
          widget.weight == 0 ? '' : widget.weight.toStringAsFixed(0);
      if (_ctrl.text != newText) _ctrl.text = newText;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isBenefit = widget.criteria.isBenefit;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.criteria.code,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.criteria.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: isBenefit
                        ? AppColors.benefit.withOpacity(0.1)
                        : AppColors.cost.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isBenefit ? 'Benefit' : 'Cost',
                    style: TextStyle(
                      fontSize: 11,
                      color: isBenefit ? AppColors.benefit : AppColors.cost,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: widget.weight.clamp(0, 100),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.divider,
                    onChanged: (v) {
                      widget.onChanged(v);
                      if (!_hasFocus) {
                        _ctrl.text = v.toStringAsFixed(0);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  child: Focus(
                    onFocusChange: (hasFocus) =>
                        setState(() => _hasFocus = hasFocus),
                    child: TextField(
                      controller: _ctrl,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        suffixText: '%',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.divider),
                        ),
                      ),
                      onChanged: (v) {
                        final parsed = double.tryParse(v);
                        if (parsed != null &&
                            parsed >= 0 &&
                            parsed <= 100) {
                          widget.onChanged(parsed);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Internship Check Card ────────────────────────────────────
class _InternshipCheckCard extends StatelessWidget {
  final String name;
  final String city;
  final String? category;
  final bool isSelected;
  final VoidCallback onToggle;

  const _InternshipCheckCard({
    required this.name,
    required this.city,
    this.category,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 12),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primary
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textHint,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check,
                          size: 14, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        category != null
                            ? '$city • $category'
                            : city,
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader(
      {required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary)),
        const SizedBox(height: 2),
        Text(subtitle,
            style: const TextStyle(
                fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}