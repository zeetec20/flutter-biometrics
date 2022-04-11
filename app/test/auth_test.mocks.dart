// Mocks generated by Mockito 5.1.0 from annotations
// in app/test/auth_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:app/repository/user_repository.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResponse_0 extends _i1.Fake implements _i2.Response {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response> login(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#login, [email, password]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> register(
          String? name, String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#register, [name, email, password]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> profile(String? token) =>
      (super.noSuchMethod(Invocation.method(#profile, [token]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> biometrics(String? token) =>
      (super.noSuchMethod(Invocation.method(#biometrics, [token]),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
}
