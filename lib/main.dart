import 'package:eq_front/src/core/di/injection.dart';
import 'package:eq_front/src/core/network/env.dart';
import 'package:eq_front/src/core/routes/app_router.dart';
import 'package:eq_front/src/core/themes/theme_dark.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Env.load();
  configureDependencies();
  runApp(const TeleopApp());
}

class TeleopApp extends StatelessWidget {
  const TeleopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Equipe 2: Projeto Kinova',
      theme: AppTheme.arcade(),
    );
  }
}
