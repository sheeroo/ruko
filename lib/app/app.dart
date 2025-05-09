import 'package:image_delete_demo/core/router/router.dart';
import 'package:image_delete_demo/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

final appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      theme: theme(context),
      title: 'whoami',
    );
  }
}
