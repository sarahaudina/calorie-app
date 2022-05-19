import 'package:calorie/config/mobile_config.dart';
import 'package:calorie/movas/services/entry/base_entry_service.dart';
import 'package:calorie/movas/services/entry/entry_service.dart';
import 'package:calorie/movas/services/http/base_http_service.dart';
import 'package:calorie/movas/services/http/dio_http_service.dart';
import 'package:dio/dio.dart';
import 'package:movas/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> serviceProviders = [
  Provider<BaseHttpService>(
    lazy: false,
    create: (context) => DioHttpService(Dio(), MobileConfig()),
  ),
  Provider<BaseEntryService>(
    lazy: false,
    create: (context) => EntryService(StaticProvider.of(context), StaticProvider.of(context)),
  )
];
