import 'api_secrets.dart';

class ApiConstants {
  ApiConstants._();

  // 10.0.2.2 = alias Android Emulator ke host machine (localhost komputer)
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static const String login = '/login';
  static const String googleLogin = '/google-login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String updateProfile = '/profile/update';
  static const String changePassword = '/profile/change-password';
  static const String logout = '/logout';
  static const String me = '/me';
  static const String categories = '/categories';
  static const String internships = '/internships';
  static const String criterias = '/criterias';
  static const String weights = '/weights';
  static const String calculate = '/calculate';

  // Gemini API Key — disimpan di api_secrets.dart (tidak di-commit ke git)
  // Lihat api_secrets.example.dart untuk template
  static const String geminiApiKey = ApiSecrets.geminiApiKey;
}

