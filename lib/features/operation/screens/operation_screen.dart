import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_config.dart';
import '../../../core/models/shelf_slot.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/operation_provider.dart';
import '../widgets/connection_status_badge.dart';
import '../widgets/control_buttons.dart';
import '../widgets/shelf_status_panel.dart';
import '../widgets/video_feed_panel.dart';

/// Tela principal
/// estrutura do front

class OperationScreen extends StatefulWidget {
  const OperationScreen({super.key});

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OperationProvider>().connect();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OperationProvider>();
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
              child: ConnectionStatusBadge(status: provider.connectionStatus),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (provider.lastError != null) ...[
                  MaterialBanner(
                    content: Text(provider.lastError!),
                    backgroundColor: AppTheme.statusError.withValues(alpha: 0.16),
                    actions: [
                      TextButton(
                        onPressed: provider.connect,
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
                          streamUrl: AppConfig.effectorCameraTopic,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: VideoFeedPanel(
                          title: 'Câmera do operador',
                          streamUrl: AppConfig.operatorCameraTopic,
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
                  canOperate: provider.isConnected,
                  isOperating: provider.isOperating,
                  onStart: provider.start,
                  onStop: provider.stop,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
