import 'package:calorie/movas/models/entry.dart';

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
        entity.id!, entity.calories, entity.price!,
        entity.userId, entity.createdAt);
  }
}

class AllEntriesO {
  final List<EntryO> allEntries;
  final double? monthlyBudget;
  final double? dailyCaloriesLimit;
  final bool? passMonthlyBudget;
  final bool? passDailyCaloriesLimit;

  AllEntriesO(this.allEntries, this.monthlyBudget, this.dailyCaloriesLimit, this.passMonthlyBudget, this.passDailyCaloriesLimit);

  factory AllEntriesO.fromEntity(AllEntries entity) {
    var entries = List<EntryO>.from(entity.allEntries.map((model)=> EntryO.fromEntity(model)));
    return AllEntriesO(
      entries,
      entity.monthlyBudget,
      entity.dailyCaloriesLimit,
      entity.passMonthlyBudget,
      entity.passDailyCaloriesLimit
    );
  }
}