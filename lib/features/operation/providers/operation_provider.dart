import 'package:flutter/foundation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/models/connection_status.dart';
import '../../../core/services/rosbridge_client.dart';

///



class OperationProvider extends ChangeNotifier {
  OperationProvider({RosbridgeClient? client})
      : _client = client ?? RosbridgeClient(url: AppConfig.rosbridgeUrl) {
    _client.statusStream.listen((status) {
      _connectionStatus = status;
      notifyListeners();
    });
  }

  final RosbridgeClient _client;

  ConnectionStatus _connectionStatus = ConnectionStatus.disconnected;
  ConnectionStatus get connectionStatus => _connectionStatus;

  bool _isOperating = false;
  bool get isOperating => _isOperating;

  String? _lastError;
  String? get lastError => _lastError;

  bool get isConnected => _connectionStatus == ConnectionStatus.connected;

  Future<void> connect() async {
    _lastError = null;
    try {
      await _client.connect();
      _client.advertise(
        topic: AppConfig.lifecycleCommandTopic,
        type: 'std_msgs/msg/String',
      );
    } catch (error) {
      _lastError = 'Não foi possível conectar ao rosbridge em ${AppConfig.rosbridgeUrl}';
      notifyListeners();
    }
  }

  void start() {
    if (!isConnected) return;
    _client.publish(
      topic: AppConfig.lifecycleCommandTopic,
      message: {'data': 'start'},
    );
    _isOperating = true;
    notifyListeners();
  }

  void stop() {
    if (!isConnected) return;
    _client.publish(
      topic: AppConfig.lifecycleCommandTopic,
      message: {'data': 'stop'},
    );
    _isOperating = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _client.dispose();
    super.dispose();
  }
}
