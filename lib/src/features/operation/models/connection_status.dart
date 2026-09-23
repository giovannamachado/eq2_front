
enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  error;

  String get label {
    switch (this) {
      case ConnectionStatus.disconnected:
        return 'Desconectado';
      case ConnectionStatus.connecting:
        return 'Conectando...';
      case ConnectionStatus.connected:
        return 'Conectado';
      case ConnectionStatus.error:
        return 'Erro de conexão';
    }
  }
}
