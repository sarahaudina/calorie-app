import 'package:flutter/foundation.dart' show kIsWeb;

class Util {
  static bool isWeb() {
    if (kIsWeb) {
      return true;
    }
    return false;
  }
}