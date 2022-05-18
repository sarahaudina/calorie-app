import 'package:calorie_mobile/movas/services/http/model/entry/entry_request.dart';

abstract class BaseEntryService {

  Future<void> getEntries(GetEntriesRequest request);

  Future<void> createEntry(CreateEntryRequest request);
}
