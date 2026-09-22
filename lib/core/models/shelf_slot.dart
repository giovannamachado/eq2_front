import 'package:flutter/material.dart';

/// Status de uma posição (slot) da estante, identificada por um marcador ArUco.
enum SlotState { unknown, available, occupied, selected }

/// Um dos 8 compartimentos da estante
class ShelfSlot {
  const ShelfSlot({
    required this.arucoId,
    this.state = SlotState.unknown,
    this.pieceColor,
  });

  /// ID do marcador ArUco fixado na frente do slot.
  final int arucoId;

  final SlotState state;

  /// Cor da peça detectada no slot, quando ocupado.
  final Color? pieceColor;

  ShelfSlot copyWith({SlotState? state, Color? pieceColor}) {
    return ShelfSlot(
      arucoId: arucoId,
      state: state ?? this.state,
      pieceColor: pieceColor ?? this.pieceColor,
    );
  }
}
