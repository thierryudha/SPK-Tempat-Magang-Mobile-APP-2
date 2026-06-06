import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

// Provider untuk repository
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

// State untuk current user
class AuthNotifier extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    // Coba fetch user saat pertama kali (untuk splash screen)
    try {
      return await ref.read(authRepositoryProvider).getMe();
    } catch (_) {
      return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(email: email, password: password),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    // Kita tidak mengupdate state user di sini karena akan di-redirect ke login
    await ref.read(authRepositoryProvider).register(
          name: name,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
        );
  }

  Future<String> forgotPassword({required String email}) async {
    return await ref.read(authRepositoryProvider).forgotPassword(email: email);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(AuthNotifier.new);
