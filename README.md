# eq2_front — Teleoperação Kinova Gen3 Lite (Front-End Flutter)

Interface Flutter para o sistema de teleoperação híbrida do braço robótico
Kinova Gen3 Lite. Este app **não processa vídeo nem robótica** — ele apenas:

- comanda o ciclo de vida do sistema (Start/Stop) via `rosbridge_server`;
- exibe o status em tempo real da máquina de estados e do inventário da
  estante;
- exibe os dois vídeos (câmera do efetuador e webcam do operador).

## Como rodar

1. Instale o [Flutter SDK](https://docs.flutter.dev/get-started/install) (canal stable).
   O repo já vem com as pastas de plataforma `linux/` e `web/` geradas
   (`flutter create --platforms=web,linux .`), não precisa gerar de novo.
2. Baixe as dependências:

   ```bash
   flutter pub get
   ```
3. Ajuste `lib/core/config/app_config.dart` com o IP/porta reais do
   `rosbridge_server` (o padrão é `ws://localhost:9090`, válido se o
   container ROS estiver rodando na mesma máquina com portas publicadas).
4. Rode o app:

   ```bash
   flutter run -d chrome   # funciona sem dependências extra de sistema
   flutter run -d linux    # exige clang, cmake, ninja-build, pkg-config (via apt/sudo)
   ```

   Como nenhum vídeo é capturado localmente pelo app (tudo vem por rede),
   qualquer um dos dois alvos serve — Chrome é o caminho mais simples.
5. Rode os testes e a análise estática:

   ```bash
   flutter test
   flutter analyze
   ```
