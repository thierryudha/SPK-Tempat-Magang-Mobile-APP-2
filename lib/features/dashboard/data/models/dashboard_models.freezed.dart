// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardResponseModel _$DashboardResponseModelFromJson(
    Map<String, dynamic> json) {
  return _DashboardResponseModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardResponseModel {
  DashboardUserModel get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'latest_calculation')
  DashboardSessionModel? get latestCalculation =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'top_recommendation')
  DashboardTopCompanyModel? get topRecommendation =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'top_5_companies')
  List<DashboardTopCompanyModel> get top5Companies =>
      throw _privateConstructorUsedError;
  DashboardSummaryModel get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_activity')
  List<DashboardSessionModel> get recentActivity =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardResponseModelCopyWith<DashboardResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardResponseModelCopyWith<$Res> {
  factory $DashboardResponseModelCopyWith(DashboardResponseModel value,
          $Res Function(DashboardResponseModel) then) =
      _$DashboardResponseModelCopyWithImpl<$Res, DashboardResponseModel>;
  @useResult
  $Res call(
      {DashboardUserModel user,
      @JsonKey(name: 'latest_calculation')
      DashboardSessionModel? latestCalculation,
      @JsonKey(name: 'top_recommendation')
      DashboardTopCompanyModel? topRecommendation,
      @JsonKey(name: 'top_5_companies')
      List<DashboardTopCompanyModel> top5Companies,
      DashboardSummaryModel summary,
      @JsonKey(name: 'recent_activity')
      List<DashboardSessionModel> recentActivity});

  $DashboardUserModelCopyWith<$Res> get user;
  $DashboardSessionModelCopyWith<$Res>? get latestCalculation;
  $DashboardTopCompanyModelCopyWith<$Res>? get topRecommendation;
  $DashboardSummaryModelCopyWith<$Res> get summary;
}

