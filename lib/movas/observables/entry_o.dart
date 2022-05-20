import 'package:calorie/movas/models/entry.dart';
import 'package:calorie/movas/observables/user_o.dart';

class EntryO {
  final String id;
  final String name;
  final UserO user;
  final double calories;
  final double price;
  final DateTime createdAt;

  EntryO(this.name, this.user, this.calories, this.price, this.createdAt, this.id);

  factory EntryO.fromEntity(FoodEntry entity) {
    return EntryO(
        entity.name,
        UserO.fromEntity(entity.user!),
        entity.calories,
        entity.price!,
        entity.createdAt, entity.id);
  }
}

class AllEntriesO {
  final List<EntryO> allEntries;
  final double? monthlyBudget;
  final double? dailyCaloriesLimit;
  final bool? passMonthlyBudget;
  final bool? passDailyCaloriesLimit;
  final double? monthlyBudgetLeft;
  final double? dailyLimitLeft;

  AllEntriesO(this.allEntries, this.monthlyBudget, this.dailyCaloriesLimit, this.passMonthlyBudget, this.passDailyCaloriesLimit, this.monthlyBudgetLeft, this.dailyLimitLeft);

  factory AllEntriesO.fromEntity(AllEntries entity) {
    var entries = List<EntryO>.from(entity.allEntries.map((model)=> EntryO.fromEntity(model)));
    return AllEntriesO(
      entries,
      entity.monthlyBudget,
      entity.dailyCaloriesLimit,
      entity.passMonthlyBudget,
      entity.passDailyCaloriesLimit,
      entity.monthlyBudgetLeft,
      entity.dailyLimitLeft
    );
  }
}