import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:eq_front/src/core/network/socket_client.dart';
import 'package:eq_front/src/features/operation/controllers/operation_controller.dart';
import 'package:eq_front/src/features/operation/data/datasources/supervisor_datasource.dart';
import 'package:eq_front/src/features/operation/data/repositories/supervisor_repository.dart';
import 'package:eq_front/src/features/operation/models/connection_status.dart';

/// Não abre WebSocket de verdade: sobrescreve o repository pra manter o
/// controller testável sem depender de um rosbridge_server real.
class _NoopSupervisorRepository extends SupervisorRepository {
  _NoopSupervisorRepository()
      : super(SupervisorDatasource(SocketClient(url: 'ws://test.invalid')));

  final _controller = StreamController<ConnectionStatus>.broadcast();
  final List<String> sentCommands = [];

  @override
  Stream<ConnectionStatus> get statusStream => _controller.stream;

  @override
  Future<void> connect() async {
    _controller.add(ConnectionStatus.connected);
  }

  @override
  void sendCommand(String command) => sentCommands.add(command);
}

void main() {
  group('OperationController', () {
    test('começa desconectado e sem operar', () {
      final controller = OperationController(_NoopSupervisorRepository());

      expect(controller.connectionStatus.value, ConnectionStatus.disconnected);
      expect(controller.isConnected.value, isFalse);
      expect(controller.isOperating.value, isFalse);
    });

    test('connect() atualiza o status quando o repository conecta', () async {
      final repository = _NoopSupervisorRepository();
      final controller = OperationController(repository);

      await controller.connect();
      await Future<void>.delayed(Duration.zero);

      expect(controller.connectionStatus.value, ConnectionStatus.connected);
      expect(controller.isConnected.value, isTrue);
    });

    test('start()/stop() só enviam comando quando conectado', () async {
      final repository = _NoopSupervisorRepository();
      final controller = OperationController(repository);

      controller.start();
      expect(repository.sentCommands, isEmpty);

      await controller.connect();
      await Future<void>.delayed(Duration.zero);

      controller.start();
      expect(repository.sentCommands, ['start']);
      expect(controller.isOperating.value, isTrue);

      controller.stop();
      expect(repository.sentCommands, ['start', 'stop']);
      expect(controller.isOperating.value, isFalse);
    });
  });
}
