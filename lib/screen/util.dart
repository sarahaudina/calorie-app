import 'package:flutter/foundation.dart' show kIsWeb;

class Responsive {
  static bool isWeb() {
    if (kIsWeb) {
      return true;
    }
    return false;
  }
}