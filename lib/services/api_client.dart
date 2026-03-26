import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Client untuk berkomunikasi dengan backend
class ApiClient {
  static const String _baseUrl = 'http://localhost:3000/api';

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;
  ApiClient._internal();

  /// Login endpoint
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': username, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        return {'success': false, 'message': 'Username atau password salah'};
      } else {
        return {'success': false, 'message': 'Error server'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Koneksi gagal. Pastikan backend berjalan di localhost:3000',
        'error': e.toString(),
      };
    }
  }

  /// Register endpoint
  Future<Map<String, dynamic>> register(
    String username,
    String password, {
    String? email,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'password': password,
              if (email != null) 'email': email,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 409) {
        return {'success': false, 'message': 'Username sudah terdaftar'};
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'] ?? 'Error server',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Koneksi gagal. Pastikan backend berjalan di localhost:3000',
        'error': e.toString(),
      };
    }
  }

  /// Health check
  Future<bool> healthCheck() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/health'))
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
