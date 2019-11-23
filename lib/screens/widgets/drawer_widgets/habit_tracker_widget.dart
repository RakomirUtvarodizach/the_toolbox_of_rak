import 'package:flutter/material.dart';

class HabitTrackerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HabitTrackerState();
  }
}

class _HabitTrackerState extends State<HabitTrackerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Container(
        color: Colors.pink[200],
        child: Center(
          child: Text('Habbit Tracker',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  fontSize: 37)),
        ),
      ),
    );
  }
}
