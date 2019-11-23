import 'package:flutter/material.dart';

class NotesWidget extends StatefulWidget {
  //final void Function(int newWidgetId) parentAction;
  //const NotesWidget({Key key, this.parentAction}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotesWidgetState();
  }
}

class _NotesWidgetState extends State<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Container(
        color: Colors.blue[200],
        child: Center(
          child: Text('Notes',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  fontSize: 37)),
        ),
      ),
    );
  }
}
