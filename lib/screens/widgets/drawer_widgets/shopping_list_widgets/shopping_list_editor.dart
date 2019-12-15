import 'package:flutter/material.dart';
import 'package:toolbox/etc/styles.dart';
import 'package:toolbox/models/shopping_list_item.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/shared_utils/decorations.dart';

class ShoppingListEditor extends StatefulWidget {
  ShoppingListEditor();

  @override
  _ShoppingListEditorState createState() => _ShoppingListEditorState();
}

class _ShoppingListEditorState extends State<ShoppingListEditor> {
  List<String> _types = ["Food", "Chemicals", "Cosmetics", "Clothes"];
  List<String> _priorities = ["Low", "Medium", "High"];
  var _currentPriority;
  var _currentType;
  Singleton _singleton;
  var _recentItems;
  bool _validateTitle;

  TextEditingController _titleController;
  TextEditingController _descriptionController;

  _ShoppingListEditorState();

  @override
  void initState() {
    _singleton = Singleton();
    _recentItems = _singleton.user.shoppingListProvider.recentItems;
    _titleController = TextEditingController();
    _validateTitle = false;
    _descriptionController = TextEditingController();
    _currentPriority = _priorities[0];
    _currentType = _types[0];
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_titleController.text.isEmpty) {
                setState(() {
                  _validateTitle = true;
                });
              } else {
                ShoppingListItem _newItem = ShoppingListItem(
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    type: _currentType,
                    priority: returnPriority());
                if (_singleton.user.shoppingListProvider.itemsBeingEdited ==
                    null) {
                  List<ShoppingListItem> slil = [];
                  slil.add(_newItem);
                  _singleton.user.shoppingListProvider.itemsBeingEdited = slil;
                } else {
                  _singleton.user.shoppingListProvider.itemsBeingEdited
                      .add(_newItem);
                }

                _singleton.user.shoppingListProvider
                    .editRecentItems(_newItem.title);
                Navigator.of(context).pop();
              }
            },
          )
        ],
        title: Text('Add a new item'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: DropdownButton(
                      items: _types.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'EB_Garamond',
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic),
                      value: _currentType,
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          this._currentType = valueSelectedByUser;
                          debugPrint('Type: $valueSelectedByUser');
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Center(
                    child: DropdownButton(
                      items: _priorities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'EB_Garamond',
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic),
                      value: _currentPriority,
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          this._currentPriority = valueSelectedByUser;
                          debugPrint('Priority: $valueSelectedByUser');
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _titleController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  debugPrint('Title: $value');
                  if (value.isNotEmpty && _validateTitle) {
                    setState(() {
                      _validateTitle = false;
                    });
                  }
                },
                decoration: textInputDecoration.copyWith(
                  hintText: 'Granice Jogurt',
                  labelText: 'Title',
                  errorText: _validateTitle ? "Title must not be empty." : null,
                ),
                // decoration: InputDecoration(
                //     focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: AccentColor600)),
                //     hintText: 'Granice Jogurt',
                //     hintStyle: TextStyle(color: NeutralColor),
                //     labelStyle: TextStyle(color: NeutralComplementaryColor),
                //     errorMaxLines: 2,
                //     errorStyle: TextStyle(fontSize: 16.0, color: Colors.red),
                //     errorText:
                //         _validateTitle ? "Title must not be empty." : null,
                //     labelText: 'Title',
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  debugPrint('Description: $value');
                },
                decoration: textInputDecoration.copyWith(
                  hintText: 'Andrej nemoj kupiti najskuplje mleko',
                  labelText: 'Description',
                ),
                // decoration: InputDecoration(
                //     focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: AccentColor600)),
                //     hintText: 'Andrej nemoj kupiti najskuplje mleko',
                //     hintStyle: TextStyle(color: NeutralColor),
                //     labelStyle: TextStyle(color: NeutralComplementaryColor),
                //     errorMaxLines: 2,
                //     errorStyle: TextStyle(fontSize: 16.0, color: Colors.red),
                //     labelText: 'Description',
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Center(
                  child: Text('Suggestions:',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 25))),
            ),
            Container(
              child: (_recentItems != null && _recentItems.length > 0)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _recentItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          splashColor: Colors.yellow[500],
                          onTap: () {
                            _titleController.text = _recentItems[index];
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.yellow[500],
                                      width: 2.0,
                                      style: BorderStyle.solid)),
                              color: Colors.white,
                              elevation: 2.0,
                              child: ListTile(
                                title: Text(_recentItems[index]),
                              )),
                        );
                      },
                    )
                  : Center(
                      child: Text("No items to suggest ¯\\_( ツ )_/¯ ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              fontSize: 37)),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  int returnPriority() {
    switch (_currentPriority) {
      case "Low":
        return 1;
        break;
      case "Medimu":
        return 2;
        break;
      case "High":
        return 3;
        break;

      default:
        return 1;
        break;
    }
  }
}
