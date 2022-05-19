import 'package:calorie/main.dart';
import 'package:calorie/providers/mobile_providers.dart';
import 'package:calorie/screen/mobile/entities_screen.dart';
import 'package:flutter/material.dart';
import 'package:movas/config/config.dart';
import 'package:provider/provider.dart';

class MobileApp extends StatelessWidget {
  MobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: mobileProviders,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Color(0x5465FF),
            focusColor: Color(0xE2FDFF),
            accentColor: Colors.deepPurple,
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.grey.shade100,
            primaryColorDark: Colors.black,
            primaryColorLight: Colors.white,
            textSelectionColor: Colors.black,
            textTheme: TextTheme(
              titleSmall: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12
              ),
              labelLarge: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 32
              ),
              labelMedium: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18
              ),
              labelSmall: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12
              ),
            )
        ),
        home: EntitiesScreen(),
      ),
    );
  }
}