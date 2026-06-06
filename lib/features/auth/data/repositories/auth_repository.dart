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

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    await _dataSource.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  Future<String> forgotPassword({required String email}) async {
    final data = await _dataSource.forgotPassword(email: email);
    return data['message'] as String;
  }

  Future<UserModel> updateProfile({
    required String name,
    required String email,
    String? photoPath,
  }) async {
    final data = await _dataSource.updateProfile(
      name: name,
      email: email,
      photoPath: photoPath,
    );
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<String> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    final data = await _dataSource.changePassword(
      currentPassword: currentPassword,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    return data['message'] as String;
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
