import 'package:flutter/material.dart';
import 'package:health/ui/routes/routes.dart';
import 'package:health/ui/theme/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme,
      routerConfig: routerConfigs,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return widget!;
      },
    );
  }
}
