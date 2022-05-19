class GetEntriesResponse {
  final List map;
  final int totalItems;
  final int totalPages;
  final int itemsPerPage;
  final double? monthlyBudget;
  final double? dailyCaloriesLimit;
  final bool? passMonthlyBudget;
  final bool? passDailyCaloriesLimit;

  const GetEntriesResponse(this.map, this.totalItems, this.totalPages, this.itemsPerPage, this.monthlyBudget, this.dailyCaloriesLimit, this.passMonthlyBudget, this.passDailyCaloriesLimit);

  factory GetEntriesResponse.fromMap(Map<String, dynamic> map) {
    return GetEntriesResponse(
      map['entries'],
      map['totalItems'],
      map['totalPages'],
      map['itemsPerPage'],
      map['monthlyBudget']==null ? null : map['monthlyBudget']*1.0,
      map['dailyCaloryLimit']==null ? null : map['dailyCaloryLimit']*1.0,
      map['dailyBudgetLimitLeft']==null ? null : map['dailyBudgetLimitLeft']>0 ? false : true,
      map['dailyCaloriesLimitLeft']==null ? null : map['dailyCaloriesLimitLeft']>0 ? false : true
    );
  }
}

class CreateEntryResponse {

  const CreateEntryResponse();

  factory CreateEntryResponse.fromMap(Map<String, dynamic> map) {
    return CreateEntryResponse();
  }
}