import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../features/input/viewmodel/input_view_model.dart';
import '../../../features/output/viewmodel/output_view_model.dart';

class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => InputViewModel()),
    ChangeNotifierProvider(create: (context) => OutputViewModel()),
  ];
}
