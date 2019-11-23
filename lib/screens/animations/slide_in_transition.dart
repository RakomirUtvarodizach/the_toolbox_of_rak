import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class SlideInTransition extends StatelessWidget {
  SlideInTransition(
      {@required this.kid,
      @required this.animation,
      this.width,
      this.height,
      this.depth});

  final Widget kid;
  final Animation<double> animation;
  final double width, height, depth;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
          child: Transform(
              transform: Matrix4.translationValues(
                  animation.value * (width ?? 0.0),
                  animation.value * (height ?? 0.0),
                  animation.value * (depth ?? 0.0)),
              child: kid)),
      child: kid,
    );
  }
}
