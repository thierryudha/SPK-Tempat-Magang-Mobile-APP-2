// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardResponseModelImpl _$$DashboardResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardResponseModelImpl(
      user: DashboardUserModel.fromJson(json['user'] as Map<String, dynamic>),
      latestCalculation: json['latest_calculation'] == null
          ? null
          : DashboardSessionModel.fromJson(
              json['latest_calculation'] as Map<String, dynamic>),
      topRecommendation: json['top_recommendation'] == null
          ? null
          : DashboardTopCompanyModel.fromJson(
              json['top_recommendation'] as Map<String, dynamic>),
      top5Companies: (json['top_5_companies'] as List<dynamic>?)
              ?.map((e) =>
                  DashboardTopCompanyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      summary: DashboardSummaryModel.fromJson(
          json['summary'] as Map<String, dynamic>),
      recentActivity: (json['recent_activity'] as List<dynamic>?)
              ?.map((e) =>
                  DashboardSessionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DashboardResponseModelImplToJson(
        _$DashboardResponseModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'latest_calculation': instance.latestCalculation,
      'top_recommendation': instance.topRecommendation,
      'top_5_companies': instance.top5Companies,
      'summary': instance.summary,
      'recent_activity': instance.recentActivity,
    };

_$DashboardTopCompanyModelImpl _$$DashboardTopCompanyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardTopCompanyModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      rank: (json['rank'] as num).toInt(),
      optimizationValue: (json['optimization_value'] as num).toDouble(),
    );

Map<String, dynamic> _$$DashboardTopCompanyModelImplToJson(
        _$DashboardTopCompanyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rank': instance.rank,
      'optimization_value': instance.optimizationValue,
    };

_$DashboardUserModelImpl _$$DashboardUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardUserModelImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photo_url'] as String?,
    );

Map<String, dynamic> _$$DashboardUserModelImplToJson(
        _$DashboardUserModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'photo_url': instance.photoUrl,
    };

_$DashboardSummaryModelImpl _$$DashboardSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardSummaryModelImpl(
      myInternshipsCount: (json['my_internships_count'] as num).toInt(),
      globalStats: DashboardGlobalStatsModel.fromJson(
          json['global_stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DashboardSummaryModelImplToJson(
        _$DashboardSummaryModelImpl instance) =>
    <String, dynamic>{
      'my_internships_count': instance.myInternshipsCount,
      'global_stats': instance.globalStats,
    };

_$DashboardGlobalStatsModelImpl _$$DashboardGlobalStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardGlobalStatsModelImpl(
      totalGlobalCompanies: (json['total_global_companies'] as num).toInt(),
      totalSectors: (json['total_sectors'] as num).toInt(),
    );

Map<String, dynamic> _$$DashboardGlobalStatsModelImplToJson(
        _$DashboardGlobalStatsModelImpl instance) =>
    <String, dynamic>{
      'total_global_companies': instance.totalGlobalCompanies,
      'total_sectors': instance.totalSectors,
    };

_$DashboardSessionModelImpl _$$DashboardSessionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardSessionModelImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$DashboardSessionModelImplToJson(
        _$DashboardSessionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
