import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:toolbox/etc/styles.dart';
import 'package:toolbox/models/shopping_list_item.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/customFab.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/diamondBorder.dart';

import '../../../../red_cross/moneySaver.dart';
import '../../../../red_cross/secureStorageAttic.dart';

class ShoppingListEditorView extends StatefulWidget {
  @override
  _ShoppingListEditorViewState createState() => _ShoppingListEditorViewState();
}

class _ShoppingListEditorViewState extends State<ShoppingListEditorView>
    with TickerProviderStateMixin {
  List<String> _types = ["Food", "Chemicals", "Cosmetics", "Clothes"];
  List<String> _priorities = ["Low", "Medium", "High"];
  List<HashMap<String, dynamic>> _liveEditingOfListItems = List();
  Singleton _singleton = Singleton();
  List<ShoppingListItem> slevList;

  @override
  void initState() {
    debugPrint("[SLEV] Init state start.");
    debugPrint(
        "[SLEV] BEFORE IF ${_singleton.user.shoppingListProvider.localShoppingListItems.toString()}");
    if (!_singleton.user.shoppingListProvider.editing) {
      debugPrint(
          "[SLE] BEFORE THE SHIT ${_singleton.user.shoppingListProvider.localShoppingListItems.toString()}");
      debugPrint(
          "[SLE] Before, but for items being removed ${_singleton.user.shoppingListProvider.itemsBeingEdited.toString()}");
      slevList = _singleton.user.shoppingListProvider.itemsBeingEdited;
      if (slevList == null) {
        slevList = [];
      } else {
        slevList.clear();
      }
      debugPrint(
          "[SLE] After if else ${_singleton.user.shoppingListProvider.itemsBeingEdited.toString()}");
      var tempLocal =
          _singleton.user.shoppingListProvider.localShoppingListItems;
      slevList.addAll(tempLocal);
      debugPrint(
          "[SLE] AFTER THE SHIT ${_singleton.user.shoppingListProvider.localShoppingListItems.toString()}");
      _singleton.user.shoppingListProvider.editing = true;
      _liveEditingOfListItems = List();
      if (slevList != null && slevList.length > 0) {
        for (var i = 0; i < slevList.length; i++) {
          HashMap newListItem = HashMap<String, dynamic>();
          newListItem['type'] = slevList[i].type;
          newListItem['priority'] = convertPriority(slevList[i].priority);
          var titleTextEditingController =
              new TextEditingController(text: (slevList[i].title));
          newListItem['title_controller'] = titleTextEditingController;
          var descriptionTextEditingController =
              new TextEditingController(text: (slevList[i].description));
          newListItem['description_controller'] =
              descriptionTextEditingController;
          _liveEditingOfListItems.add(newListItem);
          debugPrint(
              "[SLE] AFTER INIT ${_singleton.user.shoppingListProvider.localShoppingListItems.toString()}");
        }
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
    debugPrint("{}{}{}{}{}{} Editing is done");
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
      default:
        return 'Low';
    }
  }

  int returnPriority(String currentPriority) {
    switch (currentPriority) {
      case "Low":
        return 1;
      case "Medium":
        return 2;
      case "High":
        return 3;
      default:
        return 1;
    }
  }

  // void refreshThisList() {
  //   bool _navStatus = _singleton.user.shoppingListProvider.isEditing;
  //   debugPrint(
  //       "[SLEV] user -> ${_singleton.user.uid}\n\tshopping list provider -> ${_singleton.user.shoppingListProvider.recentItems.length}\n\tlocal shopping list items -> ${_singleton.user.shoppingListProvider.localShoppingListItems}\n\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

  //   if (_navStatus) {
  //     debugPrint("{}}{{}{}{}{}{} Editing in progress");
  //     _localListItems = _singleton.user.shoppingListProvider.itemsBeingEdited;
  //   } else {
  //     debugPrint("{}{}{}{}{}{}{} Editing starting");
  //     _singleton.user.shoppingListProvider.itemsBeingEdited =
  //         _singleton.user.shoppingListProvider.localShoppingListItems;
  //     _localListItems = _singleton.user.shoppingListProvider.itemsBeingEdited;
  //     debugPrint("Local Items -> ${_localListItems.length}");
  //     _singleton.user.shoppingListProvider.isEditing = true;
  //   }
  // }

  // void updateLiveEditing(int ii) {
  //   debugPrint("ii -> $ii");
  //   HashMap newListItem = HashMap<String, dynamic>();
  //   int i;
  //   if (ii == -1) {
  //     i = _localListItems.length - 1;
  //   } else {
  //     i = ii;
  //   }
  //   debugPrint("just i -> $i");
  // newListItem['type'] = _localListItems[i].type;
  // newListItem['priority'] = convertPriority(_localListItems[i].priority);
  // var titleTextEditingController =
  //     new TextEditingController(text: (_localListItems[i].title));
  // newListItem['title_controller'] = titleTextEditingController;
  // var descriptionTextEditingController =
  //     new TextEditingController(text: (_localListItems[i].description));
  // newListItem['description_controller'] = descriptionTextEditingController;
  // _liveEditingOfListItems.add(newListItem);
  //   debugPrint(
  //       'Element $i: \n\tType-> ${_liveEditingOfListItems[i]['type']},\n\tPriority-> ${_liveEditingOfListItems[i]['priority']},\n\tTitle-> ${_liveEditingOfListItems[i]['title_controller'].text},\n\tDescription-> ${_liveEditingOfListItems[i]['description_controller'].text}');
  // }

  Color colourize(int index) {
    switch (2) {
      // Needs tinkering
      case 0:
        return Colors.white;
      case -1:
        return Colors.red[200];
      case 2:
        return Colors.green[200];
      default:
        return Colors.white;
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
          body: (slevList == null || slevList.isEmpty)
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
                    itemCount: slevList.length,
                    itemBuilder: (BuildContext context, int index) {
                      //
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          setState(() {
                            //debugPrint("direction->$direction");
                            int tempIndex = index;
                            _liveEditingOfListItems.removeAt(tempIndex);
                            slevList.removeAt(tempIndex);
                          });
                        },
                        child: Card(
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
                                    value: _liveEditingOfListItems[index]
                                        ['type'],
                                    onChanged: (newValue) {
                                      setState(() {
                                        _liveEditingOfListItems[index]['type'] =
                                            newValue;
                                        // debugPrint(
                                        //     "DropDown Type Value of Index $index: ${_liveEditingOfListItems[index]['priority']}");
                                      });
                                    },
                                    items: _types.map((itemType) {
                                      return DropdownMenuItem(
                                          child: Text(itemType),
                                          value: itemType);
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Align(
                                  child: DropdownButton(
                                    hint: Text(
                                        "Please choose the priority level:"),
                                    value: _liveEditingOfListItems[index]
                                        ['priority'],
                                    onChanged: (newValue) {
                                      setState(() {
                                        _liveEditingOfListItems[index]
                                            ['priority'] = newValue;
                                        // debugPrint(
                                        //     "DropDown Priority Value of Index $index: ${_liveEditingOfListItems[index]['priority']}");
                                      });
                                    },
                                    items: _priorities.map((itemType) {
                                      return DropdownMenuItem(
                                          child: Text(itemType),
                                          value: itemType);
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: _liveEditingOfListItems[index]
                                      ['title_controller'],
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    //debugPrint('Description: $value');
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
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: _liveEditingOfListItems[index]
                                      ['description_controller'],
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    //debugPrint('Description: $value');
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
                        ),
                      );
                    },
                  ),
                ),
          floatingActionButton: CustomFab(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/shopping_list_editor')
                  .then((_) {
                setState(() {
                  debugPrint(
                      "[SLEV] ${_singleton.user.shoppingListProvider.localShoppingListItems.toString()}");
                  if (_singleton.user.shoppingListProvider.newEditingItem !=
                      null) {
                    debugPrint(
                        "[SLEV] slevlist BEFORE adding item: ${slevList.toString()}");
                    slevList.add(
                        _singleton.user.shoppingListProvider.newEditingItem);
                    debugPrint(
                        "[SLEV] slevlist AFTER adding item: ${slevList.toString()}");
                    for (var i = 0; i < slevList.length; i++) {
                      debugPrint(
                          "[SLEV] slevlist item no. $i -> ${slevList[i].toJson()}");
                    }

                    int i = slevList.length - 1;
                    HashMap newListItem = HashMap<String, dynamic>();
                    newListItem['type'] = slevList[i].type;
                    newListItem['priority'] =
                        convertPriority(slevList[i].priority);
                    var titleTextEditingController =
                        new TextEditingController(text: (slevList[i].title));
                    newListItem['title_controller'] =
                        titleTextEditingController;
                    var descriptionTextEditingController =
                        new TextEditingController(
                            text: (slevList[i].description));
                    newListItem['description_controller'] =
                        descriptionTextEditingController;
                    _liveEditingOfListItems.add(newListItem);
                    _singleton.user.shoppingListProvider.newEditingItem = null;
                    //TODO TESTING SLEV AND ITEMS BEING EDITED
                    // debugPrint(
                    //     "[SLE] ITEMS BEING EDITED BEFORE SLEV -> ${_singleton.user.shoppingListProvider.itemsBeingEdited.toString()}");
                    // _singleton.user.shoppingListProvider.itemsBeingEdited
                    //     .addAll(slevList);
                    // debugPrint(
                    //     "[SLE] ITEMS BEING EDITED AFTER SLEV ADDALL-> ${_singleton.user.shoppingListProvider.itemsBeingEdited.toString()}");

                    debugPrint(
                        "[SLE] ${_singleton.user.shoppingListProvider.localShoppingListItems.toString()}");
                    debugPrint(
                        "End of then for SHOPPING LIST EDITOR from SLEV");
                  }
                });
              });
              //   .then((_) {
              // setState(() {
              //   if (_singleton.user.shoppingListProvider.itemsBeingEdited ==
              //       null) {
              //     _singleton.user.shoppingListProvider.itemsBeingEdited =
              //         [];
              //   }
              //   if (_singleton
              //           .user.shoppingListProvider.localShoppingListItems ==
              //       null) {
              //     _singleton.user.shoppingListProvider.itemsBeingEdited =
              //         [];
              //   }
              //   _singleton.user.shoppingListProvider.itemsBeingEdited
              //       .add(_singleton.user.shoppingListProvider.newEditItem);
              //   _localListItems
              //       .add(_singleton.user.shoppingListProvider.newEditItem);
              //   var newI = _localListItems.length - 1;
              //   HashMap newListItem = HashMap<String, dynamic>();
              //   newListItem['type'] = _localListItems[newI].type;
              //   newListItem['priority'] =
              //       convertPriority(_localListItems[newI].priority);
              //   var titleTextEditingController = new TextEditingController(
              //       text: (_localListItems[newI].title));
              //   newListItem['title_controller'] =
              //       titleTextEditingController;
              //   var descriptionTextEditingController =
              //       new TextEditingController(
              //           text: (_localListItems[newI].description));
              //   newListItem['description_controller'] =
              //       descriptionTextEditingController;
              //   _liveEditingOfListItems.add(newListItem);
              //   _singleton.user.shoppingListProvider.newEditItem = null;
              // });
              // });
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
                  onPressed: () async {
                    debugPrint("Saving to database");
                    debugPrint("UID: ${_singleton.user.uid}");
                    var _tempItems = _singleton
                        .user.shoppingListProvider.localShoppingListItems;

                    if (_singleton.user.shoppingListProvider
                                .localShoppingListItems !=
                            null &&
                        _singleton.user.shoppingListProvider
                            .localShoppingListItems.isNotEmpty) {
                      _singleton
                          .user.shoppingListProvider.localShoppingListItems
                          .clear();
                    }
                    debugPrint(
                        "[SLEV] AFTER CLEAR local shopping list -> ${_singleton.user.shoppingListProvider.localShoppingListItems.toString()}");

                    debugPrint(
                        "[SLEV] SLEVLIST LENGTH -> ${slevList.length} | LIVEEDITINGOFLISTITEMSLENGTH -> ${_liveEditingOfListItems.length}");
                    for (var i = 0; i < slevList.length; i++) {
                      slevList[i].title =
                          _liveEditingOfListItems[i]['title_controller'].text;
                      slevList[i].description = _liveEditingOfListItems[i]
                              ['description_controller']
                          .text;
                      slevList[i].type = _liveEditingOfListItems[i]['type'];
                      slevList[i].priority = returnPriority(
                          _liveEditingOfListItems[i]['priority']);
                      debugPrint(
                          "[SLEV] AFTER SLEVLIST ADDALL local shopping list item no. $i -> ${slevList[i].toJson()}");
                    }
                    _singleton.user.shoppingListProvider.localShoppingListItems
                        .addAll(slevList);

                    var _result = await MoneySaver().completelyUpdateUser();
                    if (_result == true) {
                      debugPrint("[SLEV] Success at completely updating user.");
                      var _secureStorageResultTest = SecureStorageAttic()
                          .readValue("users/${_singleton.user.uid}");
                      debugPrint(
                          "Checking result from secure storage -> $_secureStorageResultTest");
                      _tempItems = null;
                      Navigator.of(context).pop();
                    } else if (_result == -1) {
                      debugPrint("[SLEV] Failed set at Firestore.");
                      //TODO IF FAILED GET BACK OLD LIST [TEMP ITEMS]
                    } else if (_result == -2) {
                      debugPrint("[SLEV] Failed write at Secure Storage.");
                      //TODO IF FAILED GET BACK OLD LIST [TEMP ITEMS]
                    } else if (_result == null) {
                      debugPrint("[SLEV] Money Saver is null.");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
