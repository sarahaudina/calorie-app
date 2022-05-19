import 'package:calorie/providers/service_providers.dart';
import 'package:calorie/providers/store_providers.dart';
import 'package:calorie/providers/stream_providers.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> mobileProviders = [
  ...streamProviders,
  ...storeProviders,
  ...serviceProviders,
];
