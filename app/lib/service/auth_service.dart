import 'dart:convert';

import 'package:app/model/User.dart';
import 'package:app/utils/auth_result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  Future<AuthResult> login(String email, String password) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${dotenv.env['API_URL']!}/api/login'),
          body: {'email': email, 'password': password});
      Map json = jsonDecode(response.body);
      http.Response responseProfile = await http.get(
          Uri.parse('${dotenv.env['API_URL']!}/api/profile'),
          headers: {'Authorization': 'Bearer ${json['data']['token']}'});
      Map profileJson = jsonDecode(responseProfile.body);

      User user = User(
          id: profileJson['id'],
          name: profileJson['name'],
          email: email,
          useBiometrics: profileJson['use_biometrics'] == 1,
          token: json['data']['token']);
      if (json['success']) return AuthResult(true, user: user);
    } catch (e) {
      return AuthResult(false,
          message: 'Failed sign in, something wrong on system');
    }
    return AuthResult(false, message: 'Email or password incorrect');
  }

  Future<AuthResult> register(
      String name, String email, String password) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${dotenv.env['API_URL']!}/api/register'),
          body: {'name': name, 'email': email, 'password': password});
      print(response.body);
      Map json = jsonDecode(response.body) as Map;
      if (json['success']) return AuthResult(true);
    } catch (e) {
      print(e);
      return AuthResult(false,
          message: 'Failed sign up, something wrong on system');
    }
    return AuthResult(false, message: 'User already exist');
  }
}
