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
  Future<void> createEntry(CreateEntryRequest request) async {
    try {
      var response = await httpService.post(
          request: request,
          converter: (_) {
            print("createEntry $_");
            return _;
          });

      if (response?['statusCode'] == 200) {
        // show dialog success

      } else {
        // show dialog failed

      }
    } catch (_) {
      // show dialog failed
      print("createEntry $_");

    }

    return;
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
      return allEntriesE.add(AllEntries.fromResponse(response));
    }
  }

}