import 'package:calorie_mobile/movas/services/http/model/auth/login_request.dart';

abstract class BaseAuthService {
  Future<bool> login(LoginRequest request);
}
