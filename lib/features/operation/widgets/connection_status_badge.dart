import 'package:flutter/material.dart';

import '../../../core/models/connection_status.dart';
import '../../../core/theme/app_theme.dart';

class ConnectionStatusBadge extends StatelessWidget {
  const ConnectionStatusBadge({super.key, required this.status});

  final ConnectionStatus status;

  Color get _color {
    switch (status) {
      case ConnectionStatus.connected:
        return AppTheme.statusConnected;
      case ConnectionStatus.connecting:
        return AppTheme.statusConnecting;
      case ConnectionStatus.disconnected:
        return AppTheme.statusDisconnected;
      case ConnectionStatus.error:
        return AppTheme.statusError;
    }
  }

  IconData get _icon {
    switch (status) {
      case ConnectionStatus.connected:
        return Icons.bolt_rounded;
      case ConnectionStatus.connecting:
        return Icons.autorenew_rounded;
      case ConnectionStatus.disconnected:
        return Icons.power_off_rounded;
      case ConnectionStatus.error:
        return Icons.error_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            status.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
