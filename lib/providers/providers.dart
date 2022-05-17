import 'package:calorie_mobile/providers/service_providers.dart';
import 'package:calorie_mobile/providers/store_providers.dart';
import 'package:calorie_mobile/providers/stream_providers.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...streamProviders,
  ...storeProviders,
  ...serviceProviders,
];
