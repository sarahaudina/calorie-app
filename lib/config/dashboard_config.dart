import 'package:calorie/config/config.dart';
import 'package:flutter/material.dart';

class AdminTheme {
  static Color primaryColor = Color(0x5465FF);
  static Color accentColor = Colors.deepPurple;
  static Color backgroundColor = Colors.white;
  static Color scaffoldBackgroundColor = Color(0xF5F5F5FF);
  static Color primaryColorDark = Colors.blueAccent;
  static Color primaryColorLight = Colors.white;
  static Color primaryTextColor = Colors.black;
}

class DashboardConfig extends Config {
  @override
  String accessToken() {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjI4OGVmNjVmODI0ZDMzMDMyMzFhZjdhIiwiZGFpbHlDYWxvcnlMaW1pdCI6MjEwMCwibW9udGhseUJ1ZGdldCI6MTAwMH0sImlzQWRtaW4iOnRydWUsImlhdCI6MTY1MzE0MTM2MiwiZXhwIjoxNjUzNTAxMzYyfQ.rjC3T6FKWUNkWQLVXygyfDshWE_39tYtnKPA229n1a8";
  }

  @override
  String baseUrl() {
    return "http://localhost:1234/api/v1/";
  }
}