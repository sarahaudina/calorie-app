import 'package:calorie/movas/models/user.dart';
import 'package:calorie/movas/services/http/model/entry/entry_response.dart';
import 'package:calorie/screen/util.dart';

class FoodEntry {
  final String id;
  final String name;
  final User? user;
  final double calories;
  final double? price;
  final DateTime createdAt;

  FoodEntry(this.id, this.name, this.user, this.calories, this.price, this.createdAt);

  factory FoodEntry.fromJson(Map json) {
    print('${json['calories']} date is ${DateTime.parse(json['createdAt']).toLocal()}');

    return FoodEntry(
        json['_id'],
        json['name'],
        json['user']==null ? null : User.fromJson(json['user']),
        json['calories']*1.0,
        json['price']!=null? json['price']*1.0 : 0,
        DateTime.parse(json['createdAt']).toLocal()
    );
  }
}

class AllEntries {
  final List<FoodEntry> allEntries;
  final double? monthlyBudget;
  final double? dailyCaloriesLimit;
  final bool? passMonthlyBudget;
  final bool? passDailyCaloriesLimit;
  final double? monthlyBudgetLeft;
  final double? dailyLimitLeft;

  factory AllEntries.fromResponse(GetEntriesResponse response) {
    var entries = List<FoodEntry>.from(response.map.map((model)=> FoodEntry.fromJson(model)));
    return AllEntries(
        entries,
        response.monthlyBudget ?? 0,
        response.dailyCaloriesLimit ?? 0,
        response.passMonthlyBudget ?? false,
        response.passDailyCaloriesLimit ?? false,
        response.monthlyBudgetLeft,
        response.dailyLimitLeft
    );
  }

  AllEntries(this.allEntries, this.monthlyBudget, this.dailyCaloriesLimit, this.passMonthlyBudget, this.passDailyCaloriesLimit, this.monthlyBudgetLeft, this.dailyLimitLeft);
}

class EntryMetaData {
  final int countPrevWeek;
  final int countThisWeek;

  EntryMetaData(this.countPrevWeek, this.countThisWeek);

  factory EntryMetaData.fromJson(Map json) {
     return EntryMetaData(json["countPrevWeek"], json["countThisWeek"]);
  }

}