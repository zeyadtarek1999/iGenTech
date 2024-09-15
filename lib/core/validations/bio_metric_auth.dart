import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      debugPrint('Error checking biometric availability: $e');
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('Error getting available biometrics: $e');
      return <BiometricType>[];
    }
  }

  Future<bool> authenticateWithBiometrics({required String reason}) async {
    try {
      bool isAuthenticated = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      return isAuthenticated;
    } catch (e) {
      debugPrint('Error authenticating with biometrics: $e');
      return false;
    }
  }

}
