import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class GrowTransition extends StatelessWidget {
  GrowTransition({@required this.child, @required this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Container(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                ),
            child: child),
      );
}
