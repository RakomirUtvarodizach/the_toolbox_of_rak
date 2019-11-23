import 'package:flutter/material.dart';

class WeightTrackerWidget extends StatefulWidget {
  //final void Function(int newWidgetId) parentAction;
  //const NotesWidget({Key key, this.parentAction}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeightTrackerWidgetState();
  }
}

class _WeightTrackerWidgetState extends State<WeightTrackerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Container(
        color: Colors.yellow[200],
        child: Center(
          child: Text('Weight Tracker',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  fontSize: 37)),
        ),
      ),
    );
  }
}
