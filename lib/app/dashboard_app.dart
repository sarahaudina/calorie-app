
import 'package:calorie/config/dashboard_config.dart';
import 'package:calorie/main.dart';
import 'package:calorie/providers/dashboard_providers.dart';
import 'package:calorie/screen/dashboard/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:movas/config/config.dart';
import 'package:provider/provider.dart';

class DashboardApp extends StatelessWidget {
  const DashboardApp({Key? key}) : super(key: key);

  ThemeData adminThemeData() => ThemeData(
      primaryColor: AdminTheme.primaryColor,
      accentColor: AdminTheme.accentColor,
      backgroundColor: AdminTheme.backgroundColor,
      scaffoldBackgroundColor: AdminTheme.scaffoldBackgroundColor,
      primaryColorDark: AdminTheme.primaryColorDark,
      primaryColorLight: AdminTheme.primaryColorLight
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: dashboardProviders,
      child: MaterialApp(
        title: 'Calorie Dashboard',
        theme: adminThemeData(),
        home: MainScreen(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
