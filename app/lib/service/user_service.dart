import 'dart:convert';

import 'package:app/model/User.dart';
import 'package:app/repository/user_repository.dart';
import 'package:app/service/biometrics_service.dart';
import 'package:app/utils/biometrics_result.dart';
import 'package:http/http.dart' as http;

class UserService {
  final UserRepository userRepository;

  UserService(this.userRepository);

  Future<User?> profile(String token) async {
    try {
      http.Response response = await userRepository.profile(token);
      Map json = jsonDecode(response.body);

      return User(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          useBiometrics: json['use_biometrics'] == 1,
          token: token);
    } catch (e) {
      return null;
    }
  }

  Future<BiometricsResult> setBiometrics(String token) async {
    try {
      await userRepository.biometrics(token);

      return BiometricsResult(true);
    } catch (e) {
      return BiometricsResult(false, message: 'Something wrong with system');
    }
  }
}
