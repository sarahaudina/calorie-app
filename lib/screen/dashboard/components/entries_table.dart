import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/movas/observables/entry_o.dart';
import 'package:calorie/screen/dashboard/components/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllEntriesO>(
      builder: (_, entries, __) {
        if (entries.allEntries.isEmpty)
          return CircularProgressIndicator();
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text(""),
                  ),
                  DataColumn(
                    label: Text("Created At"),
                  ),
                  DataColumn(
                    label: Text("Food Name"),
                  ),
                  DataColumn(
                    label: Text("Calories"),
                  ),
                  DataColumn(
                    label: Text("User Id"),
                  ),
                  DataColumn(
                    label: Text("Price"),
                  ),
                ],
                rows: List.generate(
                  entries.allEntries.length,
                      (index) => EntryRow(entry: entries.allEntries[index], index: index, context: context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  DataRow EntryRow ({Key? key, required EntryO entry, required int index, required BuildContext context}) {
    return DataRow(cells: [
      DataCell(Text(index.toString()), onTap: () => showEntryForm(context, false)),
      DataCell(Text(entry.createdAt.toString())),
      DataCell(Text(entry.name)),
      DataCell(Text('${entry.calories} cal')),
      DataCell(Text('${entry.user.id}')),
      DataCell(Text('${entry.price}'))
    ]);
  }
}



showEntryForm(BuildContext context, bool editMode) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(editMode? "Update Food Entry" : "Create Food Entry"),
        content: Column(
          children: [

          ],
        ),
        actions: <Widget>[
          TextButton(
              child: new Text(editMode? "Update" : "Create"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ));
}