import 'package:app/service/auth_service.dart';
import 'package:app/utils/auth_result.dart';
import 'package:app/utils/validate.dart';
import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValidateResult? nameCorrect;
  ValidateResult? emailCorrect;
  ValidateResult? passwordCorrect;
  AuthService authService = AuthService();
  bool showPassword = false;
  bool submited = false;

  void changePasswordShow() {
    this.showPassword = !this.showPassword;

    notifyListeners();
  }

  void validateName() {
    this.nameCorrect = Validate.name(nameController.text);

    notifyListeners();
  }

  void validateEmail() {
    this.emailCorrect = Validate.email(emailController.text);

    notifyListeners();
  }

  void validatePassword() {
    this.passwordCorrect = Validate.password(passwordController.text);

    notifyListeners();
  }

  bool get validate =>
      (nameCorrect?.success ?? false) ||
      (emailCorrect?.success ?? false) ||
      (passwordCorrect?.success ?? false);

  Future<AuthResult> register() async {
    this.submited = true;
    validateName();
    validateEmail();
    validatePassword();
    if (validate)
      return await authService.register(
          nameController.text, emailController.text, passwordController.text);

    return AuthResult(false,
        message: nameCorrect?.message ??
            emailCorrect?.message ??
            passwordCorrect?.message);
  }
}
