import 'dart:convert';

import 'package:calorie_mobile/movas/models/auth_entities.dart';

class AuthenticationO {
  final String token;

  AuthenticationO({required this.token});

  bool get isLoggedIn {
    if (token == null) return false;
    return true;
  }

  factory AuthenticationO.fromEntity(AuthenticationE entity) {
    return AuthenticationO(token: entity.token);
  }

}
