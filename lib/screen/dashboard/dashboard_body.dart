import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/movas/models/entry.dart';
import 'package:calorie/movas/observables/entry_o.dart';
import 'package:calorie/screen/dashboard/components/buttons.dart';
import 'package:calorie/screen/shared_components/create_entry_dialog.dart';
import 'package:calorie/screen/dashboard/components/entries_paginated_table.dart';
import 'package:calorie/screen/dashboard/components/entries_table.dart';
import 'package:calorie/screen/shared_components/small_card.dart';
import 'package:calorie/screen/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:calorie/screen/shared_components/base_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/confirmation_dialog.dart';

class DashboardBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardBodyState();
  }
}

class DashboardBodyState extends State<DashboardBody> {
  List<EntryO> selectedObjects = [];
  final GlobalKey<EntryPaginatedTableState> tableKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initMetaData();
    });
    super.initState();
  }

  initMetaData() async {
    EntryAction.of(context).getMetadata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.all(16),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<EntryMetaDataO?>(
                    builder: (context, metaData, _) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: metaData==null ? CircularProgressIndicator() : SmallCard(
                              title: "New Entries",
                              value: metaData.countLastWeek.toString(), label: "entries",
                              comparedValue:
                              metaData.countLastWeek>=metaData.countPrevWeek
                                  ? "+${metaData.countLastWeek-metaData.countPrevWeek} from previous week"
                                  : "-${metaData.countLastWeek-metaData.countPrevWeek} from previous week",
                              compareValueColor: metaData.countLastWeek>metaData.countPrevWeek
                                ? Colors.green
                                  : metaData.countLastWeek<metaData.countPrevWeek
                                  ? Colors.red
                                  : Colors.black
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: metaData==null ? CircularProgressIndicator() : SmallCard(
                              title: "Total Entries",
                              value: metaData.totalItems.toString(), label: "entries"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: metaData==null ? CircularProgressIndicator() : SmallCard(
                              title: "Last Week Average Value",
                              value: metaData.averageLastWeekInput.toStringAsFixed(2), label: "cal per entry"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: metaData==null ? CircularProgressIndicator() : SmallCard(
                              title: "Last Week Active Users",
                              value: metaData.lastWeekActiveUsers.toString(), label: "users",
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: EntryPaginatedTable(
                    key: tableKey,
                    selectedCallBack: (objs) {
                        setState(() {
                          selectedObjects = objs;
                        });

                        selectedObjects.forEach((element) {
                          print('_in selected ${element.name}');
                        });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (selectedObjects.isNotEmpty && selectedObjects.length==1)
                        DefaultButton("Delete",
                                () => showConfirmationDialog(
                                    context,
                                    "Delete Entry ${selectedObjects[0].id}",
                                    "Do you want to delete this item?",
                                        () => EntryAction.of(context).deleteEntry(selectedObjects[0].id)
                                        .then((value) {
                                      setState(() {
                                        selectedObjects.clear();
                                        tableKey.currentState?.reload();
                                      });
                                      Util.showSuccessDialog(context, "Delete success");
                                    })),
                            color: Colors.red),
                      if (selectedObjects.isNotEmpty && selectedObjects.length==1)
                        DefaultButton("Update",
                                () => createEntryDialog(context, existingEntry: selectedObjects[0]).then(<bool>(value) {
                                  if (value) {
                                    setState(() {
                                      selectedObjects.clear();
                                      tableKey.currentState?.reload();
                                    });
                                    Util.showSuccessDialog(context, "Update success");
                                  }
                                }),
                            color: Colors.black),
                      DefaultButton("Create Entry",
                              () => createEntryDialog(context).then(<bool>(value) {
                                if (value) {
                                  setState(() {
                                    selectedObjects.clear();
                                    tableKey.currentState?.reload();
                                  });
                                }
                              })),
                    ],
                  ),
                ),
              ],
            ),
          )));
  }

}