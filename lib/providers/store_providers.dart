import 'package:calorie_mobile/movas/observables/authentication_observable.dart';
import 'package:calorie_mobile/movas/observables/entry_o.dart';
import 'package:calorie_mobile/movas/stores/auth_store.dart';
import 'package:calorie_mobile/movas/stores/entry_store.dart';
import 'package:movas/provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> storeProviders = [
  StoreProvider<AuthStore, AuthenticationO>(
    storeBuilder: (context) => AuthStore(StaticProvider.of(context)),
  ),
  StoreProvider<AllEntriesStore, AllEntriesO>(
    storeBuilder: (context) => AllEntriesStore(StaticProvider.of(context)),
  ),
];
