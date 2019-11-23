import 'package:flutter/material.dart';

class ToDoListWidget extends StatefulWidget {
  //final void Function(int newWidgetId) parentAction;
  //const NotesWidget({Key key, this.parentAction}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ToDoListWidgetState();
  }
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Container(
        color: Colors.green[200],
        child: Center(
          child: Text('To Do List',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  fontSize: 37)),
        ),
      ),
    );
  }
}
