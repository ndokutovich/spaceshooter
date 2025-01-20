import 'package:flutter/material.dart';

enum BonusType {
  damageMultiplier,
  goldOre,
}

class BonusItem {
  final BonusType type;
  final Offset position;
  final double rotation;
  final double size;

  const BonusItem({
    required this.type,
    required this.position,
    this.rotation = 0.0,
    this.size = 30.0,
  });

  BonusItem copyWith({
    BonusType? type,
    Offset? position,
    double? rotation,
    double? size,
  }) {
    return BonusItem(
      type: type ?? this.type,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
      size: size ?? this.size,
    );
  }
}
