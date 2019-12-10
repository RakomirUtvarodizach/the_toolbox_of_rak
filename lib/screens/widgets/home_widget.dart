import 'package:flutter/material.dart';

import '../database_testing.dart';

class HomeWidget extends StatelessWidget {
  final void Function(int newChildId) parentAction;

  const HomeWidget({Key key, this.parentAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement buil
    return Container(
        key: ValueKey('HomeWidget'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                child: Text("The Toolbox welcomes you!",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 20.0))),
            SizedBox(height: 10.0),
            RaisedButton(
              elevation: 6.0,
              onPressed: () {
                parentAction(1);
              },
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red, width: 2.0)),
              color: Colors.red,
              padding: EdgeInsets.all(10.0),
              child: Text("Log In", style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              elevation: 6.0,
              onPressed: () {
                parentAction(2);
              },
              textColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red, width: 2.0)),
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: Text("Register", style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              elevation: 6.0,
              onPressed: () {
                Navigator.of(context).pushNamed('/database_testing');
              },
              textColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue[500], width: 2.0)),
              color: Colors.yellow[500],
              padding: EdgeInsets.all(10.0),
              child: Text("Database Testing", style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10.0),
          ],
        ));
  }
}
