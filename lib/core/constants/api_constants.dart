class ApiConstants {
  ApiConstants._();

  // 10.0.2.2 = alias Android Emulator ke host machine (localhost komputer)
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String logout = '/logout';
  static const String me = '/me';
  static const String internships = '/internships';
  static const String criterias = '/criterias';
  static const String weights = '/weights';
  static const String calculate = '/calculate';
}
