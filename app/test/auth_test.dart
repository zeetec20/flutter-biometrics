import 'dart:convert';

import 'package:app/repository/user_repository.dart';
import 'package:app/service/auth_service.dart';
import 'package:app/utils/auth_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'auth_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  MockUserRepository userRepository = MockUserRepository();
  AuthService authService = AuthService(userRepository);

  group('login', () {
    test('login, successfuly', () async {
      http.Response resLogin = http.Response(
          jsonEncode({
            'success': true,
            'data': {'token': '', 'expired': ''}
          }),
          200);
      http.Response resProfile = http.Response(
          jsonEncode({'id': 0, 'name': '', 'email': '', 'use_biometrics': 0}),
          200);
      when(userRepository.login('email', 'password'))
          .thenAnswer((_) async => resLogin);
      when(userRepository.profile(jsonDecode(resLogin.body)['data']['token']))
          .thenAnswer((_) async => resProfile);

      AuthResult result = await authService.login('email', 'password');

      expect(result.message, isNull);
      expect(result.success, isTrue);
      expect(result.user, isNotNull);
    });

    test('login, failed cause user and password incorrect', () async {
      http.Response resLogin = http.Response(
          jsonEncode(
              {'success': false, 'message': 'email or password incorrect'}),
          200);
      when(userRepository.login('email', 'password'))
          .thenAnswer((_) async => resLogin);

      AuthResult result = await authService.login('email', 'password');

      expect(result.message, isNotNull);
      expect(result.success, isFalse);
      expect(result.user, isNull);
    });
  });

  group('register', () {
    test('register, successfuly', () async {
      http.Response res = http.Response(jsonEncode({'success': true}), 200);
      when(userRepository.register('name', 'email', 'password'))
          .thenAnswer((_) async => res);

      AuthResult result =
          await authService.register('name', 'email', 'password');

      expect(result.success, isTrue);
      expect(result.message, equals('Register success'));
    });

    test('register, failed cause user exist', () async {
      http.Response res = http.Response(
          jsonEncode({'success': false, 'message': 'user already exist'}), 200);
      when(userRepository.register('name', 'email', 'password'))
          .thenAnswer((_) async => res);

      AuthResult result =
          await authService.register('name', 'email', 'password');

      expect(result.success, isFalse);
      expect(result.message, equals('User already exist'));
    });
  });
}
