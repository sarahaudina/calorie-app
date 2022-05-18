class GetEntriesResponse {
  final List map;
  final int totalItems;
  final int totalPages;
  final int itemsPerPage;
  final double monthlyBudget;
  final double dailyCaloriesLimit;
  final bool passMonthlyBudget;
  final bool passDailyCaloriesLimit;

  const GetEntriesResponse(this.map, this.totalItems, this.totalPages, this.itemsPerPage, this.monthlyBudget, this.dailyCaloriesLimit, this.passMonthlyBudget, this.passDailyCaloriesLimit);

  factory GetEntriesResponse.fromMap(Map<String, dynamic> map) {
    return GetEntriesResponse(
      map['entries'],
      map['totalItems'],
      map['totalPages'],
      map['itemsPerPage'],
      map[''],
      map[''],
      map[''],
      map['']
    );
  }
}

class CreateEntryResponse {

  const CreateEntryResponse();

  factory CreateEntryResponse.fromMap(Map<String, dynamic> map) {
    return CreateEntryResponse();
  }
}