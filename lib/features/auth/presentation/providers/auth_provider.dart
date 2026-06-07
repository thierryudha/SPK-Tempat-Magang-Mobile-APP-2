import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    try {
      final user = await ref.read(authRepositoryProvider).login(email: email, password: password);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> googleLogin() async {
    state = const AsyncLoading();
    try {
      // API v7.x: gunakan GoogleSignIn.instance dan authenticate()
      final googleUser = await GoogleSignIn.instance.authenticate();

      if (googleUser == null) {
        // User membatalkan login
        state = const AsyncData(null);
        return;
      }

      final user = await ref.read(authRepositoryProvider).googleLogin(
            email: googleUser.email,
            name: googleUser.displayName ?? googleUser.email,
            googleId: googleUser.id,
          );
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
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

  Future<void> updateProfile({
    required String name,
    required String email,
    String? photoPath,
  }) async {
    final updatedUser = await ref.read(authRepositoryProvider).updateProfile(
          name: name,
          email: email,
          photoPath: photoPath,
        );
    // Langsung update state user yang sedang aktif
    state = AsyncData(updatedUser);
  }

  Future<String> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await ref.read(authRepositoryProvider).changePassword(
          currentPassword: currentPassword,
          password: password,
          passwordConfirmation: passwordConfirmation,
        );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(AuthNotifier.new);
