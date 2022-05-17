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

  Future<void> getEntries() async {
    return service.getEntries(GetEntriesRequest());
  }

  Future<void> createEntry(FoodEntry newEntry) async {
    return service.createEntry(CreateEntryRequest());
  }

  Future<void> updateEntry(
      String id,
      String name,
      double calories,
      double price,
      String userId,
      DateTime createdAt) async {
    return;
  }

  Future<void> deleteEntry(String entryId) async {
    return;
  }


}