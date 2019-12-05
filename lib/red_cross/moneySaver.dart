import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/models/userSingleton.dart';
import 'package:toolbox/red_cross/localStorageAttic.dart';
import 'package:toolbox/red_cross/firestoreAttic.dart';

class MoneySaver {
  bool hasConnection = false;

  MoneySaver() {
    //TODO Check if has connection on creation of class
  }

  // var encoding = json.encode(AnObject);
  // var decoding = json.decode(encoding);
  // var object = AnObject.fromJson(decoding);

  void addNewRegisteredUser() {}

  dynamic write() {}

  Future read(String path, String docName) async {
    bool net = true;
    if (net) {
      debugPrint("[MONEY_SAVER] path-> $path | docName-> $docName");
      String localPath = path;
      String localDocName = docName;
      DocumentSnapshot snapshot =
          await FirestoreAttic().faGetDocumentById(localPath, localDocName);
      debugPrint("[INSIDE] DOC SNAP DATA: ${snapshot.data} | SNAP: $snapshot");
      if (snapshot != null) {
        //TODO STILL NEEDS SECURE STORAGE IMPLEMENTATION AFTERWARDS
        debugPrint("Document Get Map: ${snapshot.data}");
        var d2frommed = UserSingleton.fromJson(snapshot.data);
        debugPrint("d2frommed -> ${d2frommed.toJson()}");

        return d2frommed;
      } else {
        return null;
      }
    } else {
      //TODO SECURE STORAGE STUFF WHEN THERE IS NO NET
      debugPrint("Local storage action.");
    }
  }

  dynamic update() {}

  dynamic delete() {}

  dynamic readMany() {}

  //update singleton user
  Future updateSingletonUser(String path, String docName) async {
    debugPrint("path: $path | docName: $docName");
    // Map<String, dynamic> mapOfUser = await read(path, docName);
    // debugPrint("MAP OF USER: " + mapOfUser.toString());

    UserSingleton newUserSingleton = await read(path, docName);
    if (/*mapOfUser*/ newUserSingleton != null) {
      Singleton _s = Singleton();
      if (_s.user == null) {
        _s.user = new UserSingleton();
      }
      _s.user = newUserSingleton;
      debugPrint("New User Singleton-> ${_s.user.toJson()}");
      // _s.user.email = mapOfUser["email"] ?? "dumdum@gmail.com";
      // _s.user.firstName = mapOfUser["firstName"] ?? "DumFirst";
      // _s.user.lastName = mapOfUser["lastName"] ?? "DumLast";
      // debugPrint("SINGLETON USER : " + _s.user.toString());
      return true;
    } else
      return false;
  }
}
