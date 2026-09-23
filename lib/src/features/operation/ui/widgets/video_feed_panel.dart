import 'package:eq_front/src/core/themes/theme_dark.dart';
import 'package:flutter/material.dart';


class VideoFeedPanel extends StatelessWidget {
  const VideoFeedPanel({
    super.key,
    required this.title,
    this.streamUrl,
  });

  final String title;
  final String? streamUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.videocam_rounded, size: 16, color: AppTheme.neonBlue),
            const SizedBox(width: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.surfaceHigh, Color(0xFF120E1D)],
              ),
              border: Border.all(
                color: AppTheme.neonBlue.withValues(alpha: 0.35),
                width: 1.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.neonBlue.withValues(alpha: 0.12),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.videocam_off_rounded,
                  color: Colors.white38,
                  size: 34,
                ),
                const SizedBox(height: 10),
                Text(
                  'Aguardando sinal…',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white54,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
