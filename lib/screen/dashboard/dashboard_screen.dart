import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/screen/dashboard/dashboard_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp)
      => EntryAction.of(context).getEntries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardBody()
    );
  }
}