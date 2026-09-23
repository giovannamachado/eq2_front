import 'env.dart';


class ServerAddress {
  const ServerAddress._();

  static final String rosbridgeHost = Env.address('ROSBRIDGE_ADDRESS', 'localhost');
  static final int rosbridgePort = Env.port('ROSBRIDGE_PORT', 9090);

  /// URL do rosbridge_server
  static String get rosbridgeUrl => 'ws://$rosbridgeHost:$rosbridgePort';

  static final String videoHost = Env.address('VIDEO_SERVER_ADDRESS', 'localhost');
  static final int videoPort = Env.port('VIDEO_SERVER_PORT', 8080);

  /// URL do web_video_server
  static String get videoServerBaseUrl => 'http://$videoHost:$videoPort/stream';

  /// Nome do tópico ROS com o vídeo da câmera acoplada ao efetuador do robô.
  static const String effectorCameraTopic = '/camera/effector/image_raw';

  /// Nome do tópico ROS com o vídeo da webcam do operador.
  static const String operatorCameraTopic = '/camera/operator/image_raw';

  /// Tópico usado para publicar comandos start/stop
  static const String lifecycleCommandTopic = '/supervisor/command';

  /// Tópico assinado para receber o estado atual da máquina de estados (FSM).
  static const String systemStateTopic = '/supervisor/state';

  /// Tópico assinado para receber o status de ocupação dos 8 slots da estante.
  static const String inventoryTopic = '/vision/inventory';
}
