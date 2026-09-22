import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Botões de Start/Stop descritos na seção 2.4 (Front-End) e no RF#01.
class ControlButtons extends StatelessWidget {
  const ControlButtons({
    super.key,
    required this.canOperate,
    required this.isOperating,
    required this.onStart,
    required this.onStop,
  });

  final bool canOperate;
  final bool isOperating;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: canOperate && !isOperating ? onStart : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.neonGreen,
              foregroundColor: const Color(0xFF0B2A22),
              disabledBackgroundColor: Colors.white12,
              disabledForegroundColor: Colors.white30,
              elevation: 6,
              shadowColor: AppTheme.neonGreen.withValues(alpha: 0.5),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Start'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.icon(
            onPressed: canOperate && isOperating ? onStop : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.neonRed,
              foregroundColor: const Color(0xFF330615),
              disabledBackgroundColor: Colors.white12,
              disabledForegroundColor: Colors.white30,
              elevation: 6,
              shadowColor: AppTheme.neonRed.withValues(alpha: 0.5),
            ),
            icon: const Icon(Icons.stop_rounded),
            label: const Text('Stop'),
          ),
        ),
      ],
    );
  }
}
