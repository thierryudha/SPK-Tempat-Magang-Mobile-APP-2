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

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(ApiConstants.categories);
      final data = response.data as Map<String, dynamic>;
      final list = data['data'] as List<dynamic>;
      return list
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<InternshipModel> createInternship(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(ApiConstants.internships, data: data);
      final responseData = response.data as Map<String, dynamic>;
      return InternshipModel.fromJson(responseData['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<InternshipModel> updateInternship(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('${ApiConstants.internships}/$id', data: data);
      final responseData = response.data as Map<String, dynamic>;
      return InternshipModel.fromJson(responseData['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<void> deleteInternship(int id) async {
    try {
      await _dio.delete('${ApiConstants.internships}/$id');
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }
}
