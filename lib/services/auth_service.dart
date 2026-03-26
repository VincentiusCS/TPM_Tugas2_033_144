import '../models/user.dart';
import 'api_client.dart';

/// Service autentikasi menggunakan Singleton Pattern
/// Terhubung ke backend REST API
class AuthService {
  // ── Singleton ──────────────────────────────────
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();
  // ───────────────────────────────────────────────

  final ApiClient _apiClient = ApiClient();

  User? _currentUser;

  // Getters (Encapsulation)
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  /// Login: kirim kredensial ke backend
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final result = await _apiClient.login(username, password);

      if (result['success'] == true && result['user'] != null) {
        _currentUser = User(
          username: result['user']['username'],
          password: password,
        );
        return {
          'success': true,
          'message': result['message'] ?? 'Login berhasil',
        };
      } else {
        return {
          'success': false,
          'message': result['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Register: kirim data registrasi ke backend
  Future<Map<String, dynamic>> register(
    String username,
    String password, {
    String? email,
  }) async {
    try {
      final result = await _apiClient.register(
        username,
        password,
        email: email,
      );

      if (result['success'] == true) {
        return {
          'success': true,
          'message': result['message'] ?? 'Registrasi berhasil',
        };
      } else {
        return {
          'success': false,
          'message': result['message'] ?? 'Registrasi gagal',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Logout: hapus sesi
  void logout() {
    _currentUser = null;
  }

  /// Check backend connection
  Future<bool> isBackendAvailable() async {
    return await _apiClient.healthCheck();
  }
}
