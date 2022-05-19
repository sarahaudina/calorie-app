import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/movas/observables/entry_o.dart';
import 'package:calorie/screen/dashboard/components/buttons.dart';
import 'package:calorie/screen/shared_components/create_entry_dialog.dart';
import 'package:calorie/screen/dashboard/components/entries_paginated_table.dart';
import 'package:calorie/screen/dashboard/components/entries_table.dart';
import 'package:calorie/screen/shared_components/small_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:calorie/screen/shared_components/base_card.dart';
import 'package:flutter/material.dart';

class DashboardBody extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return DashboardBodyState();
  }

}

class DashboardBodyState extends State<DashboardBody> {
  List<EntryO> selectedIds = [];
  final GlobalKey<EntryPaginatedTableState> tableKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(16),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SmallCard(title: "Average", value: "1500", label: "cal"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: EntryPaginatedTable(
                  key: tableKey,
                  selectedCallBack: (obj, selected) {
                      if (selectedIds.contains(obj)) {
                        setState(() {
                          selectedIds.remove(obj);
                        });
                      } else {
                        setState(() {
                          selectedIds.add(obj);
                        });
                      }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (selectedIds.isNotEmpty && selectedIds.length==1)
                      DefaultButton("Delete",
                              (_) {
                        // show dialog from mobile branch
                        // delete then reload
                        EntryAction.of(context).deleteEntry(selectedIds[0].id)
                            .then((value) => tableKey?.currentState?.refreshSource());

                      }, color: Colors.red),
                    if (selectedIds.isNotEmpty && selectedIds.length==1)
                      DefaultButton("Update",
                              (_) => createEntryDialog(context),
                          color: Colors.black),
                    DefaultButton("Create Entry",
                            (_) => createEntryDialog(context)),
                  ],
                ),
              ),
            ],
          )),);
  }

}