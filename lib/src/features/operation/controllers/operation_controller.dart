import 'package:signals/signals.dart';

import '../../../core/network/server_address.dart';
import '../../../shared/errors/app_exception.dart';
import '../data/repositories/supervisor_repository.dart';
import '../models/connection_status.dart';


class OperationController {
  OperationController(this._repository) {
    _repository.statusStream.listen((status) {
      connectionStatus.value = status;
    });
  }

  final SupervisorRepository _repository;

  final connectionStatus = signal<ConnectionStatus>(ConnectionStatus.disconnected);
  final isOperating = signal<bool>(false);
  final lastError = signal<String?>(null);

  late final isConnected = computed(
    () => connectionStatus.value == ConnectionStatus.connected,
  );

  Future<void> connect() async {
    lastError.value = null;
    try {
      await _repository.connect();
    } on AppException catch (e) {
      lastError.value = '${e.message} em ${ServerAddress.rosbridgeUrl}';
    }
  }

  void start() {
    if (!isConnected.value) return;
    _repository.sendCommand('start');
    isOperating.value = true;
  }

  void stop() {
    if (!isConnected.value) return;
    _repository.sendCommand('stop');
    isOperating.value = false;
  }

  Future<void> dispose() => _repository.dispose();
}
