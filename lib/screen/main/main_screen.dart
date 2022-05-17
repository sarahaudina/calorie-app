import 'dart:io';
import 'package:calorie_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:calorie_mobile/screen/main/components/menu_drawer.dart';
import 'package:calorie_mobile/screen/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.black,
      drawer: MenuDrawer(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isWeb())
              Expanded(
                child: MenuDrawer(),
              ),
            Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ]),
    ));
  }

}