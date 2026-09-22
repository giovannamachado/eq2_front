/// Endereços de rede do lado ROS 2 / rosbridge.
///
/// Ajustar esses  valores para o IP/porta reais
/// quando subir o `rosbridge_server` e o `web_video_server` no container.
class AppConfig {
  const AppConfig._();

  /// URL do rosbridge_server (WebSocket) usado pelo RosbridgeClient.
  static const String rosbridgeUrl = 'ws://localhost:9090';

  /// URL base do web_video_server (streams MJPEG via HTTP).
  static const String videoServerBaseUrl = 'http://localhost:8080/stream';

  /// Nome do tópico ROS com o vídeo da câmera acoplada ao efetuador do robô.
  static const String effectorCameraTopic = '/camera/effector/image_raw';

  /// Nome do tópico ROS com o vídeo da webcam do operador.
  static const String operatorCameraTopic = '/camera/operator/image_raw';

  /// Tópico usado para publicar comandos de ciclo de vida (start/stop).
  static const String lifecycleCommandTopic = '/supervisor/command';

  /// Tópico assinado para receber o estado atual da máquina de estados (FSM).
  static const String systemStateTopic = '/supervisor/state';

  /// Tópico assinado para receber o status de ocupação dos 8 slots da estante.
  static const String inventoryTopic = '/vision/inventory';
}
