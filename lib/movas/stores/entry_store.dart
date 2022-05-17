import 'package:calorie_mobile/movas/models/auth_entities.dart';
import 'package:calorie_mobile/movas/models/entry.dart';
import 'package:calorie_mobile/movas/observables/authentication_observable.dart';
import 'package:calorie_mobile/movas/observables/entry_o.dart';
import 'package:movas/movas.dart';
import 'package:movas/provider/provider.dart';

class AllEntriesStore extends Store<AllEntriesO> {
  AllEntriesStore(PublishSubject<AllEntries> entries) {
    add(AllEntriesO([]));

    listen(entries, (p0) async {
      add(AllEntriesO.fromEntity(p0 as AllEntries));
    });
  }
}
