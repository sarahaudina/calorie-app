import 'package:calorie_mobile/movas/models/user.dart';

class UserO {
  final String id;
  final String username;
  final String role;
  final DateTime createdAt;
  final double monthlyBudget;
  final double dailyCaloryLimit;

  UserO(this.id, this.username, this.role, this.createdAt, this.monthlyBudget, this.dailyCaloryLimit);

  factory UserO.fromEntity(User entity) {
    return UserO(
        entity.id,
        entity.username,
        entity.role,
        entity.createdAt,
        entity.monthlyBudget,
        entity.dailyCaloryLimit
    );
  }

}