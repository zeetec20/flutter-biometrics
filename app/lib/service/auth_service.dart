import 'dart:convert';

import 'package:app/model/User.dart';
import 'package:app/repository/user_repository.dart';
import 'package:app/utils/auth_result.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final UserRepository userRepository;

  AuthService(this.userRepository);

  Future<AuthResult> login(String email, String password) async {
    try {
      http.Response response = await userRepository.login(email, password);
      Map json = jsonDecode(response.body);
      if (!json['success'])
        return AuthResult(false, message: 'Email or password incorrect');
      http.Response responseProfile =
          await userRepository.profile(json['data']['token']);
      Map profileJson = jsonDecode(responseProfile.body);

      User user = User(
          id: profileJson['id'],
          name: profileJson['name'],
          email: email,
          useBiometrics: profileJson['use_biometrics'] == 1,
          token: json['data']['token']);
      return AuthResult(true, user: user);
    } catch (e) {
      return AuthResult(false, message: e.toString());
    }
  }

  Future<AuthResult> register(
      String name, String email, String password) async {
    try {
      http.Response response =
          await userRepository.register(name, email, password);
      Map json = jsonDecode(response.body) as Map;

      if (json['success']) return AuthResult(true, message: 'Register success');
    } catch (e) {
      return AuthResult(false,
          message: 'Failed sign up, something wrong on system');
    }
    return AuthResult(false, message: 'User already exist');
  }
}
