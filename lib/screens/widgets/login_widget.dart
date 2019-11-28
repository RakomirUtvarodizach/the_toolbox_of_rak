import 'package:flutter/material.dart';
import 'package:toolbox/red_cross/authService.dart';
import 'package:toolbox/shared_utils/loading.dart';
import '../wrapper.dart';

class LoginWidget extends StatefulWidget {
  final void Function(int newChildId) parentAction;

  const LoginWidget({Key key, this.parentAction}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginWidgetState();
  }
}

class _LoginWidgetState extends State<LoginWidget> {
  final AuthService _authService = AuthService();
  String error = '';
  bool loading = false;

  var _loginFormKey = GlobalKey<FormState>();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            key: ValueKey('LoginWidget'),
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -10.0),
                      blurRadius: 10.0)
                ]),
            child: Form(
              key: _loginFormKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        tooltip: 'Back',
                        onPressed: () {
                          widget.parentAction(0);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      Align(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 5.0),
                              child: Text("Please fill in the login form:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 20.0))))
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (String value) {
                          RegExp regex = new RegExp(pattern);
                          if (value.isEmpty || !regex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          } else
                            return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          //debugPrint('Something changed in Email Text Field');
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lightBlue[200])),
                            hintText: 'example@gmail.com',
                            labelStyle: TextStyle(color: Colors.black54),
                            errorMaxLines: 2,
                            errorStyle: TextStyle(fontSize: 16.0),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  SizedBox(height: 15.0),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        validator: (String value) {
                          if (value.length < 8) {
                            return 'Password must contain at least 8 characters';
                          } else
                            return null;
                        },
                        onChanged: (value) {
                          //debugPrint('Something changed in Password Text Field');
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lightBlue[200])),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black54),
                            errorMaxLines: 2,
                            errorStyle: TextStyle(fontSize: 16.0),
                            hintText: 'Minimum of 8 characters',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  SizedBox(height: 15.0),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: RaisedButton(
                        elevation: 6.0,
                        onPressed: () async {
                          if (_loginFormKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _authService.logInWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);
                            if (result == null) {
                              debugPrint(
                                  'An error occured, the user with these credentials most likely does not exist.');
                              setState(() {
                                error =
                                    "Could not sign in with those credentials.";
                                loading = false;
                              });
                            } else {
                              debugPrint("Navigator would push and pop all.");
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (context) => Wrapper()),
                              //     (Route<dynamic> route) => false);
                            }
                          }
                          /*setState(() {
                        if (_loginFormKey.currentState.validate()) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DrawerHome();
                          }));
                        }
                      });*/
                          /*Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DrawerHome();
                      }));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => DrawerHome()),
                          (Route<dynamic> route) => false);*/
                        },
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        color: Colors.red,
                        padding: EdgeInsets.all(10.0),
                        child: Text("Log In", style: TextStyle(fontSize: 20)),
                      )),
                  SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
