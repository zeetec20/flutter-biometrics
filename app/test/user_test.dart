import 'dart:convert';

import 'package:app/model/User.dart';
import 'package:app/repository/user_repository.dart';
import 'package:app/service/user_service.dart';
import 'package:app/utils/auth_result.dart';
import 'package:app/utils/biometrics_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'auth_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  MockUserRepository userRepository = MockUserRepository();
  UserService userService = UserService(userRepository);

  group('profile', () {
    test('profile, successfully', () async {
      http.Response res = http.Response(
          jsonEncode({'id': 0, 'name': '', 'email': '', 'use_biometrics': 0}),
          200);
      when(userRepository.profile('token')).thenAnswer((_) async => res);

      User? result = await userService.profile('token');
      expect(result, isA<User>());
    });

    test('profile, failed', () async {
      when(userRepository.profile('token')).thenThrow(http.ClientException);

      User? result = await userService.profile('token');
      expect(result, isNull);
    });
  });

  group('set biometrics', () {
    test('set biometrics, successfully', () async {
      http.Response res = http.Response(jsonEncode({'success': true}), 200);
      when(userRepository.biometrics('token')).thenAnswer((_) async => res);

      BiometricsResult result = await userService.setBiometrics('token');

      expect(result.success, isTrue);
    });

    test('set biometrics, failed', () async {
      when(userRepository.biometrics('token')).thenThrow(http.ClientException);

      BiometricsResult result = await userService.setBiometrics('token');

      expect(result.success, isFalse);
      expect(result.message, equals('Something wrong with system'));
    });
  });
}
