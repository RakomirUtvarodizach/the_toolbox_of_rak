import 'package:flutter/widgets.dart';
import 'package:toolbox/etc/styles.dart';
import 'package:toolbox/screens/animations/grow_transition.dart';

class SlideRightFadeRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightFadeRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}

class TestingRoute extends PageRouteBuilder {
  final Widget widget;
  TestingRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInQuad),
              ),
              child: RotationTransition(
                turns: Tween<double>(begin: 0.0, end: 2.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInQuad),
                ),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
            );
          },
        );
}

class GrowShrinkRoute extends PageRouteBuilder {
  final Widget widget;
  GrowShrinkRoute({this.widget})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              final double height = MediaQuery.of(context).size.height;
              final Animation<double> circleGrow =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.0, 0.5, curve: Curves.easeInQuad),
                ),
              );
              final Animation<double> circleShrink =
                  Tween<double>(begin: 1.0, end: 0.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.6, 1.0, curve: Curves.easeInQuad),
                ),
              );
              final Animation<double> widgetOpacity =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.5, 0.6, curve: Curves.easeInQuad),
                ),
              );
              return Stack(
                children: <Widget>[
                  FadeTransition(opacity: widgetOpacity, child: widget),
                  ScaleTransition(
                    scale: circleGrow,
                    child: ScaleTransition(
                      scale: circleShrink,
                      child: Align(
                        child: Transform.scale(
                          scale: 3.0,
                          child: Container(
                            height: height,
                            width: height,
                            decoration: BoxDecoration(
                                color: AccentColor, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
}
