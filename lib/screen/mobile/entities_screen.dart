import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/movas/models/entry.dart';
import 'package:calorie/screen/mobile/components/notification_dialog.dart';
import 'package:calorie/screen/mobile/entities_screen_body.dart';
import 'package:calorie/screen/shared_components/create_entry_dialog.dart';
import 'package:calorie/screen/util.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EntitiesScreenBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
            child: Center(
                child:
            IconButton(
              onPressed: () {
                createEntryDialog(context, isAdmin: false)
                    .then((value) {
                  Util.showGetEntriesLoaderDialog(context);

                  EntryAction.of(context).getEntriesForUser(
                      fromDate: DateTime.now(), toDate: DateTime.now()
                  ).then((entries) {
                    Navigator.of(context).popUntil((route) => !route.hasActiveRouteBelow);

                    if (entries is AllEntries) {
                      if (entries!.passDailyCaloriesLimit!) {
                        showDailyLimitReachedReminder(context);
                      }
                      if (entries!.passMonthlyBudget!){
                        showMonthlyLimitReachedReminder(context);
                      }
                    }

                  });

                });
              },
              icon: Icon(Icons.add, size: 35.0,),
              iconSize: 55.0,
              padding: EdgeInsets.all(0),)), onPressed: () {}),
      ),
    );
  }
}