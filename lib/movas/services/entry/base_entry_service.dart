import 'package:calorie/movas/models/entry.dart';
import 'package:calorie/movas/services/http/model/entry/entry_request.dart';

abstract class BaseEntryService {

  Future<void> resetEntries();

  Future<AllEntries?> getEntries(GetEntriesRequest request);

  Future<void> createEntry(CreateEntryRequest request);

  Future<void> deleteEntry(DeleteEntryRequest request);

  Future<void> updateEntry(UpdateEntryRequest request);
}
