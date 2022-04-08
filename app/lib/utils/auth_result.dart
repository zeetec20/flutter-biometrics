import 'package:app/model/User.dart';

class AuthResult {
  final bool success;
  String? message;
  User? user;

  AuthResult(this.success, {this.message, this.user});
}
