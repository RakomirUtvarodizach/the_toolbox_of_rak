import 'package:flutter/material.dart';

class ShoppingListEditor extends StatefulWidget {
  final String appBarTitle;

  ShoppingListEditor(this.appBarTitle);

  @override
  _ShoppingListEditorState createState() =>
      _ShoppingListEditorState(this.appBarTitle);
}

class _ShoppingListEditorState extends State<ShoppingListEditor> {
  static var _priorities = ['High', 'Low'];
  var _currentHighLow = 'Low';
  String appBarTitle;

  TextEditingController _itemController;
  TextEditingController _descriptionController;

  _ShoppingListEditorState(this.appBarTitle);

  @override
  void initState() {
    _itemController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _itemController.dispose();
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
            ListTile(
              leading: Text('Priority: ',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic)),
              title: DropdownButton(
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
                value: _currentHighLow ?? _priorities[1],
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    this._currentHighLow = valueSelectedByUser;
                    debugPrint('User selected $valueSelectedByUser');
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _itemController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  debugPrint('Item: $value');
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue[200])),
                    hintText: 'Granice Jogurt',
                    labelStyle: TextStyle(color: Colors.black54),
                    errorMaxLines: 2,
                    errorStyle: TextStyle(fontSize: 16.0),
                    labelText: 'Item',
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
                        borderSide: BorderSide(color: Colors.lightBlue[200])),
                    hintText: 'Andrej nemoj kupiti najskuplje mleko',
                    labelStyle: TextStyle(color: Colors.black54),
                    errorMaxLines: 2,
                    errorStyle: TextStyle(fontSize: 16.0),
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
          _itemController.text = item;
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
