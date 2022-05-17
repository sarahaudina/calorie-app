import 'package:calorie_mobile/movas/models/auth_entities.dart';
import 'package:calorie_mobile/movas/observables/authentication_observable.dart';
import 'package:movas/movas.dart';
import 'package:movas/provider/provider.dart';

class AuthStore extends Store<AuthenticationO> {
  AuthStore(PublishSubject<AuthenticationE> authE) {
    listen(authE, (p0) async {
      add(AuthenticationO.fromEntity(p0 as AuthenticationE));
    });
  }
}
