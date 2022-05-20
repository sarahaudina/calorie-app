import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/movas/models/entry.dart';
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
  late EntryMetaData metaData;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initMetaData();
    });
    super.initState();
  }

  initMetaData() async {
    var res = await EntryAction.of(context).getMetadata();
    setState(() {
      if (res!=null)
      metaData = res;
    });
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: metaData==null ? CircularProgressIndicator() : SmallCard(
                          title: "New Entries",
                        value: metaData.countThisWeek.toString(), label: "cal",
                        comparedValue: "Last week ${metaData.countPrevWeek}",),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SmallCard(title: "Weekly Average", value: "1500", label: "cal"),
                    ),
                  ],
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
                                () => EntryAction.of(context).deleteEntry(selectedIds[0].user.id)
                                    .then((value) {
                                  // html.window.location.reload();
                                }),
                            color: Colors.red),
                      if (selectedIds.isNotEmpty && selectedIds.length==1)
                        DefaultButton("Update",
                                () => createEntryDialog(context, existingEntry: selectedIds[0]),
                            color: Colors.black),
                      DefaultButton("Create Entry",
                              () => createEntryDialog(context)),
                    ],
                  ),
                ),
              ],
            ),
          )),);
  }

}