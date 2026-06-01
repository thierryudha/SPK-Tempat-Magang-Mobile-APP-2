import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/moora_models.dart';

class MooraRemoteDataSource {
  final Dio _dio = DioClient.instance;

  Future<List<CriteriaModel>> getCriterias() async {
    try {
      final response = await _dio.get(ApiConstants.criterias);
      final data = response.data as Map<String, dynamic>;
      final list = data['data'] as List<dynamic>;
      return list
          .map((e) => CriteriaModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  /// Returns map: { "criteria_id": weight_value }
  Future<Map<String, double>> getWeights() async {
    try {
      final response = await _dio.get(ApiConstants.weights);
      final data = response.data as Map<String, dynamic>;
      final raw = data['data'] as Map<String, dynamic>? ?? {};
      return raw.map((k, v) => MapEntry(k, (v as num).toDouble()));
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<List<MooraResultModel>> calculate(CalculateRequestModel payload) async {
    try {
      final response = await _dio.post(
        ApiConstants.calculate,
        data: payload.toJson(),
      );
      final data = response.data as Map<String, dynamic>;
      final list = data['data'] as List<dynamic>;
      return list
          .map((e) => MooraResultModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }
}
