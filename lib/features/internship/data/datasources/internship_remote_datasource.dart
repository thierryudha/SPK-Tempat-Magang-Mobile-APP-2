import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/internship_model.dart';

class InternshipRemoteDataSource {
  final Dio _dio = DioClient.instance;

  Future<List<InternshipModel>> getInternships() async {
    try {
      final response = await _dio.get(ApiConstants.internships);
      final data = response.data as Map<String, dynamic>;
      final list = data['data'] as List<dynamic>;
      return list
          .map((e) => InternshipModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<InternshipModel> getInternshipById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.internships}/$id');
      final data = response.data as Map<String, dynamic>;
      return InternshipModel.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }
}
