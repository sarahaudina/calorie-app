class User {
  final String id;
  final String username;
  final String role;
  final DateTime createdAt;
  final double? monthlyBudget;
  final double? dailyCaloryLimit;
  final double? weeklyAverage;

  User(this.id, this.username, this.role, this.createdAt, this.monthlyBudget, this.dailyCaloryLimit, this.weeklyAverage);

  factory User.fromJson(Map json) {
    return User(
        json['_id'],
        json['username'],
        json['role'],
        DateTime.parse(json['createdAt']).toLocal(),
        json['monthlyBudget']==null ? null : json['monthlyBudget']*1.0,
        json['dailyCaloryLimit']==null ? null : json['dailyCaloryLimit']*1.0,
        json['weeklyAverage']==null ? null : json['weeklyAverage']*1.0,
    );
  }

}