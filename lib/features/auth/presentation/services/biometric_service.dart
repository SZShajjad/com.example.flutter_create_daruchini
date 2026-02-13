import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } on PlatformException catch (e) {
      debugPrint("Biometric availability check error: $e");
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      // Basic authentication for version 3.0.0 compatibility
      // We will avoid AuthenticationOptions if the compiler complains about it
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason:
            'Secure access to Daruchini Vault requires authentication',
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      debugPrint("Authentication error: $e");
      return false;
    }
  }
}
