import 'package:flutter/material.dart';
import 'package:toolbox/red_cross/authService.dart';
import 'package:toolbox/shared_utils/decorations.dart';
import 'package:toolbox/shared_utils/loading.dart';

class RegisterWidget extends StatefulWidget {
  final void Function(int newChildId) parentAction;

  const RegisterWidget({Key key, this.parentAction}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterWidgetState();
  }
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final AuthService _authService = AuthService();

  String error = '';
  bool loading = false;

  var _registerFormKey = GlobalKey<FormState>();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            key: ValueKey('RegisterWidget'),
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: containerWhiteBoxDecoration,
            child: Form(
              key: _registerFormKey,
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
                      Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5.0),
                          child: Text("Please fill in the register form:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 20.0)))
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (String value) {
                          RegExp regex = new RegExp(pattern);
                          if (value.isEmpty || !regex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          } else
                            return null;
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          debugPrint('Something changed in Email Text Field');
                        },
                        decoration: textInputDecoration.copyWith(
                            hintText: 'example@gmail.com', labelText: 'Email'),
                      )),
                  SizedBox(height: 15.0),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.length < 8) {
                            return 'Password must contain at least 8 characters';
                          } else
                            return null;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        onChanged: (value) {
                          debugPrint(
                              'Something changed in Password Text Field');
                        },
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Minimum of 8 characters',
                            labelText: 'Password'),
                      )),
                  SizedBox(height: 15.0),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.length < 2) {
                            return 'First name must contain at least 2 characters';
                          } else
                            return null;
                        },
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          debugPrint(
                              'Something changed in First Name Text Field');
                        },
                        decoration: textInputDecoration.copyWith(
                            hintText: 'John', labelText: 'First Name'),
                      )),
                  SizedBox(height: 15.0),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.length < 2) {
                            return 'Last name must contain at least 2 characters';
                          } else
                            return null;
                        },
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          debugPrint(
                              'Something changed in Last Name Text Field');
                        },
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Doe', labelText: 'Last Name'),
                      )),
                  SizedBox(height: 15.0),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: RaisedButton(
                        elevation: 6.0,
                        onPressed: () async {
                          if (_registerFormKey.currentState.validate()) {
                            debugPrint('Register forms are correct.');
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _authService.registerWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                    _firstNameController.text,
                                    _lastNameController.text);
                            if (result == null) {
                              debugPrint(
                                  'Error occured while registering a user with acquired email and password.');
                              setState(
                                  () => error = "Error while registering.");
                            }
                          } else
                            debugPrint('Error in register forms.');
                        },
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.red,
                        padding: EdgeInsets.all(10.0),
                        child: Text("Register", style: TextStyle(fontSize: 20)),
                      )),
                  SizedBox(height: 10.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
            ));
  }
}
