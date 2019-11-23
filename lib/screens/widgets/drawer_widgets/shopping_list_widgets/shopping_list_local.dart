import 'package:flutter/material.dart';
import 'package:toolbox/models/shopping_list_test_item.dart';

class ShoppingListLocal extends StatefulWidget {
  @override
  _ShoppingListLocalState createState() => _ShoppingListLocalState();
}

class _ShoppingListLocalState extends State<ShoppingListLocal> {
  var _localItems = List<ShoppingListTestItem>();

  /*_addNewItem(ShoppingListTestItem newItem) =>
      setState(() => _localItems.add(newItem));*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getLocalListView(),
    );
  }

  getLocalListView() {
    return ListView.builder(
      itemCount: _localItems.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: checkPriority(_localItems[position].getPriority),
            title: Text(_localItems[position].getItem),
            subtitle: Text(_localItems[position].getDescription),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                debugPrint('More pressed in local list.');
              },
            ),
          ),
        );
      },
    );
  }

  checkPriority(int priority) {
    if (priority == 1)
      return CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.low_priority),
      );
    else if (priority == 2)
      return CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(Icons.priority_high),
      );
  }
}
