// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:thrifter/core/common.dart';

class PaisaCard extends StatelessWidget {
  const PaisaCard({
    super.key,
    required this.child,
    this.elevation,
    this.color,
    this.shape,
  });

  final Widget child;
  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: color ?? context.surfaceVariant,
      clipBehavior: Clip.antiAlias,
      elevation: elevation ?? 2.0,
      shadowColor: color ?? context.shadow,
      child: child,
    );
  }
}

class PaisaOutlineCard extends StatelessWidget {
  const PaisaOutlineCard({
    super.key,
    required this.child,
    this.shape,
  });

  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: context.outline,
            ),
          ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: context.surface,
      shadowColor: context.shadow,
      child: child,
    );
  }
}

class PaisaFilledCard extends StatelessWidget {
  const PaisaFilledCard({
    super.key,
    required this.child,
    this.shape,
    this.color,
  });

  final Widget child;
  final Color? color;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: color ?? context.surfaceVariant,
      shadowColor: context.shadow,
      child: child,
    );
  }
}
