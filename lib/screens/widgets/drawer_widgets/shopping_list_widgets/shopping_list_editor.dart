import 'package:flutter/material.dart';
import 'package:toolbox/styles.dart';

class ShoppingListEditor extends StatefulWidget {
  final String appBarTitle;

  ShoppingListEditor(this.appBarTitle);

  @override
  _ShoppingListEditorState createState() =>
      _ShoppingListEditorState(this.appBarTitle);
}

class _ShoppingListEditorState extends State<ShoppingListEditor> {
  List<String> _types = ["Food", "Chemicals", "Cosmetics", "Clothes"];
  List<String> _priorities = ["Low", "Medium", "High"];
  var _currentPriority;
  var _currentType;
  String appBarTitle;

  TextEditingController _titleController;
  TextEditingController _descriptionController;

  _ShoppingListEditorState(this.appBarTitle);

  @override
  void initState() {
    _titleController = TextEditingController();
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
            onPressed: () {},
          )
        ],
        title: Text(appBarTitle),
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
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AccentColor600)),
                    hintText: 'Granice Jogurt',
                    hintStyle: TextStyle(color: NeutralColor),
                    labelStyle: TextStyle(color: NeutralComplementaryColor),
                    errorMaxLines: 2,
                    errorStyle: TextStyle(fontSize: 16.0, color: Colors.red),
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
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
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AccentColor600)),
                    hintText: 'Andrej nemoj kupiti najskuplje mleko',
                    hintStyle: TextStyle(color: NeutralColor),
                    labelStyle: TextStyle(color: NeutralComplementaryColor),
                    errorMaxLines: 2,
                    errorStyle: TextStyle(fontSize: 16.0, color: Colors.red),
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
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
              child: possibleItems() ??
                  Center(
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

  possibleItems() {
    var alphaItems = List<Widget>();
    var items = ['Jogurt Granice', 'Krilca', 'Ovsene', 'Kifla', 'Mleko'];
    for (var item in items) {
      alphaItems.add(InkWell(
        splashColor: Colors.yellow[500],
        onTap: () {
          _titleController.text = item;
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
              title: Text(item),
            )),
      ));
    }

    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Column(children: alphaItems));
  }
}
