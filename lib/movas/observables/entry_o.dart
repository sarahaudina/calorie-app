import 'package:calorie_mobile/movas/models/entry.dart';

class EntryO {
  final String name;
  final String id;
  final double calories;
  final double price;
  final String userId;
  final DateTime createdAt;

  EntryO(this.name, this.id, this.calories, this.price, this.userId, this.createdAt);

  factory EntryO.fromEntity(FoodEntry entity) {
    return EntryO(
        entity.name,
        entity.id, entity.calories, entity.price,
        entity.userId, entity.createdAt);
  }
}

class AllEntriesO {
  final List<EntryO> allEntries;

  AllEntriesO(this.allEntries);

  factory AllEntriesO.fromEntity(AllEntries entity) {
    var entries = List<EntryO>.from(entity.allEntries.map((model)=> EntryO.fromEntity(model)));
    return AllEntriesO(entries);
  }
}