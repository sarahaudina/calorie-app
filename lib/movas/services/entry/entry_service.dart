import 'package:calorie_mobile/movas/models/entry.dart';
import 'package:calorie_mobile/movas/services/entry/base_entry_service.dart';
import 'package:calorie_mobile/movas/services/http/base_http_service.dart';
import 'package:calorie_mobile/movas/services/http/model/entry/entry_request.dart';
import 'package:calorie_mobile/movas/services/http/model/entry/entry_response.dart';
import 'package:movas/movas.dart';

class EntryService extends BaseEntryService {
  final PublishSubject<AllEntries> allEntriesE;
  final BaseHttpService httpService;

  EntryService(this.allEntriesE, this.httpService);

  @override
  Future<void> createEntry(CreateEntryRequest request) {
    // TODO: implement createEntry
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEntry(DeleteEntryRequest request) {
    // TODO: implement deleteEntry
    throw UnimplementedError();
  }

  @override
  Future<void> getEntries(GetEntriesRequest request) async {
    var response = await httpService.get(
        request: request,
        converter: (_) {
          print("getEntries $_");
          return GetEntriesResponse.fromMap(_);
        });
    if (response is GetEntriesResponse) {
      return allEntriesE.add(AllEntries.fromJson(response.map));
    }
  }

  @override
  Future<void> updateEntry(UpdateEntryRequest request) {
    // TODO: implement updateEntry
    throw UnimplementedError();
  }

}