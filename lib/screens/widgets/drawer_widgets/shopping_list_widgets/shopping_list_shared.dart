import 'package:flutter/material.dart';

class ShoppingListShared extends StatefulWidget {
  ShoppingListShared({Key key}) : super(key: key);

  @override
  _ShoppingListSharedState createState() => _ShoppingListSharedState();
}

class _ShoppingListSharedState extends State<ShoppingListShared> {
  int sharedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(child: sharedListView());
  }

  sharedListView() {
    return ListView.builder(
      itemCount: sharedCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text('A'),
            ),
            title: Text('This is a shared title.'),
            subtitle: Text('This is a shared subtitle.'),
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                debugPrint('Shared down button pressed.');
              },
            ),
          ),
        );
      },
    );
  }
}
