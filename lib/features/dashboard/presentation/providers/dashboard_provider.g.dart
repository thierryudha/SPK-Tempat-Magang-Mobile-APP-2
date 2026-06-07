// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dashboardRepositoryHash() =>
    r'9d317967f5fff8de043889bd1c77c3eb49c913f5';

/// See also [dashboardRepository].
@ProviderFor(dashboardRepository)
final dashboardRepositoryProvider =
    AutoDisposeProvider<DashboardRepositoryImpl>.internal(
  dashboardRepository,
  name: r'dashboardRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DashboardRepositoryRef
    = AutoDisposeProviderRef<DashboardRepositoryImpl>;
String _$dashboardDataHash() => r'1c753ab1b84b9a7cc1399e260dbb0d682dfa37f7';

/// See also [dashboardData].
@ProviderFor(dashboardData)
final dashboardDataProvider =
    AutoDisposeFutureProvider<DashboardResponseModel>.internal(
  dashboardData,
  name: r'dashboardDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DashboardDataRef = AutoDisposeFutureProviderRef<DashboardResponseModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
