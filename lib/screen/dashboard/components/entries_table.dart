import 'package:calorie_mobile/movas/actions/entry_action.dart';
import 'package:calorie_mobile/movas/observables/entry_o.dart';
import 'package:calorie_mobile/screen/dashboard/components/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class EntriesTable extends StatelessWidget {
  final AllEntriesO entries;

  const EntriesTable(this.entries);

  @override
  Widget build(BuildContext context) {

    if (entries.allEntries.isEmpty)
      return CircularProgressIndicator();
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GreenButton("Create Entry",
                    (_) => {})
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: DataTable2(
            minWidth: 600,
            columns: [
              DataColumn(
                label: Text("Food"),
              ),
              DataColumn(
                label: Text("Calories"),
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
  }

  DataRow EntryRow ({Key? key, required EntryO entry, required int index, required BuildContext context}) {
    return DataRow(cells: [
      DataCell(Text(entry.name)),
      DataCell(Text('${entry.calories} cal')),
      DataCell(Text('${entry.price}'))
    ]);
  }
}