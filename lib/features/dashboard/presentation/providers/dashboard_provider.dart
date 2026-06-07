import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../data/models/dashboard_models.dart';

part 'dashboard_provider.g.dart';

@riverpod
DashboardRepositoryImpl dashboardRepository(DashboardRepositoryRef ref) {
  return DashboardRepositoryImpl();
}

@riverpod
Future<DashboardResponseModel> dashboardData(DashboardDataRef ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.getDashboardData();
}
