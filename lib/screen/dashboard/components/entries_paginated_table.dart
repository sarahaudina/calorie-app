
import 'package:calorie/main.dart';
import 'package:calorie/movas/actions/entry_action.dart';
import 'package:calorie/movas/models/entry.dart';
import 'package:calorie/movas/observables/entry_o.dart';
import 'package:calorie/screen/datatable/advanced_datatable_source.dart';
import 'package:calorie/screen/datatable/datatable.dart';
import 'package:calorie/screen/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntryPaginatedTable extends StatefulWidget {
  final SelectedCallBack selectedCallBack;

  const EntryPaginatedTable({Key? key, required this.selectedCallBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EntryPaginatedTableState(DataSource(selectedCallBack));
  }
}

class EntryPaginatedTableState extends State<EntryPaginatedTable> {
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  final DataSource source;

  EntryPaginatedTableState(this.source);

  reload() {
      source.selectedObjects.clear();
      source.needReload = true;
      source.notifyListeners();
      source.needReload = false;
      source.getNextPage(NextPageRequest(rowsPerPage, 0));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: AdvancedPaginatedDataTable(
        loadingWidget: () => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(child: CircularProgressIndicator()),
        ),
        source: source,
        addEmptyRows: false,
        showCheckboxColumn: true,
        showFirstLastButtons: false,
        rowsPerPage: rowsPerPage,
        availableRowsPerPage: [AdvancedPaginatedDataTable.defaultRowsPerPage],
        onRowsPerPageChanged: (newRowsPerPage) {
          if (newRowsPerPage != null) {
            setState(() {
              rowsPerPage = source.data.length;
            });
          }
        },
        columns: [
          DataColumn(label: Text('Food Name')),
          DataColumn(label: Text('Calories (cal)')),
          DataColumn(label: Text('Price (USD)')),
          DataColumn(label: Text('User ID')),
          DataColumn(
            label: Text("Created At"),
          ),
          DataColumn(
            label: Text("User Weekly\nAverage (cal)"),
          ),
        ],
      ),
    );
  }
}

class RowData {
  final int index;
  final String value;

  RowData(this.index, this.value);
}

typedef SelectedCallBack = Function(List<EntryO> objects);

class DataSource extends AdvancedDataTableSource<EntryO> {
  final data = <EntryO>[];
  List<EntryO> selectedObjects = [];
  final SelectedCallBack selectedCallBack;
  int totalCount = 25;
  bool needReload = false;

  DataSource(this.selectedCallBack);

  @override
  int get rowCount => totalCount;

  @override
  int get selectedRowCount => selectedObjects.length;

  @override
  DataRow? getRow(int index) {
    final currentRowData = lastDetails!.rows[index];
    return DataRow(
        onSelectChanged: (selected) {
          if (selectedObjects.where((i) => i.id==currentRowData.id).isNotEmpty) {
            selectedObjects.removeWhere((i) => i.id==currentRowData.id);
          } else {
            selectedObjects.add(currentRowData);
          }

          selectedCallBack?.call(selectedObjects);
          notifyListeners();
        },
        selected: selectedObjects.where((i) => i.id==currentRowData.id).isNotEmpty,
        cells: [
      DataCell(
        Text(currentRowData.name.toString()),
      ),
      DataCell(
        Text(currentRowData.calories.toString()),
      ),
      DataCell(
        Text(currentRowData.price.toString()),
      ),
      DataCell(
        Text(currentRowData.user.id),
      ),
      DataCell(
        Text(Util.formatDate(currentRowData.createdAt))
      ),
      DataCell(
        Text(currentRowData.user.weeklyAverage!.floor().toString()),
      ),
    ]);
  }

  @override
  Future<RemoteDataSourceDetails<EntryO>> getNextPage(
      NextPageRequest pageRequest) async {

    int page = (pageRequest.offset/pageRequest.pageSize).floor()+1;
    var response = await EntryAction.of(navigatorKey.currentContext!).getEntries(page: page);

    if (response is AllEntries) {
      totalCount = response.totalCount ?? 0;
      data.clear();
      // selectedIds.clear();
      for (var i in response.allEntries) {
        data.add(EntryO.fromEntity(i));
      }
    }

    return RemoteDataSourceDetails(
      totalCount,
      data
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  bool requireRemoteReload() {
    if (needReload)
      return true;
    return super.requireRemoteReload();
  }
}