class FoodEntry {
  final String name;
  final String id;
  final double calories;
  final double price;
  final String userId;
  final DateTime createdAt;

  FoodEntry(this.name, this.id, this.calories, this.price, this.userId, this.createdAt);

  factory FoodEntry.fromJson(Map json) {
    return FoodEntry(
        json['name'],
        json['_id'],
        json['calories'],
        json['price']!=null? json['price']: 0,
        json['userId'],
        DateTime.parse(json['createdAt']));
  }
}

class AllEntries {
  final List<FoodEntry> allEntries;

  factory AllEntries.fromJson(List json) {
    var entries = List<FoodEntry>.from(json.map((model)=> FoodEntry.fromJson(model)));
    return AllEntries(entries);
  }

  AllEntries(this.allEntries);
}