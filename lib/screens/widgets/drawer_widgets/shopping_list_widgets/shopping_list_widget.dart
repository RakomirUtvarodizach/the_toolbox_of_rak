import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toolbox/models/shopping_list_item.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/extraWidgets.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/listItemWidget.dart';
import 'dart:math' as math;
import 'package:toolbox/etc/styles.dart';

class ShoppingListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingListWidget>
    with TickerProviderStateMixin {
  TabController _shoppingListsController;
  AnimationController _fabController, _fabShowHideController;
  Animation<Offset> _fabShowHideOffset;
  ScrollController _scrollController;
  bool atBottom = false;
  Singleton _singleton;
  List<ShoppingListItem> sleList;
  static const List<IconData> icons = const [Icons.note_add, Icons.person_add];

  @override
  void initState() {
    debugPrint("[SLW] init state start.");
    _singleton = Singleton();
    debugPrint(
        "Singleton: ${_singleton.user.shoppingListProvider.localShoppingListItems.toString()}");
    _singleton.user.shoppingListProvider.editing = false;
    _shoppingListsController = TabController(length: 2, vsync: this);
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fabShowHideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fabShowHideOffset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, 1.0),
    ).animate(
      CurvedAnimation(
          parent: _fabShowHideController,
          curve: Curves.fastLinearToSlowEaseIn,
          reverseCurve: Curves.fastOutSlowIn),
    );
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange &&
            (_fabShowHideController.status == AnimationStatus.dismissed)) {
          atBottom = true;
          debugPrint("reach the bottom");
          if (!_fabController.isDismissed) {
            _fabController.reverse();
          }
          _fabShowHideController.forward();
        } else if (atBottom == true) {
          debugPrint("Test");
          atBottom = false;
          _fabShowHideController.reverse();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _shoppingListsController.dispose();
    _fabController.dispose();
    _scrollController.dispose();
    _fabShowHideController.dispose();
    super.dispose();
  }

  Future<void> refreshList() {
    return Future.delayed(Duration(seconds: 1), () {
      debugPrint("Refreshing list");
    });
  }

  @override
  Widget build(BuildContext context) {
    TabBar _shoppingListsTabBar = TabBar(
      labelColor: Colors.white,
      controller: _shoppingListsController,
      tabs: <Widget>[
        Tab(
          icon: Icon(Icons.folder_special),
          text: 'Local',
        ),
        Tab(
          text: 'Shared',
          icon: Icon(Icons.folder_shared),
        )
      ],
    );

    return Scaffold(
        floatingActionButton: SlideTransition(
          position: _fabShowHideOffset,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _fabController,
                  curve: Interval(0.0, 1.0 - 0 / icons.length / 2.0,
                      curve: Curves.easeOut),
                ),
                child: FloatingActionButton(
                  tooltip: "Open the local list editor",
                  heroTag: null,
                  backgroundColor: AccentColor500,
                  mini: true,
                  child: Icon(Icons.note_add, color: Colors.white),
                  onPressed: () {
                    if (_fabController.isDismissed) {
                      _fabController.forward();
                    } else {
                      _fabController.reverse();
                    }
                    Navigator.of(context)
                        .pushNamed('/shopping_list_editor_view');
                  },
                ),
              ),
            ),
            Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _fabController,
                  curve: Interval(0.0, 1.0 - 1 / icons.length / 2.0,
                      curve: Curves.easeOut),
                ),
                child: FloatingActionButton(
                  tooltip: "Create a shared list",
                  heroTag: null,
                  backgroundColor: AccentColor500,
                  mini: true,
                  child: Icon(Icons.person_add, color: Colors.white),
                  onPressed: () {
                    if (_fabController.isDismissed) {
                      _fabController.forward();
                    } else {
                      _fabController.reverse();
                    }
                    debugPrint("Sharing a list yay");
                  },
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: null,
              tooltip: "Show options",
              backgroundColor: AccentColor,
              child: AnimatedBuilder(
                animation: _fabController,
                builder: (BuildContext context, Widget child) {
                  return Transform(
                    transform: Matrix4.rotationZ(
                        _fabController.value * 0.5 * math.pi * 3.0),
                    alignment: FractionalOffset.center,
                    child: Icon(Icons.more_vert),
                  );
                },
              ),
              onPressed: () {
                if (_fabController.isDismissed) {
                  _fabController.forward();
                } else {
                  _fabController.reverse();
                }
              },
            ),
          ]),
        ),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(_shoppingListsTabBar.preferredSize.height),
          child: Container(
            decoration: BoxDecoration(color: Colors.black87),
            child: _shoppingListsTabBar,
          ),
        ),
        body: TabBarView(
          controller: _shoppingListsController,
          children: <Widget>[
            RefreshIndicator(
              onRefresh: refreshList,
              child: (_singleton.user.shoppingListProvider
                              .localShoppingListItems ==
                          null ||
                      _singleton.user.shoppingListProvider
                          .localShoppingListItems.isEmpty)
                  ? GridView.count(
                      crossAxisCount: 1,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Your local shopping list is empty.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: LightComplementaryColor600,
                                letterSpacing: 1,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                fontSize: LargeTextSize),
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _singleton.user.shoppingListProvider
                          .localShoppingListItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListItemWidget(
                          listItemType: 1,
                          notificationCount: index,
                          sli: _singleton.user.shoppingListProvider
                              .localShoppingListItems[index],
                        );
                      },
                    ),
            ),
            RefreshIndicator(
              onRefresh: refreshList,
              child: GridView.count(
                physics: const AlwaysScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: <Widget>[
                  ListItemWidget(),
                  ListItemWidget(
                    image: AssetImage("images/logo_dummy.png"),
                    name: "Elizabeth Taylor",
                    email: "elizabeth.tailor@gmail.com",
                    notificationCount: 14,
                  ),
                  ExtraWidgets(),
                  /*Badge(
                      position: BadgePosition(top: 0.0, left: 0.0),
                      badgeContent: Text('7'),
                      child: ExtraWidgets()),*/
                  /*
                  Center(
                    child: Text('Shared Shopping Liszt',
                        style: TextStyle(
                            color: Colors.orange[300],
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            fontSize: 37)),
                  ),
                  Center(
                    child: Text('Shared Shopping Liszt',
                        style: TextStyle(
                            color: Colors.lightBlue[300],
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            fontSize: 37)),
                  ),*/
                ],
              ),
            ),
          ],
        ));
  }
}
