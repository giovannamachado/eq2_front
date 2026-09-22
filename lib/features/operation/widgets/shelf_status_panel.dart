import 'package:flutter/material.dart';

import '../../../core/models/shelf_slot.dart';
import '../../../core/theme/app_theme.dart';


class ShelfStatusPanel extends StatelessWidget {
  const ShelfStatusPanel({super.key, required this.slots});

  final List<ShelfSlot> slots;

  Color _colorFor(SlotState state) {
    switch (state) {
      case SlotState.unknown:
        return AppTheme.slotUnknown;
      case SlotState.available:
        return AppTheme.slotAvailable;
      case SlotState.occupied:
        return AppTheme.slotOccupied;
      case SlotState.selected:
        return AppTheme.slotSelected;
    }
  }

  IconData _iconFor(SlotState state) {
    switch (state) {
      case SlotState.unknown:
        return Icons.help_outline_rounded;
      case SlotState.available:
        return Icons.check_circle_rounded;
      case SlotState.occupied:
        return Icons.inventory_2_rounded;
      case SlotState.selected:
        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.grid_view_rounded, size: 18, color: AppTheme.neonPurple),
            const SizedBox(width: 6),
            Text(
              'Estante',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              '· 8 posições',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white38,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              const crossAxisCount = 4;
              const spacing = 10.0;
              final rows = (slots.length / crossAxisCount).ceil();
              final cellWidth =
                  (constraints.maxWidth - (crossAxisCount - 1) * spacing) /
                      crossAxisCount;
              final cellHeight =
                  (constraints.maxHeight - (rows - 1) * spacing) / rows;
              final aspectRatio = cellHeight > 0 ? cellWidth / cellHeight : 1.0;

              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: slots.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                  childAspectRatio: aspectRatio,
                ),
                itemBuilder: (context, index) {
                  final slot = slots[index];
                  final color = _colorFor(slot.state);
                  return Container(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.4),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_iconFor(slot.state), color: color, size: 20),
                        const SizedBox(height: 4),
                        Text(
                          '#${slot.arucoId}',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: color,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