/// @nodoc
class _$DashboardResponseModelCopyWithImpl<$Res,
        $Val extends DashboardResponseModel>
    implements $DashboardResponseModelCopyWith<$Res> {
  _$DashboardResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? latestCalculation = freezed,
    Object? topRecommendation = freezed,
    Object? top5Companies = null,
    Object? summary = null,
    Object? recentActivity = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as DashboardUserModel,
      latestCalculation: freezed == latestCalculation
          ? _value.latestCalculation
          : latestCalculation // ignore: cast_nullable_to_non_nullable
              as DashboardSessionModel?,
      topRecommendation: freezed == topRecommendation
          ? _value.topRecommendation
          : topRecommendation // ignore: cast_nullable_to_non_nullable
              as DashboardTopCompanyModel?,
      top5Companies: null == top5Companies
          ? _value.top5Companies
          : top5Companies // ignore: cast_nullable_to_non_nullable
              as List<DashboardTopCompanyModel>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as DashboardSummaryModel,
      recentActivity: null == recentActivity
          ? _value.recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as List<DashboardSessionModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardUserModelCopyWith<$Res> get user {
    return $DashboardUserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardSessionModelCopyWith<$Res>? get latestCalculation {
    if (_value.latestCalculation == null) {
      return null;
    }

    return $DashboardSessionModelCopyWith<$Res>(_value.latestCalculation!,
        (value) {
      return _then(_value.copyWith(latestCalculation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardTopCompanyModelCopyWith<$Res>? get topRecommendation {
    if (_value.topRecommendation == null) {
      return null;
    }

    return $DashboardTopCompanyModelCopyWith<$Res>(_value.topRecommendation!,
        (value) {
      return _then(_value.copyWith(topRecommendation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardSummaryModelCopyWith<$Res> get summary {
    return $DashboardSummaryModelCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardResponseModelImplCopyWith<$Res>
    implements $DashboardResponseModelCopyWith<$Res> {
  factory _$$DashboardResponseModelImplCopyWith(
          _$DashboardResponseModelImpl value,
          $Res Function(_$DashboardResponseModelImpl) then) =
      __$$DashboardResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DashboardUserModel user,
      @JsonKey(name: 'latest_calculation')
      DashboardSessionModel? latestCalculation,
      @JsonKey(name: 'top_recommendation')
      DashboardTopCompanyModel? topRecommendation,
      @JsonKey(name: 'top_5_companies')
      List<DashboardTopCompanyModel> top5Companies,
      DashboardSummaryModel summary,
      @JsonKey(name: 'recent_activity')
      List<DashboardSessionModel> recentActivity});

  @override
  $DashboardUserModelCopyWith<$Res> get user;
  @override
  $DashboardSessionModelCopyWith<$Res>? get latestCalculation;
  @override
  $DashboardTopCompanyModelCopyWith<$Res>? get topRecommendation;
  @override
  $DashboardSummaryModelCopyWith<$Res> get summary;
}

/// @nodoc
class __$$DashboardResponseModelImplCopyWithImpl<$Res>
    extends _$DashboardResponseModelCopyWithImpl<$Res,
        _$DashboardResponseModelImpl>
    implements _$$DashboardResponseModelImplCopyWith<$Res> {
  __$$DashboardResponseModelImplCopyWithImpl(
      _$DashboardResponseModelImpl _value,
      $Res Function(_$DashboardResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? latestCalculation = freezed,
    Object? topRecommendation = freezed,
    Object? top5Companies = null,
    Object? summary = null,
    Object? recentActivity = null,
  }) {
    return _then(_$DashboardResponseModelImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as DashboardUserModel,
      latestCalculation: freezed == latestCalculation
          ? _value.latestCalculation
          : latestCalculation // ignore: cast_nullable_to_non_nullable
              as DashboardSessionModel?,
      topRecommendation: freezed == topRecommendation
          ? _value.topRecommendation
          : topRecommendation // ignore: cast_nullable_to_non_nullable
              as DashboardTopCompanyModel?,
      top5Companies: null == top5Companies
          ? _value._top5Companies
          : top5Companies // ignore: cast_nullable_to_non_nullable
              as List<DashboardTopCompanyModel>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as DashboardSummaryModel,
      recentActivity: null == recentActivity
          ? _value._recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as List<DashboardSessionModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardResponseModelImpl implements _DashboardResponseModel {
  const _$DashboardResponseModelImpl(
      {required this.user,
      @JsonKey(name: 'latest_calculation') this.latestCalculation,
      @JsonKey(name: 'top_recommendation') this.topRecommendation,
      @JsonKey(name: 'top_5_companies')
      final List<DashboardTopCompanyModel> top5Companies = const [],
      required this.summary,
      @JsonKey(name: 'recent_activity')
      final List<DashboardSessionModel> recentActivity = const []})
      : _top5Companies = top5Companies,
        _recentActivity = recentActivity;

  factory _$DashboardResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardResponseModelImplFromJson(json);

  @override
  final DashboardUserModel user;
  @override
  @JsonKey(name: 'latest_calculation')
  final DashboardSessionModel? latestCalculation;
  @override
  @JsonKey(name: 'top_recommendation')
  final DashboardTopCompanyModel? topRecommendation;
  final List<DashboardTopCompanyModel> _top5Companies;
  @override
  @JsonKey(name: 'top_5_companies')
  List<DashboardTopCompanyModel> get top5Companies {
    if (_top5Companies is EqualUnmodifiableListView) return _top5Companies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_top5Companies);
  }

  @override
  final DashboardSummaryModel summary;
  final List<DashboardSessionModel> _recentActivity;
  @override
  @JsonKey(name: 'recent_activity')
  List<DashboardSessionModel> get recentActivity {
    if (_recentActivity is EqualUnmodifiableListView) return _recentActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentActivity);
  }

  @override
  String toString() {
    return 'DashboardResponseModel(user: $user, latestCalculation: $latestCalculation, topRecommendation: $topRecommendation, top5Companies: $top5Companies, summary: $summary, recentActivity: $recentActivity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardResponseModelImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.latestCalculation, latestCalculation) ||
                other.latestCalculation == latestCalculation) &&
            (identical(other.topRecommendation, topRecommendation) ||
                other.topRecommendation == topRecommendation) &&
            const DeepCollectionEquality()
                .equals(other._top5Companies, _top5Companies) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._recentActivity, _recentActivity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      user,
      latestCalculation,
      topRecommendation,
      const DeepCollectionEquality().hash(_top5Companies),
      summary,
      const DeepCollectionEquality().hash(_recentActivity));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardResponseModelImplCopyWith<_$DashboardResponseModelImpl>
      get copyWith => __$$DashboardResponseModelImplCopyWithImpl<
          _$DashboardResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardResponseModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardResponseModel implements DashboardResponseModel {
  const factory _DashboardResponseModel(
          {required final DashboardUserModel user,
          @JsonKey(name: 'latest_calculation')
          final DashboardSessionModel? latestCalculation,
          @JsonKey(name: 'top_recommendation')
          final DashboardTopCompanyModel? topRecommendation,
          @JsonKey(name: 'top_5_companies')
          final List<DashboardTopCompanyModel> top5Companies,
          required final DashboardSummaryModel summary,
          @JsonKey(name: 'recent_activity')
          final List<DashboardSessionModel> recentActivity}) =
      _$DashboardResponseModelImpl;

  factory _DashboardResponseModel.fromJson(Map<String, dynamic> json) =
      _$DashboardResponseModelImpl.fromJson;

  @override
  DashboardUserModel get user;
  @override
  @JsonKey(name: 'latest_calculation')
  DashboardSessionModel? get latestCalculation;
  @override
  @JsonKey(name: 'top_recommendation')
  DashboardTopCompanyModel? get topRecommendation;
  @override
  @JsonKey(name: 'top_5_companies')
  List<DashboardTopCompanyModel> get top5Companies;
  @override
  DashboardSummaryModel get summary;
  @override
  @JsonKey(name: 'recent_activity')
  List<DashboardSessionModel> get recentActivity;
  @override
  @JsonKey(ignore: true)
  _$$DashboardResponseModelImplCopyWith<_$DashboardResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DashboardTopCompanyModel _$DashboardTopCompanyModelFromJson(
    Map<String, dynamic> json) {
  return _DashboardTopCompanyModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardTopCompanyModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  @JsonKey(name: 'optimization_value')
  double get optimizationValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardTopCompanyModelCopyWith<DashboardTopCompanyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardTopCompanyModelCopyWith<$Res> {
  factory $DashboardTopCompanyModelCopyWith(DashboardTopCompanyModel value,
          $Res Function(DashboardTopCompanyModel) then) =
      _$DashboardTopCompanyModelCopyWithImpl<$Res, DashboardTopCompanyModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      int rank,
      @JsonKey(name: 'optimization_value') double optimizationValue});
}

/// @nodoc
class _$DashboardTopCompanyModelCopyWithImpl<$Res,
        $Val extends DashboardTopCompanyModel>
    implements $DashboardTopCompanyModelCopyWith<$Res> {
  _$DashboardTopCompanyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rank = null,
    Object? optimizationValue = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      optimizationValue: null == optimizationValue
          ? _value.optimizationValue
          : optimizationValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardTopCompanyModelImplCopyWith<$Res>
    implements $DashboardTopCompanyModelCopyWith<$Res> {
  factory _$$DashboardTopCompanyModelImplCopyWith(
          _$DashboardTopCompanyModelImpl value,
          $Res Function(_$DashboardTopCompanyModelImpl) then) =
      __$$DashboardTopCompanyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      int rank,
      @JsonKey(name: 'optimization_value') double optimizationValue});
}

/// @nodoc
class __$$DashboardTopCompanyModelImplCopyWithImpl<$Res>
    extends _$DashboardTopCompanyModelCopyWithImpl<$Res,
        _$DashboardTopCompanyModelImpl>
    implements _$$DashboardTopCompanyModelImplCopyWith<$Res> {
  __$$DashboardTopCompanyModelImplCopyWithImpl(
      _$DashboardTopCompanyModelImpl _value,
      $Res Function(_$DashboardTopCompanyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rank = null,
    Object? optimizationValue = null,
  }) {
    return _then(_$DashboardTopCompanyModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      optimizationValue: null == optimizationValue
          ? _value.optimizationValue
          : optimizationValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardTopCompanyModelImpl implements _DashboardTopCompanyModel {
  const _$DashboardTopCompanyModelImpl(
      {required this.id,
      required this.name,
      required this.rank,
      @JsonKey(name: 'optimization_value') required this.optimizationValue});

  factory _$DashboardTopCompanyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardTopCompanyModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int rank;
  @override
  @JsonKey(name: 'optimization_value')
  final double optimizationValue;

  @override
  String toString() {
    return 'DashboardTopCompanyModel(id: $id, name: $name, rank: $rank, optimizationValue: $optimizationValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardTopCompanyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.optimizationValue, optimizationValue) ||
                other.optimizationValue == optimizationValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, rank, optimizationValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardTopCompanyModelImplCopyWith<_$DashboardTopCompanyModelImpl>
      get copyWith => __$$DashboardTopCompanyModelImplCopyWithImpl<
          _$DashboardTopCompanyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardTopCompanyModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardTopCompanyModel implements DashboardTopCompanyModel {
  const factory _DashboardTopCompanyModel(
          {required final int id,
          required final String name,
          required final int rank,
          @JsonKey(name: 'optimization_value')
          required final double optimizationValue}) =
      _$DashboardTopCompanyModelImpl;

  factory _DashboardTopCompanyModel.fromJson(Map<String, dynamic> json) =
      _$DashboardTopCompanyModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get rank;
  @override
  @JsonKey(name: 'optimization_value')
  double get optimizationValue;
  @override
  @JsonKey(ignore: true)
  _$$DashboardTopCompanyModelImplCopyWith<_$DashboardTopCompanyModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DashboardUserModel _$DashboardUserModelFromJson(Map<String, dynamic> json) {
  return _DashboardUserModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardUserModel {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String? get photoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardUserModelCopyWith<DashboardUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardUserModelCopyWith<$Res> {
  factory $DashboardUserModelCopyWith(
          DashboardUserModel value, $Res Function(DashboardUserModel) then) =
      _$DashboardUserModelCopyWithImpl<$Res, DashboardUserModel>;
  @useResult
  $Res call(
      {String name,
      String email,
      @JsonKey(name: 'photo_url') String? photoUrl});
}

/// @nodoc
class _$DashboardUserModelCopyWithImpl<$Res, $Val extends DashboardUserModel>
    implements $DashboardUserModelCopyWith<$Res> {
  _$DashboardUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardUserModelImplCopyWith<$Res>
    implements $DashboardUserModelCopyWith<$Res> {
  factory _$$DashboardUserModelImplCopyWith(_$DashboardUserModelImpl value,
          $Res Function(_$DashboardUserModelImpl) then) =
      __$$DashboardUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String email,
      @JsonKey(name: 'photo_url') String? photoUrl});
}

/// @nodoc
class __$$DashboardUserModelImplCopyWithImpl<$Res>
    extends _$DashboardUserModelCopyWithImpl<$Res, _$DashboardUserModelImpl>
    implements _$$DashboardUserModelImplCopyWith<$Res> {
  __$$DashboardUserModelImplCopyWithImpl(_$DashboardUserModelImpl _value,
      $Res Function(_$DashboardUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? photoUrl = freezed,
  }) {
    return _then(_$DashboardUserModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardUserModelImpl implements _DashboardUserModel {
  const _$DashboardUserModelImpl(
      {required this.name,
      required this.email,
      @JsonKey(name: 'photo_url') this.photoUrl});

  factory _$DashboardUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardUserModelImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;

  @override
  String toString() {
    return 'DashboardUserModel(name: $name, email: $email, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardUserModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, photoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardUserModelImplCopyWith<_$DashboardUserModelImpl> get copyWith =>
      __$$DashboardUserModelImplCopyWithImpl<_$DashboardUserModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardUserModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardUserModel implements DashboardUserModel {
  const factory _DashboardUserModel(
          {required final String name,
          required final String email,
          @JsonKey(name: 'photo_url') final String? photoUrl}) =
      _$DashboardUserModelImpl;

  factory _DashboardUserModel.fromJson(Map<String, dynamic> json) =
      _$DashboardUserModelImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @override
  @JsonKey(ignore: true)
  _$$DashboardUserModelImplCopyWith<_$DashboardUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardSummaryModel _$DashboardSummaryModelFromJson(
    Map<String, dynamic> json) {
  return _DashboardSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardSummaryModel {
  @JsonKey(name: 'my_internships_count')
  int get myInternshipsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'global_stats')
  DashboardGlobalStatsModel get globalStats =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardSummaryModelCopyWith<DashboardSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSummaryModelCopyWith<$Res> {
  factory $DashboardSummaryModelCopyWith(DashboardSummaryModel value,
          $Res Function(DashboardSummaryModel) then) =
      _$DashboardSummaryModelCopyWithImpl<$Res, DashboardSummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'my_internships_count') int myInternshipsCount,
      @JsonKey(name: 'global_stats') DashboardGlobalStatsModel globalStats});

  $DashboardGlobalStatsModelCopyWith<$Res> get globalStats;
}

/// @nodoc
class _$DashboardSummaryModelCopyWithImpl<$Res,
        $Val extends DashboardSummaryModel>
    implements $DashboardSummaryModelCopyWith<$Res> {
  _$DashboardSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myInternshipsCount = null,
    Object? globalStats = null,
  }) {
    return _then(_value.copyWith(
      myInternshipsCount: null == myInternshipsCount
          ? _value.myInternshipsCount
          : myInternshipsCount // ignore: cast_nullable_to_non_nullable
              as int,
      globalStats: null == globalStats
          ? _value.globalStats
          : globalStats // ignore: cast_nullable_to_non_nullable
              as DashboardGlobalStatsModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardGlobalStatsModelCopyWith<$Res> get globalStats {
    return $DashboardGlobalStatsModelCopyWith<$Res>(_value.globalStats,
        (value) {
      return _then(_value.copyWith(globalStats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardSummaryModelImplCopyWith<$Res>
    implements $DashboardSummaryModelCopyWith<$Res> {
  factory _$$DashboardSummaryModelImplCopyWith(
          _$DashboardSummaryModelImpl value,
          $Res Function(_$DashboardSummaryModelImpl) then) =
      __$$DashboardSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'my_internships_count') int myInternshipsCount,
      @JsonKey(name: 'global_stats') DashboardGlobalStatsModel globalStats});

  @override
  $DashboardGlobalStatsModelCopyWith<$Res> get globalStats;
}

/// @nodoc
class __$$DashboardSummaryModelImplCopyWithImpl<$Res>
    extends _$DashboardSummaryModelCopyWithImpl<$Res,
        _$DashboardSummaryModelImpl>
    implements _$$DashboardSummaryModelImplCopyWith<$Res> {
  __$$DashboardSummaryModelImplCopyWithImpl(_$DashboardSummaryModelImpl _value,
      $Res Function(_$DashboardSummaryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myInternshipsCount = null,
    Object? globalStats = null,
  }) {
    return _then(_$DashboardSummaryModelImpl(
      myInternshipsCount: null == myInternshipsCount
          ? _value.myInternshipsCount
          : myInternshipsCount // ignore: cast_nullable_to_non_nullable
              as int,
      globalStats: null == globalStats
          ? _value.globalStats
          : globalStats // ignore: cast_nullable_to_non_nullable
              as DashboardGlobalStatsModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSummaryModelImpl implements _DashboardSummaryModel {
  const _$DashboardSummaryModelImpl(
      {@JsonKey(name: 'my_internships_count') required this.myInternshipsCount,
      @JsonKey(name: 'global_stats') required this.globalStats});

  factory _$DashboardSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'my_internships_count')
  final int myInternshipsCount;
  @override
  @JsonKey(name: 'global_stats')
  final DashboardGlobalStatsModel globalStats;

  @override
  String toString() {
    return 'DashboardSummaryModel(myInternshipsCount: $myInternshipsCount, globalStats: $globalStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSummaryModelImpl &&
            (identical(other.myInternshipsCount, myInternshipsCount) ||
                other.myInternshipsCount == myInternshipsCount) &&
            (identical(other.globalStats, globalStats) ||
                other.globalStats == globalStats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, myInternshipsCount, globalStats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSummaryModelImplCopyWith<_$DashboardSummaryModelImpl>
      get copyWith => __$$DashboardSummaryModelImplCopyWithImpl<
          _$DashboardSummaryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardSummaryModel implements DashboardSummaryModel {
  const factory _DashboardSummaryModel(
          {@JsonKey(name: 'my_internships_count')
          required final int myInternshipsCount,
          @JsonKey(name: 'global_stats')
          required final DashboardGlobalStatsModel globalStats}) =
      _$DashboardSummaryModelImpl;

  factory _DashboardSummaryModel.fromJson(Map<String, dynamic> json) =
      _$DashboardSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'my_internships_count')
  int get myInternshipsCount;
  @override
  @JsonKey(name: 'global_stats')
  DashboardGlobalStatsModel get globalStats;
  @override
  @JsonKey(ignore: true)
  _$$DashboardSummaryModelImplCopyWith<_$DashboardSummaryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DashboardGlobalStatsModel _$DashboardGlobalStatsModelFromJson(
    Map<String, dynamic> json) {
  return _DashboardGlobalStatsModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardGlobalStatsModel {
  @JsonKey(name: 'total_global_companies')
  int get totalGlobalCompanies => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sectors')
  int get totalSectors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardGlobalStatsModelCopyWith<DashboardGlobalStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardGlobalStatsModelCopyWith<$Res> {
  factory $DashboardGlobalStatsModelCopyWith(DashboardGlobalStatsModel value,
          $Res Function(DashboardGlobalStatsModel) then) =
      _$DashboardGlobalStatsModelCopyWithImpl<$Res, DashboardGlobalStatsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_global_companies') int totalGlobalCompanies,
      @JsonKey(name: 'total_sectors') int totalSectors});
}

/// @nodoc
class _$DashboardGlobalStatsModelCopyWithImpl<$Res,
        $Val extends DashboardGlobalStatsModel>
    implements $DashboardGlobalStatsModelCopyWith<$Res> {
  _$DashboardGlobalStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGlobalCompanies = null,
    Object? totalSectors = null,
  }) {
    return _then(_value.copyWith(
      totalGlobalCompanies: null == totalGlobalCompanies
          ? _value.totalGlobalCompanies
          : totalGlobalCompanies // ignore: cast_nullable_to_non_nullable
              as int,
      totalSectors: null == totalSectors
          ? _value.totalSectors
          : totalSectors // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardGlobalStatsModelImplCopyWith<$Res>
    implements $DashboardGlobalStatsModelCopyWith<$Res> {
  factory _$$DashboardGlobalStatsModelImplCopyWith(
          _$DashboardGlobalStatsModelImpl value,
          $Res Function(_$DashboardGlobalStatsModelImpl) then) =
      __$$DashboardGlobalStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_global_companies') int totalGlobalCompanies,
      @JsonKey(name: 'total_sectors') int totalSectors});
}

/// @nodoc
class __$$DashboardGlobalStatsModelImplCopyWithImpl<$Res>
    extends _$DashboardGlobalStatsModelCopyWithImpl<$Res,
        _$DashboardGlobalStatsModelImpl>
    implements _$$DashboardGlobalStatsModelImplCopyWith<$Res> {
  __$$DashboardGlobalStatsModelImplCopyWithImpl(
      _$DashboardGlobalStatsModelImpl _value,
      $Res Function(_$DashboardGlobalStatsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGlobalCompanies = null,
    Object? totalSectors = null,
  }) {
    return _then(_$DashboardGlobalStatsModelImpl(
      totalGlobalCompanies: null == totalGlobalCompanies
          ? _value.totalGlobalCompanies
          : totalGlobalCompanies // ignore: cast_nullable_to_non_nullable
              as int,
      totalSectors: null == totalSectors
          ? _value.totalSectors
          : totalSectors // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardGlobalStatsModelImpl implements _DashboardGlobalStatsModel {
  const _$DashboardGlobalStatsModelImpl(
      {@JsonKey(name: 'total_global_companies')
      required this.totalGlobalCompanies,
      @JsonKey(name: 'total_sectors') required this.totalSectors});

  factory _$DashboardGlobalStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardGlobalStatsModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_global_companies')
  final int totalGlobalCompanies;
  @override
  @JsonKey(name: 'total_sectors')
  final int totalSectors;

  @override
  String toString() {
    return 'DashboardGlobalStatsModel(totalGlobalCompanies: $totalGlobalCompanies, totalSectors: $totalSectors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardGlobalStatsModelImpl &&
            (identical(other.totalGlobalCompanies, totalGlobalCompanies) ||
                other.totalGlobalCompanies == totalGlobalCompanies) &&
            (identical(other.totalSectors, totalSectors) ||
                other.totalSectors == totalSectors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalGlobalCompanies, totalSectors);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardGlobalStatsModelImplCopyWith<_$DashboardGlobalStatsModelImpl>
      get copyWith => __$$DashboardGlobalStatsModelImplCopyWithImpl<
          _$DashboardGlobalStatsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardGlobalStatsModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardGlobalStatsModel implements DashboardGlobalStatsModel {
  const factory _DashboardGlobalStatsModel(
          {@JsonKey(name: 'total_global_companies')
          required final int totalGlobalCompanies,
          @JsonKey(name: 'total_sectors') required final int totalSectors}) =
      _$DashboardGlobalStatsModelImpl;

  factory _DashboardGlobalStatsModel.fromJson(Map<String, dynamic> json) =
      _$DashboardGlobalStatsModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_global_companies')
  int get totalGlobalCompanies;
  @override
  @JsonKey(name: 'total_sectors')
  int get totalSectors;
  @override
  @JsonKey(ignore: true)
  _$$DashboardGlobalStatsModelImplCopyWith<_$DashboardGlobalStatsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DashboardSessionModel _$DashboardSessionModelFromJson(
    Map<String, dynamic> json) {
  return _DashboardSessionModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardSessionModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardSessionModelCopyWith<DashboardSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSessionModelCopyWith<$Res> {
  factory $DashboardSessionModelCopyWith(DashboardSessionModel value,
          $Res Function(DashboardSessionModel) then) =
      _$DashboardSessionModelCopyWithImpl<$Res, DashboardSessionModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$DashboardSessionModelCopyWithImpl<$Res,
        $Val extends DashboardSessionModel>
    implements $DashboardSessionModelCopyWith<$Res> {
  _$DashboardSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardSessionModelImplCopyWith<$Res>
    implements $DashboardSessionModelCopyWith<$Res> {
  factory _$$DashboardSessionModelImplCopyWith(
          _$DashboardSessionModelImpl value,
          $Res Function(_$DashboardSessionModelImpl) then) =
      __$$DashboardSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$$DashboardSessionModelImplCopyWithImpl<$Res>
    extends _$DashboardSessionModelCopyWithImpl<$Res,
        _$DashboardSessionModelImpl>
    implements _$$DashboardSessionModelImplCopyWith<$Res> {
  __$$DashboardSessionModelImplCopyWithImpl(_$DashboardSessionModelImpl _value,
      $Res Function(_$DashboardSessionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DashboardSessionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSessionModelImpl implements _DashboardSessionModel {
  const _$DashboardSessionModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt});

  factory _$DashboardSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSessionModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DashboardSessionModel(id: $id, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSessionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSessionModelImplCopyWith<_$DashboardSessionModelImpl>
      get copyWith => __$$DashboardSessionModelImplCopyWithImpl<
          _$DashboardSessionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSessionModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardSessionModel implements DashboardSessionModel {
  const factory _DashboardSessionModel(
          {required final int id,
          @JsonKey(name: 'user_id') required final int userId,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'updated_at') required final DateTime updatedAt}) =
      _$DashboardSessionModelImpl;

  factory _DashboardSessionModel.fromJson(Map<String, dynamic> json) =
      _$DashboardSessionModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DashboardSessionModelImplCopyWith<_$DashboardSessionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
