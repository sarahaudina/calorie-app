class GetEntriesResponse {
  final List map;
  final int totalItems;
  final int totalPages;
  final int itemsPerPage;
  final double? monthlyBudget;
  final double? dailyCaloriesLimit;
  final bool? passMonthlyBudget;
  final bool? passDailyCaloriesLimit;
  final double? monthlyBudgetLeft;
  final double? dailyLimitLeft;
  final double? averageInput;

  const GetEntriesResponse(this.map, this.totalItems, this.totalPages, this.itemsPerPage, this.monthlyBudget, this.dailyCaloriesLimit, this.passMonthlyBudget, this.passDailyCaloriesLimit, this.monthlyBudgetLeft, this.dailyLimitLeft, this.averageInput);

  factory GetEntriesResponse.fromMap(Map<String, dynamic> map) {
    return GetEntriesResponse(
      map['entries'],
      map['totalItems'],
      map['totalPages'],
      map['itemsPerPage'],
      map['monthlyBudget']==null ? null : map['monthlyBudget']*1.0,
      map['dailyCaloryLimit']==null ? null : map['dailyCaloryLimit']*1.0,
      map['dailyBudgetLimitLeft']==null ? null : map['dailyBudgetLimitLeft']>0 ? false : true,
      map['dailyCaloriesLimitLeft']==null ? null : map['dailyCaloriesLimitLeft']>0 ? false : true,
      map['dailyBudgetLimitLeft']==null ? null : map['dailyBudgetLimitLeft']*1.0,
      map['dailyCaloriesLimitLeft']==null ? null : map['dailyCaloriesLimitLeft']*1.0,
      map['dailyCaloriesLimitLeft']==null ? null : map['dailyCaloriesLimitLeft']*1.0
    );
  }
}

class CreateEntryResponse {

  const CreateEntryResponse();

  factory CreateEntryResponse.fromMap(Map<String, dynamic> map) {
    return CreateEntryResponse();
  }
}