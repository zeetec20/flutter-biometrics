import 'package:app/repository/user_repository.dart';
import 'package:app/service/auth_service.dart';
import 'package:app/utils/auth_result.dart';
import 'package:app/utils/validate.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final UserRepository userRepository;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValidateResult? emailCorrect;
  ValidateResult? passwordCorrect;
  late AuthService authService;
  bool submited = false;
  bool showPassword = false;

  LoginProvider(this.userRepository) {
    this.authService = AuthService(userRepository);
  }

  void changePasswordShow() {
    this.showPassword = !this.showPassword;

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
      (emailCorrect?.success ?? false) && (passwordCorrect?.success ?? false);

  Future<AuthResult> login() async {
    this.submited = true;
    validateEmail();
    validatePassword();
    if (validate)
      return await authService.login(
          emailController.text, passwordController.text);

    return AuthResult(false,
        message: emailCorrect?.message ?? passwordCorrect?.message);
  }
}
