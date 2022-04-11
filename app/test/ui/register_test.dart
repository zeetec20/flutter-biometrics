import 'dart:convert';

import 'package:app/pages/auth/register.dart';
import 'package:app/provider/app_provider.dart';
import 'package:app/provider/login_provider.dart';
import 'package:app/provider/register_provider.dart';
import 'package:app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'register_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  MockUserRepository userRepository = MockUserRepository();

  Widget makeWidgetTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(
            userRepository,
          ),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(
            userRepository,
          ),
        )
      ],
      builder: (c, child) {
        return MaterialApp(
          home: RegisterPage((int index) {}),
        );
      },
    );
  }

  Finder name = find.byKey(Key('name-field'));
  Finder validateName = find.byKey(Key('name-validate-field'));
  Finder email = find.byKey(Key('email-field'));
  Finder validateEmail = find.byKey(Key('email-validate-field'));
  Finder password = find.byKey(Key('password-field'));
  Finder validatePassword = find.byKey(Key('password-validate-field'));
  Finder signUp = find.byKey(Key('sign-up-button'));

  group('name field', () {
    testWidgets('name, validate error empty', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(name, '');
      await tester.tap(signUp);
      await tester.pump();

      expect(validateName, findsOneWidget);
      expect(find.text('Name must be filled'), findsOneWidget);
    });

    testWidgets('name, validate error invalid', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(name, ' name ');
      await tester.tap(signUp);
      await tester.pump();

      expect(validateName, findsOneWidget);
      expect(find.text('Name first or last cannot be empty'), findsOneWidget);
    });

    testWidgets('name, validate error invalid unicode',
        (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(name, 'name123#*%');
      await tester.tap(signUp);
      await tester.pump();

      expect(validateName, findsOneWidget);
      expect(find.text('Name only allowed letter and number'), findsOneWidget);
    });

    testWidgets('name, validate success', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(name, 'name123');
      await tester.tap(signUp);
      await tester.pump();

      expect(validateName, findsNothing);
    });
  });

  group('email field', () {
    testWidgets('email, validate error empty', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, '');
      await tester.tap(signUp);
      await tester.pump();

      expect(validateEmail, findsOneWidget);
      expect(find.text('Email must be filled'), findsOneWidget);
    });

    testWidgets('email, validate error invalid', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, '@gmail.com');
      await tester.tap(signUp);
      await tester.pump();

      expect(validateEmail, findsOneWidget);
      expect(find.text('Email is invalid'), findsOneWidget);
    });

    testWidgets('email, validate success', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, 'admin@gmail.com');
      await tester.tap(signUp);
      await tester.pump();

      expect(validateEmail, findsNothing);
    });
  });

  group('password field', () {
    testWidgets('password, validate error empty', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(password, '');
      await tester.tap(signUp);
      await tester.pump();

      expect(validatePassword, findsOneWidget);
      expect(find.text('Password must be filled'), findsOneWidget);
    });

    testWidgets('password, validate error length less than 8',
        (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(password, 'admin');
      await tester.tap(signUp);
      await tester.pump();

      expect(validatePassword, findsOneWidget);
      expect(find.text('Password length must be 8 character'), findsOneWidget);
    });

    testWidgets('password, validate success', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTest());
      await tester.enterText(email, '');
      await tester.enterText(password, 'admin123');
      await tester.tap(signUp);
      await tester.pump();

      expect(validatePassword, findsNothing);
    });

  });

  group('register', () {
      testWidgets('register, success', (WidgetTester tester) async {
        String nameSample = 'name';
        String emailSample = 'admin@gmail.com';
        String passwordSample = 'admin123';
        http.Response resLogin = http.Response(
            jsonEncode({
              'success': true,
            }),
            200);
        when(userRepository.register(nameSample, emailSample, passwordSample))
            .thenAnswer((_) async => resLogin);

        await tester.pumpWidget(makeWidgetTest());
        await tester.enterText(name, nameSample);
        await tester.enterText(email, emailSample);
        await tester.enterText(password, passwordSample);
        await tester.tap(signUp);
        await tester.pump();

        expect(validateName, findsNothing);
        expect(validateEmail, findsNothing);
        expect(validatePassword, findsNothing);
        verify(
            userRepository.register(nameSample, emailSample, passwordSample));
      });
    });
}
