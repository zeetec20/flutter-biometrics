import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRepository {
  Future<http.Response> login(String email, String password) {
    return http.post(Uri.parse('${dotenv.env['API_URL']!}/api/login'),
        body: {'email': email, 'password': password});
  }

  Future<http.Response> register(String name, String email, String password) {
    return http.post(Uri.parse('${dotenv.env['API_URL']!}/api/register'),
        body: {'name': name, 'email': email, 'password': password});
  }

  Future<http.Response> profile(String token) {
    return http.get(Uri.parse('${dotenv.env['API_URL']!}/api/profile'),
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<http.Response> biometrics(String token) {
    return http.post(
      Uri.parse('${dotenv.env['API_URL']!}/api/biometrics'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
