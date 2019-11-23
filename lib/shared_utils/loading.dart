import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          debugPrint("Popping off from loading");
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Logging in, please wait.'),
            ),
          );
          return Future.value(false);
        },
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Center(
            child: SpinKitPouringHourglass(
              color: Colors.red,
              size: 50.0,
            ),
          ),
        ));
  }
}
