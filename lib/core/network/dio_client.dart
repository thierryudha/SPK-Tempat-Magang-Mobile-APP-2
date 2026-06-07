import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../errors/app_exception.dart';
import '../storage/secure_storage_service.dart';

class DioClient {
  DioClient._();

  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SecureStorageService.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        final appException = _handleError(error);
        return handler.reject(
          DioException(
            requestOptions: error.requestOptions,
            error: appException,
            message: appException.message,
          ),
        );
      },
    ));

    return dio;
  }

  static AppException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkException(message: 'Yah, gagal connect. Coba periksa jaringan.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        if (statusCode == 401) return const UnauthorizedException();
        if (statusCode == 422) {
          final message = data?['message'] ?? 'Validasi gagal.';
          final errors = data?['errors'];
          return ValidationException(message: message, errors: errors);
        }
        final message = data?['message'] ?? 'Kesalahan pada server.';
        return NetworkException(message: message, statusCode: statusCode);
      case DioExceptionType.connectionError:
        return const NetworkException(
            message: 'Tidak dapat terhubung. Pastikan backend sudah running.');
      default:
        return const NetworkException(message: 'Terjadi kesalahan yang tidak diketahui.');
    }
  }

  // Helper: ekstrak AppException dari DioException
  static AppException extractException(DioException e) {
    if (e.error is AppException) return e.error as AppException;
    return NetworkException(message: e.message ?? 'Unknown error');
  }
}
