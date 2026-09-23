import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Carrega o arquivo `.env` e dá acesso seguro às variáveis nele definidas.
///
/// Se o `.env` ainda não existir na máquina (ele não sobe no git — copie
/// `sample.env` pra `.env`), o app não trava: cada valor cai no `fallback`.
class Env {
  const Env._();

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      // Sem .env ainda: segue com os valores padrão de sample.env.
    }
  }

  static String address(String key, String fallback) {
    if (!dotenv.isInitialized) return fallback;
    return dotenv.env[key] ?? fallback;
  }

  static int port(String key, int fallback) {
    if (!dotenv.isInitialized) return fallback;
    final raw = dotenv.env[key];
    if (raw == null) return fallback;
    return int.tryParse(raw) ?? fallback;
  }
}
