import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:toolbox/etc/styles.dart';

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

class FlareFadeRoute extends PageRouteBuilder {
  final Widget widget;
  FlareFadeRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: Duration(milliseconds: 750),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: SplashScreen.navigate(
                name: 'assets/grow_shrink_page_transition.flr',
                next: (context) => child,
                until: () => Future.delayed(Duration(milliseconds: 500)),
                startAnimation: 'go',
                fit: BoxFit.fitHeight,
              ),
            );
          },
        );
}

class FlareRippleWidget extends StatefulWidget {
  final Widget child;
  FlareRippleWidget({Key key, this.child}) : super(key: key);

  @override
  _FlareRippleWidgetState createState() => _FlareRippleWidgetState();
}

class _FlareRippleWidgetState extends State<FlareRippleWidget> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.navigate(
      name: 'assets/grow_shrink_page_transition.flr',
      next: (context) => widget.child,
      startAnimation: 'go',
    );
  }
}
