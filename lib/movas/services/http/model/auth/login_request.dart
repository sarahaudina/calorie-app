import 'package:calorie_mobile/movas/services/http/model/base_http_request.dart';
import 'package:dio/dio.dart';

class LoginRequest extends BaseHttpRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password})
      : super(
            endpoint: "/oauth/token",
            useToken: false,
            contentType: Headers.formUrlEncodedContentType);

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      email: map['username'] as String,
      password: map['password'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.email,
      'password': this.password,
      'grant_type': '',
      'refresh_token': '',
      'scope': '',
      'client_id': '',
      'client_secret': ''
    } as Map<String, dynamic>;
  }

  LoginRequest copyWith({
    required String email,
    required String password,
  }) {
    if ((email == null || identical(email, this.email)) &&
        (password == null || identical(password, this.password))) {
      return this;
    }

    return new LoginRequest(
        email: email ?? this.email, password: password ?? this.password);
  }
}
