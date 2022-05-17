import 'package:calorie_mobile/movas/actions/entry_action.dart';
import 'package:calorie_mobile/screen/dashboard/dashboard_entities_screen.dart';
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
      body: EntitiesScreen()
    );
  }
}