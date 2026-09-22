import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:eq_front/features/operation/providers/operation_provider.dart';
import 'package:eq_front/features/operation/screens/operation_screen.dart';


class _NoopOperationProvider extends OperationProvider {
  @override
  Future<void> connect() async {}
}

void main() {
  testWidgets('OperationScreen mostra os elementos principais', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<OperationProvider>(
        create: (_) => _NoopOperationProvider(),
        child: const MaterialApp(home: OperationScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Teleoperação - Kinova Gen3 Lite'), findsOneWidget);
    expect(find.text('Desconectado'), findsOneWidget);
    expect(find.text('Câmera do efetuador'), findsOneWidget);
    expect(find.text('Câmera do operador'), findsOneWidget);
    expect(find.text('Estante'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Start'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Stop'), findsOneWidget);
  });

  testWidgets('Start/Stop ficam desabilitados enquanto desconectado', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<OperationProvider>(
        create: (_) => _NoopOperationProvider(),
        child: const MaterialApp(home: OperationScreen()),
      ),
    );
    await tester.pumpAndSettle();

    final startButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Start'),
    );
    expect(startButton.onPressed, isNull);
  });
}
