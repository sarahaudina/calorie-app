import 'package:calorie_mobile/movas/services/http/model/entry/entry_response.dart';

class FoodEntry {
  final String name;
  final String? id;
  final double calories;
  final double? price;
  final String userId;
  final DateTime createdAt;

  FoodEntry(this.name, this.id, this.calories, this.price, this.userId, this.createdAt);

  factory FoodEntry.fromJson(Map json) {
    return FoodEntry(
        json['name'],
        json['_id'],
        json['calories']*1.0,
        json['price']!=null? json['price']*1.0 : 0,
        json['userId'],
        DateTime.parse(json['createdAt']));
  }
}

class AllEntries {
  final List<FoodEntry> allEntries;
  final double monthlyBudget;
  final double dailyCaloriesLimit;
  final bool passMonthlyBudget;
  final bool passDailyCaloriesLimit;

  factory AllEntries.fromResponse(GetEntriesResponse response) {
    var entries = List<FoodEntry>.from(response.map.map((model)=> FoodEntry.fromJson(model)));
    return AllEntries(
        entries,
        response.monthlyBudget,
        response.dailyCaloriesLimit,
        response.passMonthlyBudget,
        response.passDailyCaloriesLimit
    );
  }

  AllEntries(this.allEntries, this.monthlyBudget, this.dailyCaloriesLimit, this.passMonthlyBudget, this.passDailyCaloriesLimit);
}