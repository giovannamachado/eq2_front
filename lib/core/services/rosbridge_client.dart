import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/connection_status.dart';

/// Aqui abre a conexão, manda mensagem, escuta resposta.

class RosbridgeClient {
  RosbridgeClient({required this.url});

  final String url;

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;

  final StreamController<ConnectionStatus> _statusController =
      StreamController<ConnectionStatus>.broadcast();

  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<ConnectionStatus> get statusStream => _statusController.stream;

  ConnectionStatus _status = ConnectionStatus.disconnected;
  ConnectionStatus get status => _status;

  Future<void> connect() async {
    _emitStatus(ConnectionStatus.connecting);
    try {
      final channel = WebSocketChannel.connect(Uri.parse(url));
      await channel.ready;
      _channel = channel;

      _subscription = channel.stream.listen(
        _onData,
        onError: (Object _) => _emitStatus(ConnectionStatus.error),
        onDone: () => _emitStatus(ConnectionStatus.disconnected),
        cancelOnError: true,
      );

      _emitStatus(ConnectionStatus.connected);
    } catch (_) {
      _emitStatus(ConnectionStatus.error);
      rethrow;
    }
  }

  void _onData(dynamic raw) {
    final decoded = jsonDecode(raw as String) as Map<String, dynamic>;
    _messageController.add(decoded);
  }

  void _emitStatus(ConnectionStatus status) {
    _status = status;
    _statusController.add(status);
  }


  Stream<Map<String, dynamic>> subscribe({
    required String topic,
    required String type,
  }) {
    _send({'op': 'subscribe', 'topic': topic, 'type': type});
    return _messageController.stream
        .where((event) => event['topic'] == topic)
        .map((event) => event['msg'] as Map<String, dynamic>);
  }

  void unsubscribe(String topic) {
    _send({'op': 'unsubscribe', 'topic': topic});
  }

  void advertise({required String topic, required String type}) {
    _send({'op': 'advertise', 'topic': topic, 'type': type});
  }

  void publish({required String topic, required Map<String, dynamic> message}) {
    _send({'op': 'publish', 'topic': topic, 'msg': message});
  }

  void _send(Map<String, dynamic> payload) {
    final channel = _channel;
    if (channel == null) {
      throw StateError('RosbridgeClient: chame connect() antes de usar o canal.');
    }
    channel.sink.add(jsonEncode(payload));
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    await _channel?.sink.close();
    await _statusController.close();
    await _messageController.close();
  }
}
