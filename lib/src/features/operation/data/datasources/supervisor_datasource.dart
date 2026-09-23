import '../../../../core/network/server_address.dart';
import '../../../../core/network/socket_client.dart';
import '../../models/connection_status.dart';


class SupervisorDatasource {
  SupervisorDatasource(this._client);

  final SocketClient _client;

  Stream<ConnectionStatus> get statusStream => _client.statusStream;

  Future<void> connect() async {
    await _client.connect();
    _client.advertise(
      topic: ServerAddress.lifecycleCommandTopic,
      type: 'std_msgs/msg/String',
    );
  }

  void sendCommand(String command) {
    _client.publish(
      topic: ServerAddress.lifecycleCommandTopic,
      message: {'data': command},
    );
  }

  Future<void> dispose() => _client.dispose();
}
