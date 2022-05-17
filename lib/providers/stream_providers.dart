import 'package:calorie_mobile/movas/models/auth_entities.dart';
import 'package:calorie_mobile/movas/models/entry.dart';
import 'package:movas/movas.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> streamProviders = [
  Provider<PublishSubject<AuthenticationE>>(
      lazy: false,
      create: (context) => PublishSubject<AuthenticationE>(sync: true),
      dispose: (_, stream) => stream.close()),
  Provider<PublishSubject<AllEntries>>(
      lazy: false,
      create: (context) => PublishSubject<AllEntries>(sync: true),
      dispose: (_, stream) => stream.close())
];
