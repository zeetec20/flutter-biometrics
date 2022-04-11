import 'dart:convert';

import 'package:app/pages/auth/login.dart';
import 'package:app/provider/app_provider.dart';
import 'package:app/provider/login_provider.dart';
import 'package:app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'login_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  MockUserRepository userRepository = MockUserRepository();
  String emailSample = 'admin@gmail.com';
  String passwordSample = 'admin123';

  Widget makeWidgetTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(
            userRepository,
          ),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(
            userRepository,
          ),
        )
      ],
      builder: (c, child) {
        return MaterialApp(
          home: LoginPage(() {}),
        );
      },
    );
  }

  Finder email = find.byKey(Key('email-field'));
  Finder validateEmail = find.byKey(Key('email-validate-field'));
  Finder password = find.byKey(Key('password-field'));
  Finder validatePassword = find.byKey(Key('password-validate-field'));
  Finder signIn = find.byKey(Key('sign-in-button'));

  group('email field', () {
    testWidgets('email, validate error empty', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, '');
      await tester.tap(signIn);
      await tester.pump();

      expect(validateEmail, findsOneWidget);
      expect(find.text('Email must be filled'), findsOneWidget);
    });

    testWidgets('email, validate error invalid', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, '@gmail');
      await tester.tap(signIn);
      await tester.pump();

      expect(validateEmail, findsOneWidget);
      expect(find.text('Email is invalid'), findsOneWidget);
    });

    testWidgets('email, validate success', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, 'admin@gmail.com');
      await tester.enterText(password, '');
      await tester.tap(signIn);
      await tester.pump();

      expect(validateEmail, findsNothing);
    });
  });

  group('password field', () {
    testWidgets('password, validate error empty', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(password, '');
      await tester.tap(signIn);
      await tester.pump();

      expect(validatePassword, findsOneWidget);
      expect(find.text('Password must be filled'), findsOneWidget);
    });

    testWidgets('password, validate error length less than 8',
        (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(password, 'admin');
      await tester.tap(signIn);
      await tester.pump();

      expect(validatePassword, findsOneWidget);
      expect(find.text('Password length must be 8 character'), findsOneWidget);
    });

    testWidgets('password, validate success', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, '');
      await tester.enterText(password, 'admin123');
      await tester.tap(signIn);
      await tester.pump();

      expect(validatePassword, findsNothing);
    });
  });

  group('login submit', () {
    testWidgets('login success', (WidgetTester tester) async {
      http.Response resLogin = http.Response(
          jsonEncode({
            'success': true,
            'data': {'token': '', 'expired': ''}
          }),
          200);
      http.Response resProfile = http.Response(
          jsonEncode({'id': 0, 'name': '', 'email': '', 'use_biometrics': 0}),
          200);
      when(userRepository.login(emailSample, passwordSample))
          .thenAnswer((_) async => resLogin);
      when(userRepository.profile(jsonDecode(resLogin.body)['data']['token']))
          .thenAnswer((_) async => resProfile);

      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, emailSample);
      await tester.enterText(password, passwordSample);
      await tester.tap(signIn);
      await tester.pump();

      expect(validateEmail, findsNothing);
      expect(validatePassword, findsNothing);
      verify(userRepository.login(emailSample, passwordSample));
      verify(
          userRepository.profile(jsonDecode(resLogin.body)['data']['token']));
    });

    testWidgets('login, failed user or password incorrect',
        (WidgetTester tester) async {
      http.Response resLogin = http.Response(
          jsonEncode(
              {'success': false, 'message': 'email or password incorrect'}),
          200);
      when(userRepository.login(emailSample, passwordSample))
          .thenAnswer((_) async => resLogin);

      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, emailSample);
      await tester.enterText(password, passwordSample);
      await tester.tap(signIn);
      await tester.pump();

      expect(validateEmail, findsNothing);
      expect(validatePassword, findsNothing);
      verify(userRepository.login(emailSample, passwordSample));
      verifyNever(userRepository.profile(''));
    });
  });
}
