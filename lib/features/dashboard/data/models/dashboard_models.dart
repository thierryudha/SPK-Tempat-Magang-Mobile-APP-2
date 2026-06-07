import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_models.freezed.dart';
part 'dashboard_models.g.dart';

@freezed
class DashboardResponseModel with _$DashboardResponseModel {
  const factory DashboardResponseModel({
    required DashboardUserModel user,
    @JsonKey(name: 'latest_calculation') DashboardSessionModel? latestCalculation,
    @JsonKey(name: 'top_recommendation') DashboardTopCompanyModel? topRecommendation,
    @JsonKey(name: 'top_5_companies') @Default([]) List<DashboardTopCompanyModel> top5Companies,
    required DashboardSummaryModel summary,
    @JsonKey(name: 'recent_activity') @Default([]) List<DashboardSessionModel> recentActivity,
  }) = _DashboardResponseModel;

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseModelFromJson(json);
}

@freezed
class DashboardTopCompanyModel with _$DashboardTopCompanyModel {
  const factory DashboardTopCompanyModel({
    required int id,
    required String name,
    required int rank,
    @JsonKey(name: 'optimization_value') required double optimizationValue,
  }) = _DashboardTopCompanyModel;

  factory DashboardTopCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardTopCompanyModelFromJson(json);
}

@freezed
class DashboardUserModel with _$DashboardUserModel {
  const factory DashboardUserModel({
    required String name,
    required String email,
    @JsonKey(name: 'photo_url') String? photoUrl,
  }) = _DashboardUserModel;

  factory DashboardUserModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardUserModelFromJson(json);
}

@freezed
class DashboardSummaryModel with _$DashboardSummaryModel {
  const factory DashboardSummaryModel({
    @JsonKey(name: 'my_internships_count') required int myInternshipsCount,
    @JsonKey(name: 'global_stats') required DashboardGlobalStatsModel globalStats,
  }) = _DashboardSummaryModel;

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryModelFromJson(json);
}

@freezed
class DashboardGlobalStatsModel with _$DashboardGlobalStatsModel {
  const factory DashboardGlobalStatsModel({
    @JsonKey(name: 'total_global_companies') required int totalGlobalCompanies,
    @JsonKey(name: 'total_sectors') required int totalSectors,
  }) = _DashboardGlobalStatsModel;

  factory DashboardGlobalStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardGlobalStatsModelFromJson(json);
}

@freezed
class DashboardSessionModel with _$DashboardSessionModel {
  const factory DashboardSessionModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _DashboardSessionModel;

  factory DashboardSessionModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardSessionModelFromJson(json);
}
