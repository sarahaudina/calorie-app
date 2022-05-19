import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

class Util {
  static bool isWeb() {
    if (kIsWeb) {
      return true;
    }
    return false;
  }

  static String formatDate(DateTime date) => DateFormat("MMM dd yyyy").format(date);

  static DateTime parseDate(String date) => DateFormat("MMM dd yyyy").parse(date);

}