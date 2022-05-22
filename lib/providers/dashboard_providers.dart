import 'package:calorie/config/dashboard_config.dart';
import 'package:calorie/movas/services/entry/dashboard_entry_service.dart';
import 'package:provider/single_child_widget.dart';
import 'package:calorie/movas/models/entry.dart';
import 'package:movas/movas.dart';
import 'package:provider/provider.dart';
import 'package:calorie/movas/observables/entry_o.dart';
import 'package:calorie/movas/stores/entry_store.dart';
import 'package:movas/provider/provider.dart';
import 'package:calorie/movas/services/entry/base_entry_service.dart';
import 'package:calorie/movas/services/entry/mobile_entry_service.dart';
import 'package:calorie/movas/services/http/base_http_service.dart';
import 'package:calorie/movas/services/http/dio_http_service.dart';
import 'package:dio/dio.dart';

List<SingleChildWidget> dashboardProviders = [
  ...streamDashboardProviders,
  ...storeDashboardProviders,
  ...serviceDashboardProviders,
];

List<SingleChildWidget> streamDashboardProviders = [
  Provider<PublishSubject<AllEntries>>(
      lazy: false,
      create: (context) => PublishSubject<AllEntries>(sync: true),
      dispose: (_, stream) => stream.close()),
  Provider<PublishSubject<EntryMetaData>>(
      lazy: false,
      create: (context) => PublishSubject<EntryMetaData>(sync: true),
      dispose: (_, stream) => stream.close())
];

List<SingleChildWidget> storeDashboardProviders = [
  StoreProvider<AllEntriesStore, AllEntriesO>(
    storeBuilder: (context) => AllEntriesStore(StaticProvider.of(context)),
  ),
  StoreProvider<EntriesMetadataStore, EntryMetaDataO>(
    storeBuilder: (context) => EntriesMetadataStore(StaticProvider.of(context)),
  ),
];

List<SingleChildWidget> serviceDashboardProviders = [
  Provider<BaseHttpService>(
    lazy: false,
    create: (context) => DioHttpService(Dio(), DashboardConfig()),
  ),
  Provider<BaseEntryService>(
    lazy: false,
    create: (context) => DashboardEntryService(StaticProvider.of(context), StaticProvider.of(context), StaticProvider.of(context)),
  )
];
