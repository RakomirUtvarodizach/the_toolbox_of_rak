import 'package:flutter/material.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/customFab.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/diamondBorder.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/listItemWidget.dart';
import 'package:toolbox/shared_utils/testingData.dart';

import '../../../../styles.dart';

class ShoppingListEditorView extends StatefulWidget {
  @override
  _ShoppingListEditorViewState createState() => _ShoppingListEditorViewState();
}

class _ShoppingListEditorViewState extends State<ShoppingListEditorView>
    with TickerProviderStateMixin {
  List localListItems;
  AnimationController _fabController;

  @override
  void initState() {
    localListItems = TestingData().getShoppingListItems();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Hero(
          tag: "local_shopping_list",
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: localListItems.length,
            itemBuilder: (BuildContext context, int index) {
              return ListItemWidget(
                colorType: "green_comp",
                radiusType: "bl",
                listItemType: 1,
                notificationCount: index,
                sli: localListItems[index],
              );
            },
          ),
        ),
      ),
      floatingActionButton: CustomFab(
        onPressed: () {},
        color: AccentColor500,
        child: Icon(Icons.playlist_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4.0,
        color: Colors.black87,
        shape: AutomaticNotchedShape(RoundedRectangleBorder(), DiamondBorder()),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.save),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
