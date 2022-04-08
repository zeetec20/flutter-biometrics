import 'package:app/model/User.dart';
import 'package:app/service/auth_service.dart';
import 'package:app/service/biometrics_service.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider with ChangeNotifier {
  PageController pageController = PageController();
  User? user;
  bool get isAuthenticate => this.user != null;
  bool isBiometricsAuthenticate = false;
  UserService userService = UserService();
  AuthService authService = AuthService();
  BiometricsService biometricsService = BiometricsService();

  AppProvider(this.user);

  Future changePage(int page) async {
    await pageController.animateToPage(page,
        duration: Duration(milliseconds: 350), curve: Curves.easeIn);
  }

  Future settingBiometrics() async {
    await this.userService.setBiometrics(this.user!.token);
    User user = await this.userService.profile(this.user!.token);
    this.isBiometricsAuthenticate = true;
    this.setUser(user);

    notifyListeners();
  }

  Future<BiometricsResult> authBiometrics(String reason) async {
    if (await this.biometricsService.checkBiometrics()) {
      BiometricsResult result = await this.biometricsService.tryAuth(reason);
      this.isBiometricsAuthenticate = result.success;

      if (result.success) notifyListeners();
      return result;
    }
    return BiometricsResult(false,
        message: 'Your device is not avaible for biometrics');
  }

  void refresh() => notifyListeners();

  Future setUser(User? user) async {
    this.user = user;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (this.user != null) {
      await pref.setInt('user.id', this.user!.id);
      await pref.setString('user.name', this.user!.name);
      await pref.setString('user.email', this.user!.email);
      await pref.setBool('user.useBiometrics', this.user!.useBiometrics);
      await pref.setString('user.token', this.user!.token);
    } else {
      await pref.remove('user.id');
      await pref.remove('user.name');
      await pref.remove('user.email');
      await pref.remove('user.useBiometrics');
      await pref.remove('user.token');
      this.isBiometricsAuthenticate = false;
    }

    notifyListeners();
  }
}
