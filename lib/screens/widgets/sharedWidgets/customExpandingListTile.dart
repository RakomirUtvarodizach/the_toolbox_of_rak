import 'package:flutter/material.dart';
import 'package:toolbox/etc/styles.dart';

class CustomExpandingListTile extends StatefulWidget {
  final Widget leading, title, subtitle, trailing;
  final List<Widget> children;
  final bool initiallyExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final Color trailingIconClosedColor, trailingIconOpenColor;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final Gradient borderGradient;

  const CustomExpandingListTile({
    Key key,
    this.leading,
    @required this.title,
    this.subtitle,
    this.trailing,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.initiallyExpanded = false,
    this.trailingIconClosedColor,
    this.trailingIconOpenColor,
    this.onTap,
    this.borderRadius,
    this.borderGradient,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  @override
  _CustomExpandingListTileState createState() =>
      _CustomExpandingListTileState();
}

class _CustomExpandingListTileState extends State<CustomExpandingListTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _iconColor;

  bool _isExpanded = false;

  Gradient _borderGradient;
  BorderRadius _borderRadius;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;

    _borderGradient = widget.borderGradient ??
        LinearGradient(
            colors: [Colors.white, Colors.black],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight);

    _borderRadius = widget.borderRadius ?? BorderRadius.circular((4.0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.blueGrey.withOpacity(0.6),
                offset: Offset(1.11, 4.0),
                blurRadius: 8.0),
          ],
          gradient: _borderGradient,
          borderRadius: _borderRadius,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: _borderRadius,
            ),
            splashColor: AccentColor400.withOpacity(0.2),
            onTap: () {
              widget.onTap ?? debugPrint("InkWell from CELT tapped");
            },
            child: Column(
              children: <Widget>[
                ListTileTheme.merge(
                  iconColor: _iconColor.value,
                  child: ListTile(
                    leading: widget.leading,
                    title: widget.title,
                    subtitle: widget.subtitle,
                    trailing: RotationTransition(
                      turns: _iconTurns,
                      child: widget.children != null
                          ? IconButton(
                              icon: const Icon(Icons.expand_more),
                              onPressed: _handleTap,
                            )
                          : null,
                    ),
                  ),
                ),
                ClipRect(
                  child: Align(
                    heightFactor: _heightFactor.value,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween..end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subhead.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = widget.trailingIconClosedColor ?? theme.unselectedWidgetColor
      ..end = widget.trailingIconOpenColor ?? theme.accentColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: widget.children != null
          ? (closed ? null : Column(children: widget.children))
          : null,
    );
  }
}
