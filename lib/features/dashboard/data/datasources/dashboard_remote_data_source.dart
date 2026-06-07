import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/dashboard_models.dart';

class DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSource([Dio? dio])
      : _dio = dio ?? DioClient.instance;

  Future<DashboardResponseModel> getDashboardData() async {
    final response = await _dio.get('/dashboard');
    final responseData = response.data['data'] as Map<String, dynamic>;
    return DashboardResponseModel.fromJson(responseData);
  }
}
