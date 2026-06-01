import '../../../../core/storage/secure_storage_service.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepository {
  final _dataSource = AuthRemoteDataSource();

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final data = await _dataSource.login(email: email, password: password);
    final token = data['token'] as String;
    await SecureStorageService.saveToken(token);
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<void> logout() async {
    try {
      await _dataSource.logout();
    } finally {
      // Selalu hapus token lokal meski request gagal
      await SecureStorageService.deleteToken();
    }
  }

  Future<UserModel> getMe() async {
    return await _dataSource.getMe();
  }
}
