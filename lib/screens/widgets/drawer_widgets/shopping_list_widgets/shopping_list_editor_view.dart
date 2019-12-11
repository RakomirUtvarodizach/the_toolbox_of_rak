import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:toolbox/etc/styles.dart';
import 'package:toolbox/models/shopping_list_item.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/screens/widgets/drawer_widgets/shopping_list_widgets/shopping_list_editor.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/customFab.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/diamondBorder.dart';

class ShoppingListEditorView extends StatefulWidget {
  @override
  _ShoppingListEditorViewState createState() => _ShoppingListEditorViewState();
}

class _ShoppingListEditorViewState extends State<ShoppingListEditorView>
    with TickerProviderStateMixin {
  List<ShoppingListItem> _localListItems;
  List<String> _types = ["Food", "Chemicals", "Cosmetics", "Clothes"];
  List<String> _priorities = ["Low", "Medium", "High"];
  List<HashMap<String, dynamic>> _liveEditingOfListItems = List();
  Singleton _singleton;

  @override
  void initState() {
    _singleton = Singleton();
    _localListItems =
        _singleton.user.shoppingListProvider.localShoppingListItems;
    if (_localListItems != null) {
      for (var i = 0; i < _localListItems.length; i++) {
        //
        HashMap newListItem = HashMap<String, dynamic>();
        newListItem['type'] = _localListItems[i].type;
        newListItem['priority'] = convertPriority(_localListItems[i].priority);
        var titleTextEditingController =
            new TextEditingController(text: (_localListItems[i].title));
        newListItem['title_controller'] = titleTextEditingController;
        var descriptionTextEditingController =
            new TextEditingController(text: (_localListItems[i].description));
        newListItem['description_controller'] =
            descriptionTextEditingController;
        _liveEditingOfListItems.add(newListItem);
        debugPrint(
            'Element $i: \n\tType-> ${_liveEditingOfListItems[i]['type']},\n\tPriority-> ${_liveEditingOfListItems[i]['priority']},\n\tTitle-> ${_liveEditingOfListItems[i]['title_controller'].text},\n\tDescription-> ${_liveEditingOfListItems[i]['description_controller'].text}');
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < _liveEditingOfListItems.length; i++) {
      _liveEditingOfListItems[i]['title_controller'].dispose();
      _liveEditingOfListItems[i]['description_controller'].dispose();
    }
    super.dispose();
  }

  String convertPriority(int priorityNumber) {
    switch (priorityNumber) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
        break;
      default:
        return 'Low';
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Go Back?"),
            content: Text("You will lose all progress from this edit session."),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              FlatButton(
                child: Text("Back"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          _showDialog();
          return Future.value(false);
        },
        child: Scaffold(
          body: (_localListItems == null || _localListItems.isEmpty)
              ? Center(
                  child: Text(
                    "No items have been added yet. Please add some.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: LightComplementaryColor600,
                        letterSpacing: 1,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        fontSize: LargeTextSize),
                  ),
                )
              : Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _localListItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      //
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 4.0),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(54.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(54.0),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 4.0),
                              Align(
                                child: DropdownButton(
                                  hint: Text("Please choose a type:"),
                                  value: _liveEditingOfListItems[index]['type'],
                                  onChanged: (newValue) {
                                    setState(() {
                                      _liveEditingOfListItems[index]['type'] =
                                          newValue;
                                      debugPrint(
                                          "DropDown Type Value of Index $index: ${_liveEditingOfListItems[index]['priority']}");
                                    });
                                  },
                                  items: _types.map((itemType) {
                                    return DropdownMenuItem(
                                        child: Text(itemType), value: itemType);
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Align(
                                child: DropdownButton(
                                  hint:
                                      Text("Please choose the priority level:"),
                                  value: _liveEditingOfListItems[index]
                                      ['priority'],
                                  onChanged: (newValue) {
                                    setState(() {
                                      _liveEditingOfListItems[index]
                                          ['priority'] = newValue;
                                      debugPrint(
                                          "DropDown Priority Value of Index $index: ${_liveEditingOfListItems[index]['priority']}");
                                    });
                                  },
                                  items: _priorities.map((itemType) {
                                    return DropdownMenuItem(
                                        child: Text(itemType), value: itemType);
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              TextField(
                                controller: _liveEditingOfListItems[index]
                                    ['title_controller'],
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  debugPrint('Description: $value');
                                },
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightBlue[200])),
                                    hintText: 'Jogurt',
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    errorMaxLines: 2,
                                    errorStyle: TextStyle(fontSize: 16.0),
                                    labelText: 'Title',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              TextField(
                                controller: _liveEditingOfListItems[index]
                                    ['description_controller'],
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  debugPrint('Description: $value');
                                },
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightBlue[200])),
                                    hintText: 'Granice, molicu lepo.',
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    errorMaxLines: 2,
                                    errorStyle: TextStyle(fontSize: 16.0),
                                    labelText: 'Description',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          floatingActionButton: CustomFab(
            onPressed: () {
              debugPrint("Going to create a new item.");
              Navigator.of(context).pushNamed('/shopping_list_editor');
            },
            color: AccentColor500,
            child: Icon(Icons.playlist_add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            notchMargin: 4.0,
            color: Colors.black87,
            shape: AutomaticNotchedShape(
                RoundedRectangleBorder(), DiamondBorder()),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  tooltip: "Back",
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _showDialog();
                    //Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  tooltip: "Save",
                  color: Colors.white,
                  icon: Icon(Icons.save),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
