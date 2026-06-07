import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/shared_widgets.dart';
import '../providers/dashboard_provider.dart';
import '../../data/models/dashboard_models.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Very light gray/blue background
      appBar: AppBar(
        title: const Text('Pusat Analitik Intelligence', 
            style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
            onPressed: () => ref.invalidate(dashboardDataProvider),
          ),
        ],
      ),
      body: dashboardAsync.when(
        loading: () => const LoadingWidget(message: 'Memuat Analitik...'),
        error: (err, stack) => ErrorWidget2(
          message: err.toString(),
          onRetry: () => ref.invalidate(dashboardDataProvider),
        ),
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(dashboardDataProvider),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeroCard(data.topRecommendation),
                  const SizedBox(height: 16),
                  _buildTop5Card(data.top5Companies),
                  const SizedBox(height: 16),
                  _buildStrategicInsightCard(data.summary, context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(DashboardTopCompanyModel? topWinner) {
    final hasWinner = topWinner != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Left Side: Texts
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0FE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'ANALISIS PERSONAL',
                    style: TextStyle(
                      color: Color(0xFF1967D2),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  hasWinner ? topWinner.name.toUpperCase() : 'BELUM ADA DATA',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  hasWinner
                      ? 'Profil ini dirangkum berdasarkan preferensi bobot unik Anda terhadap kriteria penilaian.'
                      : 'Jalankan program MOORA terlebih dahulu untuk mendapatkan analisis personal Anda.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                if (hasWinner)
                  Row(
                    children: [
                      _buildMiniScoreCard('EVALUASI', '1', 'PERINGKAT'),
                      const SizedBox(width: 12),
                      _buildMiniScoreCard(
                        'NILAI OPTIMASI',
                        topWinner.optimizationValue.toStringAsFixed(3),
                        'skor moora terbaik',
                        isHighlight: true,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // Right Side: Radar Chart
          if (hasWinner)
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 150,
                child: _buildRadarChart(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMiniScoreCard(String title, String value, String subtitle, {bool isHighlight = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isHighlight ? const Color(0xFFE8F0FE) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isHighlight ? Colors.transparent : const Color(0xFFF1F3F4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: isHighlight ? const Color(0xFF1967D2) : AppColors.textHint)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: isHighlight ? const Color(0xFF1967D2) : AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(subtitle, style: TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: isHighlight ? const Color(0xFF1967D2).withOpacity(0.7) : AppColors.textHint)),
          ],
        ),
      ),
    );
  }

  Widget _buildRadarChart() {
    return RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            fillColor: const Color(0xFF1967D2).withOpacity(0.2),
            borderColor: const Color(0xFF1967D2),
            entryRadius: 3,
            dataEntries: [
              const RadarEntry(value: 4.5),
              const RadarEntry(value: 3.8),
              const RadarEntry(value: 4.2),
            ],
            borderWidth: 2,
          ),
        ],
        radarBackgroundColor: Colors.transparent,
        borderData: FlBorderData(show: false),
        radarBorderData: const BorderSide(color: Color(0xFFE0E0E0)),
        getTitle: (index, angle) {
          switch (index) {
            case 0:
              return const RadarChartTitle(text: 'Uang Saku', angle: 0);
            case 1:
              return const RadarChartTitle(text: 'Jam Kerja', angle: 0);
            case 2:
              return const RadarChartTitle(text: 'Jarak', angle: 0);
            default:
              return const RadarChartTitle(text: '');
          }
        },
        titleTextStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 8),
        tickCount: 3,
        ticksTextStyle: const TextStyle(color: Colors.transparent),
        tickBorderData: const BorderSide(color: Color(0xFFF1F3F4)),
        gridBorderData: const BorderSide(color: Color(0xFFF1F3F4)),
      ),
      swapAnimationDuration: const Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear,
    );
  }

  Widget _buildTop5Card(List<DashboardTopCompanyModel> companies) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 16, color: Colors.amber),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Top 5 Elite Companies',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (companies.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('Belum ada data magang.', style: TextStyle(color: AppColors.textHint, fontSize: 12)),
            )
          else
            ...companies.map((c) => _buildCompanyItem(c)),
        ],
      ),
    );
  }

  Widget _buildCompanyItem(DashboardTopCompanyModel company) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFF1F3F4)),
            ),
            child: Center(
              child: Text(
                '${company.rank}',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.textSecondary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.name,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 12),
                const SizedBox(width: 4),
                Text(
                  company.optimizationValue.toStringAsFixed(2),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 10, color: Colors.amber),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrategicInsightCard(DashboardSummaryModel summary, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1D4880), Color(0xFF2A67B5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4880).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative background circles
          Positioned(
            right: -30,
            top: -30,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white.withOpacity(0.05),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white.withOpacity(0.05),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'STRATEGIC INSIGHT',
                  style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Siap Untuk Menentukan\nPilihan Terbaikmu?',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, height: 1.2),
                ),
                const SizedBox(height: 12),
                const Text(
                  '"Kami siap membantu kamu mewujudkan jalur karir yang lebih baik!"',
                  style: TextStyle(color: Colors.white70, fontSize: 10, fontStyle: FontStyle.italic, height: 1.4),
                ),
                const SizedBox(height: 20),
                
                // Scan Stats Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${summary.globalStats.totalGlobalCompanies}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                            const Text('DATABASE', style: TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 30, color: Colors.white.withOpacity(0.2)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${summary.myInternshipsCount}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                            const Text('MY INTERNS', style: TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/moora/setup'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1D4880),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.arrow_forward, size: 14),
                    label: const Text('Jalankan MOORA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
