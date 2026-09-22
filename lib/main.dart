import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/operation/providers/operation_provider.dart';
import 'features/operation/screens/operation_screen.dart';

void main() {
  runApp(const TeleopApp());
}

class TeleopApp extends StatelessWidget {
  const TeleopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OperationProvider(),
      child: MaterialApp(
        title: 'Equipe 2: Projeto Kinova',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.arcade(),
        home: const OperationScreen(),
      ),
    );
  }
}
