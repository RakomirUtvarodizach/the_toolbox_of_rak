import 'package:flutter/material.dart';

import '../../../styles.dart';

class CloudCard extends StatefulWidget {
  List<List<String>> listOfDropDownLists;
  List<String> listOfTFLabels = List();
  List<String> defaultTFLabels = List();
  List<String> dropDownValues = List();
  var _tfControllers = <TextEditingController>[];

  CloudCard(
      {this.listOfDropDownLists: const [
        ["dummyOrange", "dummyApple", "dummyPear"],
      ],
      this.listOfTFLabels: const ["Title", "Description"],
      this.defaultTFLabels,
      this.dropDownValues});

  @override
  _CloudCardState createState() => _CloudCardState();
}

class _CloudCardState extends State<CloudCard> {
  @override
  void initState() {
    for (int i = 0; i < widget.listOfTFLabels.length; i++) {
      var textEditingController = new TextEditingController(
          text: (widget.defaultTFLabels[i] ?? widget.listOfTFLabels[i]));
      widget._tfControllers.add(textEditingController);
    }
    for (var i = 0; i < widget.listOfDropDownLists.length; i++) {
      widget.dropDownValues[i] ??= widget.listOfDropDownLists[i][0];
    }
    debugPrint("Dialog Value Count: ${widget.dropDownValues.length}");
    super.initState();
  }

  @override
  void dispose() {
    for (var tfController in widget._tfControllers) {
      tfController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 4.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.listOfDropDownLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Align(
                      child: DropdownButton(
                        hint: Text("Please choose one of the following:"),
                        value: widget.dropDownValues[index],
                        onChanged: (newValue) {
                          setState(() {
                            widget.dropDownValues[index] = newValue;
                            debugPrint(
                                "Dialog Value of Index $index: ${widget.dropDownValues[index]}");
                          });
                        },
                        items:
                            widget.listOfDropDownLists[index].map((itemType) {
                          return DropdownMenuItem(
                              child: Text(itemType), value: itemType);
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                  ],
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.listOfTFLabels.length,
              itemBuilder: (BuildContext context, int tfIndex) {
                debugPrint("TF BUILDER: $tfIndex");
                return ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(
                      height: 4.0,
                    ),
                    TextField(
                      controller: widget._tfControllers[tfIndex],
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        debugPrint('Description: $value');
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.lightBlue[200])),
                          hintText: widget.listOfTFLabels[tfIndex],
                          labelStyle: TextStyle(color: Colors.black54),
                          errorMaxLines: 2,
                          errorStyle: TextStyle(fontSize: 16.0),
                          labelText: widget.listOfTFLabels[tfIndex],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 3.0,
            ),
            IconButton(
              icon: Icon(Icons.save, color: AccentColor),
              onPressed: () {
                debugPrint("Yay icon button from custom dialog pressed.");
              },
            )
          ],
        ),
      ),
    );
  }
}
