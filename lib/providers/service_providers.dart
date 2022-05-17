import 'package:calorie_mobile/movas/services/auth/auth_service.dart';
import 'package:calorie_mobile/movas/services/auth/base_auth_service.dart';
import 'package:calorie_mobile/movas/services/entry/base_entry_service.dart';
import 'package:calorie_mobile/movas/services/entry/entry_service.dart';
import 'package:calorie_mobile/movas/services/http/base_http_service.dart';
import 'package:calorie_mobile/movas/services/http/dio_http_service.dart';
import 'package:dio/dio.dart';
import 'package:movas/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> serviceProviders = [
  Provider<BaseHttpService>(
    lazy: false,
    create: (context) => DioHttpService(Dio(), StaticProvider.of(context)),
  ),
  Provider<BaseAuthService>(
    lazy: false,
    create: (context) => AuthenticationService(StaticProvider.of(context), StaticProvider.of(context)),
  ),
  Provider<BaseEntryService>(
    lazy: false,
    create: (context) => EntryService(StaticProvider.of(context), StaticProvider.of(context)),
  )
];
