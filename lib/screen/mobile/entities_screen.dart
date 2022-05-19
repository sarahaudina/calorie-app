import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/screen/mobile/entities_screen_body.dart';
import 'package:calorie/screen/shared_components/create_entry_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntitiesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EntitiesScreenState();
  }
}

class EntitiesScreenState extends State<EntitiesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp)
      => EntryAction.of(context).getEntriesForUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EntitiesScreenBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
                      EntryAction.of(context).getEntriesForUser();
              }});
            },
            icon: Icon(Icons.add, size: 35.0,),
            color: Colors.black,
            iconSize: 55.0,
            padding: EdgeInsets.all(0.0),)), onPressed: () {}),
    );
  }
}