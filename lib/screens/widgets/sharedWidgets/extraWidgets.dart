import 'package:flutter/material.dart';

class ExtraWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: RaisedButton(
                color: Colors.white,
                elevation: 12.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  debugPrint("Pressed rounded rectangle border.");
                },
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: "Something",
                  child: Image.asset(
                    'images/rolph.jpg',
                    width: 100.0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70.0,
              right: 0,
              child: FlatButton(
                padding: EdgeInsets.all(20.0),
                shape: CircleBorder(),
                onPressed: () {
                  debugPrint("Pressed positioned.");
                },
                child: Icon(
                  Icons.font_download,
                  color: Colors.green,
                  size: 30.0,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text("Food Name"), Text("Food Price")],
              ),
            ),
            Positioned(
              top: 10.0,
              left: 10.0,
              child: Container(
                padding: EdgeInsets.only(
                    top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(50.0)),
                child: Text("Discount%"),
              ),
            ),
          ],
        ),
        color: Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );
  }
}
