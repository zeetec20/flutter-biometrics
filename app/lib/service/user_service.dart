import 'dart:convert';

import 'package:app/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  Future<User> profile(String token) async {
    http.Response response = await http.get(
      Uri.parse('${dotenv.env['API_URL']!}/api/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
    print(token);
    print(response.body);
    Map json = jsonDecode(response.body);

    print(json['use_biometrics']);
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        useBiometrics: json['use_biometrics'] == 1,
        token: token);
  }

  Future<bool> setBiometrics(String token) async {
    try {
      http.Response response = await http.post(
        Uri.parse('${dotenv.env['API_URL']!}/api/biometrics'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      return jsonDecode(response.body)['success'];
    } catch (e) {
      return false;
    }
  }
}
