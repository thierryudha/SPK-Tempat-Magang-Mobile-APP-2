import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';
import '../models/dashboard_models.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final _dataSource = DashboardRemoteDataSource();

  @override
  Future<DashboardResponseModel> getDashboardData() => _dataSource.getDashboardData();
}
