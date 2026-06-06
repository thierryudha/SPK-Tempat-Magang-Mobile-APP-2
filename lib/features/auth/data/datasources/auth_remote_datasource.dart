import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio _dio = DioClient.instance;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
          'device_name': 'flutter_app',
        },
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'device_name': 'flutter_app',
        },
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.forgotPassword,
        data: {
          'email': email,
        },
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }

  Future<UserModel> getMe() async {
    try {
      final response = await _dio.get(ApiConstants.me);
      final data = response.data as Map<String, dynamic>;
      return UserModel.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioClient.extractException(e);
    }
  }
}
