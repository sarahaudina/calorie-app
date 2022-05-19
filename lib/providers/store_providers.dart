import 'package:calorie/movas/observables/entry_o.dart';
import 'package:calorie/movas/stores/entry_store.dart';
import 'package:movas/provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> storeProviders = [
  StoreProvider<AllEntriesStore, AllEntriesO>(
    storeBuilder: (context) => AllEntriesStore(StaticProvider.of(context)),
  ),
];
