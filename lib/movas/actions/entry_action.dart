import 'package:calorie_mobile/movas/models/entry.dart';
import 'package:calorie_mobile/movas/services/entry/base_entry_service.dart';
import 'package:calorie_mobile/movas/services/http/model/entry/entry_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:movas/provider/provider.dart';

class EntryAction {
  final BaseEntryService service;

  EntryAction(this.service);

  factory EntryAction.of(BuildContext context) => EntryAction(
      StaticProvider.of(context));

  Future<void> resetEntries() async {
    return service.resetEntries();
  }

  Future<void> getEntries({DateTime? fromDate, DateTime? toDate}) async {
    return service.getEntries(GetEntriesRequest(fromDate: fromDate, toDate: toDate));
  }

  Future<void> createEntry(FoodEntry newEntry) async {
    return service.createEntry(CreateEntryRequest(
      name: newEntry.name,
      createdAt: newEntry.createdAt,
      price: newEntry.price,
      calories: newEntry.calories,
      userId: newEntry.userId
    ));
  }

}