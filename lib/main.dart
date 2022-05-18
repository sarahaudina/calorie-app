import 'package:calorie_mobile/providers/providers.dart';
import 'package:calorie_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:movas/config/config.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  moveAss(new MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Color(0x5465FF),
            focusColor: Color(0xE2FDFF),
            accentColor: Color(0x9BB1FF),
            backgroundColor: Color(0xBFD7FF),
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
        home: DashboardScreen(),
      ),
    );
  }
}
