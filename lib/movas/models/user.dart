class User {
  final String id;
  final String username;
  final String role;
  final DateTime createdAt;
  final double monthlyBudget;
  final double dailyCaloryLimit;

  User(this.id, this.username, this.role, this.createdAt, this.monthlyBudget, this.dailyCaloryLimit);

  factory User.fromJson(Map json) {
    return User(
        json['id'],
        json['username'],
        json['role'], json['createdAt'], json['monthlyBudget'], json['dailyCaloryLimit']);
  }

}