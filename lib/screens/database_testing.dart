import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toolbox/models/dataThree.dart';
import 'package:toolbox/models/dataTwo.dart';
import 'package:toolbox/models/providers/shoppingListProvider.dart';
import 'package:toolbox/models/userSingleton.dart';
import 'package:toolbox/red_cross/firestoreAttic.dart';
import 'package:toolbox/red_cross/localStorageAttic.dart';
import 'package:toolbox/red_cross/secureStorageAttic.dart';

class DatabaseTesting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DatabaseTestingState();
  }
}

class _DatabaseTestingState extends State<DatabaseTesting> {
  final GlobalKey<ScaffoldState> _databaseTestingScaffoldKey =
      GlobalKey<ScaffoldState>();
  String _testOfTheDay = "Depth of array in a single document in firestore.";
  TextEditingController _somethingController;
  LocalStorageAttic lsa;
  SecureStorageAttic ssa;
  String _localStorageFetchResult = 'Nothing Yet';
  String _localStorageState = 'Empty';

  @override
  void initState() {
    _somethingController = TextEditingController();
    lsa = LocalStorageAttic();
    ssa = SecureStorageAttic();
    super.initState();
  }

  @override
  void dispose() {
    _somethingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _databaseTestingScaffoldKey,
        appBar: AppBar(
          title: Text('Database Testing'),
        ),
        backgroundColor: Colors.red[100],
        resizeToAvoidBottomInset: true,
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.yellow[500], Colors.blue[500]],
                        stops: [0.4, 1])),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text("What are we testing today?"),
                    ),
                    Text(_testOfTheDay),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                        child: Text("The Toolbox welcomes you!",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20.0))),
                    SizedBox(height: 30.0),
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextField(
                          controller: _somethingController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            /*debugPrint(
                                'Something changed in First Name Text Field');*/
                          },
                          decoration: InputDecoration(
                              hintText: 'John',
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      elevation: 6.0,
                      onPressed: () async {
                        Map<String, dynamic> person = {
                          "id": "1",
                          "first_name": "Person",
                          "last_name": "Personic",
                          "age": "23",
                          "skills": [
                            "sleep_recovery",
                            "cooking_recovery",
                            "unbounded_sprinting",
                            "impenetrable_body",
                            "unhitable_evade",
                            "infinite_storage",
                            "teleport",
                            "all_fiction"
                          ]
                        };
                        //await lsa.putItem("person", person);
                        await ssa.writeValue("person", person);
                        setState(() {
                          debugPrint('File written in secure storage.');
                          _localStorageState = "Written";
                        });
                      },
                      textColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blue[500], width: 2.0)),
                      color: Colors.black87,
                      padding: EdgeInsets.all(10.0),
                      child: Text("Secure Storage Write",
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      elevation: 6.0,
                      onPressed: () async {
                        String tempString = _somethingController.text;
                        if (tempString != '') {
                          //dynamic tempResult = await lsa.getItem(tempString);
                          dynamic tempResult = await ssa.readValue(tempString);
                          debugPrint("Temp Result: $tempResult");
                          setState(() {
                            _localStorageFetchResult =
                                (tempResult == false || tempResult == null)
                                    ? 'Getting has sadly failed'
                                    : (tempResult['first_name'].toString() ??
                                            'Dodo') +
                                        " " +
                                        tempResult['last_name'].toString();

                            debugPrint(
                                "T> Gotten item: $_localStorageFetchResult");
                          });
                        } else {
                          _snek('Please fill edit text');
                        }
                      },
                      textColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blue[500], width: 2.0)),
                      color: Colors.black87,
                      padding: EdgeInsets.all(10.0),
                      child: Text("Secure Storage Read",
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      elevation: 6.0,
                      onPressed: () async {
                        String tempString = _somethingController.text;
                        if (tempString != '') {
                          debugPrint('Deleting item: $tempString');
                          /*lsa.deleteItem(tempString)*/
                          await ssa.deleteValue(tempString).then((_) {
                            debugPrint("Deleting item succeeded.");
                          }).catchError((onError) {
                            debugPrint("Error while deleting item: $onError");
                          });
                          setState(() {
                            _localStorageFetchResult = 'Empty now';
                            _localStorageState = 'Empty';
                            debugPrint(
                                "Deleted item: $_localStorageFetchResult");
                          });
                        } else {
                          _snek('Please fill edit text');
                        }
                      },
                      textColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blue[500], width: 2.0)),
                      color: Colors.black87,
                      padding: EdgeInsets.all(10.0),
                      child: Text("Secure Storage Delete",
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      elevation: 6.0,
                      onPressed: () async {
                        debugPrint('Starting clearing items');
                        await lsa.clearAllItemsFromStorage('person').then((_) {
                          debugPrint('All items cleared.');
                        }).catchError((onError) {
                          debugPrint(
                              'Error while clearing all items: $onError');
                        });
                        setState(() {
                          _localStorageFetchResult = 'Empty now';
                          _localStorageState = 'Empty';
                        });
                        debugPrint('All items cleared cleared.');
                      },
                      textColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blue[500], width: 2.0)),
                      color: Colors.brown[500],
                      padding: EdgeInsets.all(10.0),
                      child: Text("Local Storage Clear",
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      color: Colors.brown,
                      shape: BeveledRectangleBorder(
                        side: BorderSide(width: 2.0, color: Colors.white),
                      ),
                      onPressed: () async {
                        List<String> animals = [
                          "koala",
                          "eagle",
                          "rat",
                          "rabbit",
                          "deer"
                        ];
                        DataThree d3 = DataThree(
                            listOfStringsInThree: animals,
                            threeBool: true,
                            threeInt: 67,
                            threeString: "This gives us lots of animals");
                        List<DataThree> d3list = [];
                        d3list.addAll(
                          [
                            d3,
                            DataThree(
                              threeBool: false,
                              threeInt: 98,
                              threeString: "A simple list of fruit",
                              listOfStringsInThree: [
                                "apple",
                                "banana",
                                "raspberry",
                                "strawberry",
                                "pineapple",
                                "pomegranate"
                              ],
                            ),
                          ],
                        );
                        DataTwo d2 = DataTwo(
                            twoBool: false,
                            twoInt: 44,
                            twoString: "This is a list of Twos",
                            listOfTwosInThree: d3list);

                        var d23encoded = json.encode(d2);
                        debugPrint("d23encoded -> $d23encoded");

                        var d2decoded = json.decode(d23encoded);
                        debugPrint("d2decoded -> ${d2decoded.runtimeType}");

                        var d2frommed = DataTwo.fromJson(d2decoded);
                        debugPrint(
                            "d2frommed -> ${d2frommed.listOfTwosInThree.toString()}");

                        /*
                        var encoding = json.encode(AnObject);
                        var decoding = json.decode(encoding);
                        var object = AnObject.fromJson(decoding);
                         */
                        // FirestoreAttic()
                        //     .faSetDocument(d2decoded, "testing_data");

                        await FirestoreAttic()
                            .faGetDocumentById(
                                "testing_data", "T806cVAZUYSRkyKoe2yn")
                            .then((DocumentSnapshot snapshot) {
                          debugPrint("Snapshot: ${snapshot.data}");
                        });
                        debugPrint("After read");
                      },
                      child: Text(
                        "Map testing",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      color: Colors.brown,
                      shape: BeveledRectangleBorder(
                        side: BorderSide(width: 2.0, color: Colors.white),
                      ),
                      onPressed: () async {
                        ShoppingListProvider newSLP = ShoppingListProvider();
                        List<ShoppingListProvider> newSLPProxy = [];
                        newSLPProxy.add(newSLP);
                        UserSingleton us = UserSingleton(
                            email: "boban_marlovic@gmail.com",
                            firstName: "Boban",
                            lastName: "Marlovic",
                            shoppingListProvider: newSLP);

                        var encodedUs = json.encode(us);

                        var decodedUs = json.decode(encodedUs);

                        debugPrint(
                            "User testing new-> ${us.toJson().toString()}");

                        await FirestoreAttic().updateUserData(
                            decodedUs, "testingfirestorejson1234567890");
                        debugPrint("Writing done");
                      },
                      child: Text(
                        "FireStore Json Write",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      color: Colors.brown,
                      shape: BeveledRectangleBorder(
                        side: BorderSide(width: 2.0, color: Colors.white),
                      ),
                      onPressed: () async {
                        await FirestoreAttic()
                            .faGetDocumentById(
                                "users", "testingfirestorejson1234567890")
                            .then((DocumentSnapshot snapshot) {
                          debugPrint("TomTom snapshot: ${snapshot.data}");
                          var d2frommed = UserSingleton.fromJson(snapshot.data);
                          debugPrint("d2frommed -> ${d2frommed.toJson()}");
                        });
                      },
                      child: Text(
                        "FireStore Json Get",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    /*SizedBox(height: 10.0),
                    RaisedButton(
                      elevation: 6.0,
                      onPressed: () async {
                        Map<String, dynamic> item = {
                          "id": "003",
                          "article": "cheese"
                        };
                        await lsa.putDetailedItem("storage1", "item3", item);
                        setState(() {
                          debugPrint('File Put in storage not from dattest.');
                          _localStorageState = "Filled";
                        });
                      },
                      textColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blue[500], width: 2.0)),
                      color: Colors.black87,
                      padding: EdgeInsets.all(10.0),
                      child: Text("Testing Extreme Writing",
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      elevation: 6.0,
                      onPressed: () async {
                        String tempString = _somethingController.text;
                        if (tempString != '') {
                          dynamic tempResult =
                              await lsa.getDetailedItem('storage1', tempString);
                          debugPrint("Temp Result: 0 $tempResult 0");
                          setState(() {
                            _localStorageFetchResult =
                                (tempResult == false || tempResult == null)
                                    ? 'Getting has sadly failed'
                                    : tempResult['id'].toString() +
                                        " " +
                                        tempResult['article'].toString();

                            debugPrint(
                                "T> Gotten item: 0 $_localStorageFetchResult 0");
                          });
                        } else {
                          _snek('Please fill edit text');
                        }
                      },
                      textColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blue[500], width: 2.0)),
                      color: Colors.black87,
                      padding: EdgeInsets.all(10.0),
                      child: Text("Testing Extreme Reading",
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      elevation: 6.0,
                      onPressed: () async {
                        String tempString = _somethingController.text;
                        if (tempString != '') {
                          debugPrint('Deleting item: - $tempString -');
                          await lsa
                              .deleteDetailedItem('storage1', tempString)
                              .then((_) {
                            debugPrint("Deleting item succeeded.");
                          }).catchError((onError) {
                            debugPrint(
                                "Error while deleting item: - $onError -");
                          });
                          setState(() {
                            _localStorageFetchResult = 'Empty now';
                            _localStorageState = 'Empty';
                            debugPrint(
                                "D> Deleted item: - $_localStorageFetchResult -");
                          });
                        } else {
                          _snek('Please fill edit text');
                        }
                      },
                      textColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blue[500], width: 2.0)),
                      color: Colors.black87,
                      padding: EdgeInsets.all(10.0),
                      child: Text("Testing Extreme Deleting",
                          style: TextStyle(fontSize: 20)),
                    ),*/
                    SizedBox(height: 10.0),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                        child: Text(_localStorageFetchResult,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20.0))),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                        child: Text(_localStorageState,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20.0))),
                    SizedBox(height: 10.0),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                        child: Text(
                            _somethingController.text == ''
                                ? 'NOTHING YET'
                                : _somethingController.text,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20.0))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _snek(String snTitle) {
    final snak = SnackBar(
      content: Text(snTitle),
      duration: Duration(seconds: 3),
    );
    _databaseTestingScaffoldKey.currentState.showSnackBar(snak);
  }
}
