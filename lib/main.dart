
import 'package:calorie/app/dashboard_app.dart';
import 'package:calorie/app/mobile_app.dart';
import 'package:calorie/screen/util.dart';
import 'package:flutter/material.dart';
import 'package:movas/config/config.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Widget app = Util.isWeb() ? DashboardApp() : MobileApp();

  moveAss(app);
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
