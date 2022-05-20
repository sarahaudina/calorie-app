import 'package:calorie/movas/models/user.dart';

class UserO {
  final String id;
  final String username;
  final String role;
  final DateTime createdAt;
  final double monthlyBudget;
  final double dailyCaloryLimit;
  final double? weeklyAverage;

  UserO(this.id, this.username, this.role, this.createdAt, this.monthlyBudget, this.dailyCaloryLimit, this.weeklyAverage);

  factory UserO.fromEntity(User entity) {
    return UserO(
        entity.id,
        entity.username,
        entity.role,
        entity.createdAt,
        entity.monthlyBudget ?? 0,
        entity.dailyCaloryLimit ?? 0,
        entity.weeklyAverage ?? 0
    );
  }

}