import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/models/userSingleton.dart';
import 'package:toolbox/screens/drawer_home.dart';
import 'package:toolbox/screens/waitingForVerification.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserSingleton>(context);

    if (user == null) {
      return Home();
    } else {
      if (user.isVerified) {
        return DrawerHome();
      } else {
        return WaitingForVerification();
      }
    }
  }
}
