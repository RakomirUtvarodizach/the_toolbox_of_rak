import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CustomRotationTransition extends AnimatedWidget {
  const CustomRotationTransition({
    Key key,
    @required Animation<double> turns,
    this.spins,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(turns != null),
        super(key: key, listenable: turns);

  Animation<double> get turns => listenable;
  final Alignment alignment;
  final Widget child;
  final int spins;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform =
        Matrix4.rotationZ(turnsValue * pi * 2.0 * spins ?? 1);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
