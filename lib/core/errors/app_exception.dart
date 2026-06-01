class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException({required super.message, super.statusCode});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException()
      : super(message: 'Sesi berakhir. Silakan login kembali.', statusCode: 401);
}

class ValidationException extends AppException {
  final Map<String, dynamic>? errors;

  const ValidationException({
    required super.message,
    this.errors,
    super.statusCode = 422,
  });
}

class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}
