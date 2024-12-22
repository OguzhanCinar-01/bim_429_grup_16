import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/provider_manager.dart';
import 'features/input/view/input_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ...ProviderManager.instance.providers,
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIM429 - Grup 16',
      theme: ThemeData.light(),
      home: const InputView(),
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
