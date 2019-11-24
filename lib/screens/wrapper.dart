import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/models/userSingleton.dart';
import 'package:toolbox/red_cross/moneySaver.dart';
import 'package:toolbox/screens/waitingForVerification.dart';
import 'drawer_home.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserSingleton>(context);
    String kek = user == null ? "null" : user.readFieldsAsString();
    debugPrint("Wrapper user (kek): $kek");

    if (user == null) {
      return Home();
    } else {
      if (user.isVerified) {
        return FutureBuilder<String>(
          future: checkUpdateRelocate(user.uid),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                debugPrint("[Wrapper] ConnectionState none");

                return Center(
                  child: Text("ERROR: ConnectionState none."),
                );

              case ConnectionState.waiting:
                debugPrint("[Wrapper] ConnectionState waiting");
                return Center(
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: SpinKitWave(
                        color: Colors.red,
                        size: 50.0,
                      ),
                    ),
                  ),
                );

              case ConnectionState.active:
                debugPrint("[Wrapper] ConnectionState active");

                return Center(
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: SpinKitRipple(
                        color: Colors.red,
                        size: 50.0,
                      ),
                    ),
                  ),
                );

              case ConnectionState.done:
                debugPrint("[Wrapper] ConnectionState done");
                if (snapshot.hasError) {
                  return Center(
                    child: Text("[Wrapper] Error: ${snapshot.error}"),
                  );
                } else {
                  String resultOfSnapshot = snapshot.data;
                  debugPrint("[Wrapper] $resultOfSnapshot.");
                  if (snapshot.data == "success" ||
                      snapshot.data == "not_null_open_drawer") {
                    return DrawerHome();
                  } else if (snapshot.data == "error_with_user_at_firestore") {
                    return Center(
                      child: Text("Error with user at firestore."),
                    );
                  } else {
                    return Center(
                      child: Text("[Wrapper] Data Error: $resultOfSnapshot"),
                    );
                  }
                }
            }
            return Center(
              child: Text("Unreachable error."),
            );
          },
        );
      } else {
        return WaitingForVerification();
      }
    }
  }

  Future<String> checkUpdateRelocate(String uid) async {
    Singleton _singleton = Singleton();
    if (_singleton.user == null || _singleton.user.checkIfNull()) {
      debugPrint("[Wrapper] Inside checkUpdateRelocate important if.");
      bool yesno = await MoneySaver().updateSingletonUser("users", uid);
      debugPrint(
          "[Wrapper] Money Saver update singleton user result -> $yesno");
      if (yesno) {
        return "success";
      } else {
        return "error_with_user_at_firestore";
      }
    } else {
      return "not_null_open_drawer";
    }
  }
}
