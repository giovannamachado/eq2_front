import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eq_front/src/core/di/injection.dart';
import 'package:eq_front/src/core/network/socket_client.dart';
import 'package:eq_front/src/features/operation/controllers/operation_controller.dart';
import 'package:eq_front/src/features/operation/data/datasources/supervisor_datasource.dart';
import 'package:eq_front/src/features/operation/data/repositories/supervisor_repository.dart';
import 'package:eq_front/src/features/operation/models/connection_status.dart';
import 'package:eq_front/src/features/operation/ui/screens/operation_screen.dart';

class _NoopSupervisorRepository extends SupervisorRepository {
  _NoopSupervisorRepository()
      : super(SupervisorDatasource(SocketClient(url: 'ws://test.invalid')));

  @override
  Stream<ConnectionStatus> get statusStream => const Stream.empty();

  @override
  Future<void> connect() async {}
}

void main() {
  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<OperationController>(
      OperationController(_NoopSupervisorRepository()),
    );
  });

  testWidgets('OperationScreen mostra os elementos principais', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OperationScreen()));
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
    await tester.pumpWidget(const MaterialApp(home: OperationScreen()));
    await tester.pumpAndSettle();

    final startButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Start'),
    );
    expect(startButton.onPressed, isNull);
  });
}
