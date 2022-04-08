import 'package:app/utils/auth_result.dart';
import 'package:email_validator/email_validator.dart';

class Validate {
  static ValidateResult name(String name) {
    if (name.isEmpty) return ValidateResult(false, message: 'Name must be filled');
    if (name.split('').first == ' ' || name.split('').last == ' ')
      return ValidateResult(false, message: 'Name first or last cannot be empty');
    if (!RegExp(r"(^[A-Za-z0-9 -]*$)").hasMatch(name))
      return ValidateResult(false, message: 'Name only allowed letter and number');
    return ValidateResult(true);
  }

  static ValidateResult email(String email) {
    if (email.isEmpty)
      return ValidateResult(false, message: 'Email must be filled');
    if (!EmailValidator.validate(email))
      return ValidateResult(false, message: 'Email is invalid');
    return ValidateResult(true);
  }

  static ValidateResult password(String password) {
    if (password.isEmpty)
      return ValidateResult(false, message: 'Password must be filled');
    if (!(password.split('').length > 7))
      return ValidateResult(false, message: 'Password length must be 8 character');
    return ValidateResult(true);
  }
}

class ValidateResult {
  bool success;
  String? message;

  ValidateResult(this.success, {this.message});
}
