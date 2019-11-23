import 'package:flutter/material.dart';
import 'package:toolbox/red_cross/authService.dart';
import 'package:toolbox/shared_utils/decorations.dart';

class WaitingForVerification extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
                child: Align(
                    child: Image(
                        image: AssetImage('images/logo_dummy.png'),
                        fit: BoxFit.fitWidth))),
            Container(
                key: ValueKey('RegisterWidget'),
                margin: EdgeInsets.only(left: 50, right: 50),
                decoration: containerWhiteBoxDecoration,
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0),
                            child: Text("Please verify your email.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 20.0))),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: RaisedButton(
                            elevation: 6.0,
                            onPressed: () async {
                              _authService.logOut();
                              debugPrint('Logging Out...');
                            },
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            color: Colors.red,
                            padding: EdgeInsets.all(10.0),
                            child:
                                Text("Log Out", style: TextStyle(fontSize: 20)),
                          )),
                      SizedBox(height: 10.0),
                    ],
                  ),
                )),
          ],
        ));
  }
}
