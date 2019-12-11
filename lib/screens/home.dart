import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:toolbox/screens/animations/grow_transition.dart';
import 'package:toolbox/screens/widgets/login_widget.dart';
import 'package:toolbox/screens/widgets/register_widget.dart';
import 'package:toolbox/screens/widgets/home_widget.dart';
import 'package:toolbox/screens/animations/slide_in_transition.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int currentChildIndex = 0;
  Animation slideAnimation, growAnimation;
  AnimationController _animationController;

  void _changeChild(int newChildId) =>
      setState(() => currentChildIndex = newChildId);

  void toggleView() {}

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    growAnimation = Tween<double>(begin: 0, end: 640).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.7, curve: Curves.ease)));

    slideAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn)));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          if (currentChildIndex == 1 || currentChildIndex == 2) {
            setState(() => currentChildIndex = 0);
            return Future.value(false);
          } else {
            Navigator.of(context).pop(true);
            return Future.value(true);
          }
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: true,
              body: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: <Widget>[
                  GrowTransition(
                      animation: growAnimation,
                      child: Container(
                          child: Align(
                              child: Image(
                                  image: AssetImage('images/logo_dummy.png'),
                                  fit: BoxFit.fitWidth)))),
                  SlideInTransition(
                      kid: AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: currentChild()),
                      animation: slideAnimation,
                      width: width)
                ],
              )),
        ));
  }

  Widget currentChild() {
    int id = currentChildIndex;
    if (id == 0) {
      return HomeWidget(
        parentAction: _changeChild,
      );
    } else if (id == 1) {
      return LoginWidget(
        parentAction: _changeChild,
      );
    } else if (id == 2) {
      return RegisterWidget(
        parentAction: _changeChild,
      );
    } else {
      return HomeWidget(
        parentAction: _changeChild,
      );
    }
  }
}
