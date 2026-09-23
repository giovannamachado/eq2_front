import 'package:flutter/material.dart';


enum SlotState { unknown, available, occupied, selected }


class ShelfSlot {
  const ShelfSlot({
    required this.arucoId,
    this.state = SlotState.unknown,
    this.pieceColor,
  });


  final int arucoId;

  final SlotState state;


  final Color? pieceColor;

  ShelfSlot copyWith({SlotState? state, Color? pieceColor}) {
    return ShelfSlot(
      arucoId: arucoId,
      state: state ?? this.state,
      pieceColor: pieceColor ?? this.pieceColor,
    );
  }
}
