import 'dart:io';

import 'package:calorie_mobile/movas/models/auth_entities.dart';
import 'package:calorie_mobile/movas/services/auth/base_auth_service.dart';
import 'package:calorie_mobile/movas/services/http/base_http_service.dart';
import 'package:calorie_mobile/movas/services/http/model/auth/login_request.dart';
import 'package:calorie_mobile/movas/services/http/model/auth/login_response.dart';
import 'package:dio/dio.dart';
import 'package:movas/movas.dart';

class AuthenticationService extends BaseAuthService {
  final BaseHttpService _httpService;
  final PublishSubject<AuthenticationE> authE;

  AuthenticationService(this._httpService, this.authE);


  @override
  Future<bool> login(LoginRequest request) async {
    final authResponse = await _httpService
        .post(
      request: request,
      converter: (response) {
        print(response);
        return LoginResponse.fromMap(response);
      },
    )
        .catchError((e) {
      throw e;
    });

    if ((authResponse as LoginResponse)?.tokenData != null) {
      return true;
    }

    return false;
  }

}
