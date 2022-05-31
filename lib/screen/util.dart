import 'dart:async';

import 'package:calorie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
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

  static DateTime parseWithTZ(String date) => DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date, false);

  static String dateTimeFormatter(String dateTime, {String? format}) {
    return DateFormat(format ?? 'yyyy/MM/dd, hh:mm a')
        .format(DateTime.parse(dateTime).toLocal())
        .toString();
  }

  static bool isNumeric(String str) {
    try{
      var value = double.parse(str);
    } catch (_) {
      return false;
    } finally {
      return false;
    }
  }

  static showGetEntriesLoaderDialog(BuildContext context) async {
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(
      barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


  static showSuccessDialog(BuildContext context, String text) {
    return showDialog(
      barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          content: new Row(
            children: [
              Container(margin: EdgeInsets.only(left: 7),
                  child:Text(text)),
            ]),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}