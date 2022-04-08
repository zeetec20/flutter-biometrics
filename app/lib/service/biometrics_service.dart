import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as authError;

class BiometricsService {
  Future<bool> checkBiometrics() async =>
      (await LocalAuthentication().canCheckBiometrics) &&
      ((await LocalAuthentication().getAvailableBiometrics())
              .contains(BiometricType.face) ||
          (await LocalAuthentication().getAvailableBiometrics())
              .contains(BiometricType.fingerprint));

  Future<BiometricsResult> tryAuth(String reason) async {
    try {
      if (await LocalAuthentication().authenticate(
          localizedReason: reason,
          biometricOnly: true)) return BiometricsResult(true);
      return BiometricsResult(false,
          message: 'Invalid biometrics, please try again');
    } on PlatformException catch (e) {
      if (e.code == authError.notAvailable)
        return BiometricsResult(false,
            message: 'Please enable biometrics system on your device');
      return BiometricsResult(false, message: 'Something wrong on system');
    }
  }
}

class BiometricsResult {
  bool success;
  String? message;

  BiometricsResult(this.success, {this.message});
}
