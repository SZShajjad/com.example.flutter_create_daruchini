import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

mixin SecureScreenMixin {
  static const _channel = MethodChannel('com.daruchini.auth/security');

  Future<void> setSecureScreen(bool enabled) async {
    try {
      await _channel.invokeMethod('setSecureScreen', {'enabled': enabled});
    } on PlatformException catch (e) {
      debugPrint("Failed to set secure screen: ${e.message}");
    }
  }
}
