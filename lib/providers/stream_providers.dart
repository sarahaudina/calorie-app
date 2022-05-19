import 'package:calorie/movas/models/entry.dart';
import 'package:movas/movas.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> streamProviders = [
  Provider<PublishSubject<AllEntries>>(
      lazy: false,
      create: (context) => PublishSubject<AllEntries>(sync: true),
      dispose: (_, stream) => stream.close())
];
