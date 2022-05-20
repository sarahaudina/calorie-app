import 'package:calorie/main.dart';
import 'package:calorie/movas/models/entry.dart';
import 'package:calorie/movas/observables/entry_o.dart';
import 'package:calorie/movas/services/entry/base_entry_service.dart';
import 'package:calorie/movas/services/http/base_http_service.dart';
import 'package:calorie/movas/services/http/model/entry/entry_request.dart';
import 'package:calorie/movas/services/http/model/entry/entry_response.dart';
import 'package:calorie/screen/mobile/components/notification_dialog.dart';
import 'package:calorie/screen/util.dart';
import 'package:movas/movas.dart';

class EntryService extends BaseEntryService {
  final PublishSubject<AllEntries> allEntriesE;
  final BaseHttpService httpService;

  EntryService(this.allEntriesE, this.httpService);

  @override
  Future<void> createEntry(CreateEntryRequest request) async {
    return httpService.post(
        request: request);
  }

  @override
  Future<AllEntries?> getEntriesForUser(GetEntriesForUserRequest request) async {
    var response = await httpService.get(
        request: request,
        converter: (_) {
          return GetEntriesResponse.fromMap(_);
        });
    if (response is GetEntriesResponse) {
      var allEntries = AllEntries.fromResponse(response);
      allEntriesE.add(allEntries);
      return allEntries;
    }
  }

  @override
  Future<AllEntries?> getEntries(GetEntriesRequest request) async {
    var response = await httpService.get(
        request: request,
        converter: (_) {
          return GetEntriesResponse.fromMap(_);
        });
    if (response is GetEntriesResponse) {
      var allEntries = AllEntries.fromResponse(response);
      allEntriesE.add(allEntries);
      return null;
    }
  }

  @override
  Future<void> resetEntries() async {
    return allEntriesE.add(AllEntries([], 0, 0, false, false, 0 , 0));
  }

  @override
  Future<void> deleteEntry(DeleteEntryRequest request) {
    // TODO: implement deleteEntry
    throw UnimplementedError();
  }

  @override
  Future<void> updateEntry(UpdateEntryRequest request) {
    // TODO: implement updateEntry
    throw UnimplementedError();
  }

  @override
  Future<EntryMetaData?> getMetaData(GetMetaDataRequest request) {
    // TODO: implement getMetaData
    throw UnimplementedError();
  }

}