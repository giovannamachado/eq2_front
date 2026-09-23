import 'package:eq_front/src/core/di/injection.dart';
import 'package:eq_front/src/core/network/server_address.dart';
import 'package:eq_front/src/core/themes/theme_dark.dart';
import 'package:eq_front/src/features/operation/controllers/operation_controller.dart';
import 'package:eq_front/src/features/operation/models/shelf_slot.dart';
import 'package:eq_front/src/features/operation/ui/widgets/connection_status_badge.dart';
import 'package:eq_front/src/features/operation/ui/widgets/control_buttons.dart';
import 'package:eq_front/src/features/operation/ui/widgets/shelf_status_panel.dart';
import 'package:eq_front/src/features/operation/ui/widgets/video_feed_panel.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';


class OperationScreen extends StatefulWidget {
  const OperationScreen({super.key});

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  final _controller = getIt<OperationController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.connect();
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeholderSlots = List.generate(
      8,
      (index) => ShelfSlot(arucoId: index + 1),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🦾', style: TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'Teleoperação - Kinova Gen3 Lite',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: SignalBuilder(
                builder: (context) =>
                    ConnectionStatusBadge(status: _controller.connectionStatus.value),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.9, -1),
            radius: 1.6,
            colors: [Color(0xFF2A2145), AppTheme.background],
            stops: [0, 0.6],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SignalBuilder(
              builder: (context) {
                final error = _controller.lastError.value;
                final isConnected = _controller.isConnected.value;
                final isOperating = _controller.isOperating.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (error != null) ...[
                      MaterialBanner(
                        content: Text(error),
                        backgroundColor: AppTheme.statusError.withValues(alpha: 0.16),
                        actions: [
                          TextButton(
                            onPressed: _controller.connect,
                            child: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                    const Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            child: VideoFeedPanel(
                              title: 'Câmera do efetuador',
                              streamUrl: ServerAddress.effectorCameraTopic,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: VideoFeedPanel(
                              title: 'Câmera do operador',
                              streamUrl: ServerAddress.operatorCameraTopic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ShelfStatusPanel(slots: placeholderSlots),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ControlButtons(
                      canOperate: isConnected,
                      isOperating: isOperating,
                      onStart: _controller.start,
                      onStop: _controller.stop,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
