import 'package:calorie_mobile/movas/actions/entry_action.dart';
import 'package:calorie_mobile/screen/dashboard/components/create_entry_dialog.dart';
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
      body: EntitiesScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      FloatingActionButton(
        backgroundColor: Colors.white,
          child: Center(
              child:
          IconButton(
            onPressed: () {
              createEntryDialog(context)
                  .then((value) {
                    if (value as bool) {
                      EntryAction.of(context).getEntries();
              }});
            },
            icon: Icon(Icons.add, size: 35.0,),
            color: Colors.black,
            iconSize: 55.0,
            padding: EdgeInsets.all(0.0),)), onPressed: () {}),
    );
  }
}