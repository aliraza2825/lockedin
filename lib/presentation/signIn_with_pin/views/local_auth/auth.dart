import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    bool isAuthenticated = false;
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (canCheckBiometrics) {
        isAuthenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to access this feature'.tr,
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
    return isAuthenticated;
  }
}