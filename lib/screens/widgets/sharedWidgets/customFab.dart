import 'package:flutter/material.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/diamondBorder.dart';

class CustomFab extends StatefulWidget {
  final Widget child;
  final double notchMargin;
  final VoidCallback onPressed;
  final Color color;

  CustomFab({this.notchMargin: 8.0, this.onPressed, this.child, this.color});

  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      shape: DiamondBorder(),
      child: InkWell(
        customBorder: DiamondBorder(),
        onTap: widget.onPressed,
        child: Container(
          width: 56.0,
          height: 56.0,
          child: IconTheme.merge(
              data:
                  IconThemeData(color: Theme.of(context).accentIconTheme.color),
              child: widget.child),
        ),
      ),
      elevation: 5.0,
    );
  }
}
