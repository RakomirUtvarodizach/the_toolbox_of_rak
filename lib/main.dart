import 'package:flutter/material.dart';
import 'package:toolbox/models/userSingleton.dart';
import 'package:toolbox/red_cross/authService.dart';
import 'package:toolbox/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/styles.dart';

void main() {
  runApp(ToolboxRun());
}

class ToolboxRun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserSingleton>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Toolbox',
        home: SafeArea(
          child: Wrapper(),
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: PrimaryColor,
            accentColor: AccentColor,
            scaffoldBackgroundColor: LightColor,
            textTheme:
                Theme.of(context).textTheme.apply(fontFamily: FontNameDefault)),
      ),
    );
  }
}
