import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/models/userSingleton.dart';
import 'package:toolbox/red_cross/localStorageAttic.dart';
import 'package:toolbox/red_cross/firestoreAttic.dart';

import 'secureStorageAttic.dart';

class MoneySaver {
  bool net = false;

  MoneySaver() {
    //TODO Check if has connection on creation of class
  }

  // var encoding = json.encode(AnObject);
  // var decoding = json.decode(encoding);
  // var object = AnObject.fromJson(decoding);

  void addNewRegisteredUser() {}

  dynamic create() {}

  Future read(String path, String docName) async {
    net = true;
    if (net) {
      debugPrint(
          "[MS] updateSingletonUser ->  path-> $path | docName-> $docName");
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

  dynamic completelyUpdateUser() async {
    net = true;
    if (net) {
      Singleton _singleton = Singleton();
      String uid = _singleton.user.uid;
      var encoded = json.encode(_singleton.user);
      var decoded = json.decode(encoded);
      await FirestoreAttic()
          .faSetDocument("users", decoded, id: uid)
          .then((_) async {
        debugPrint("Successfully set in Firestore.");
        await SecureStorageAttic().writeValue("users/$uid", decoded).then((_) {
          debugPrint("Successfully written in Secure Storage.");
          return true;
        }).catchError((onError) {
          debugPrint("Secure Storage write error -> $onError");
          return -2;
        });
        debugPrint("After -2.");
        return true;
      }).catchError((onError) {
        debugPrint("Set Document onError -> $onError");
        return -1;
      });
      debugPrint("After -1.");
      return true;
    } else {
      debugPrint("[MS] Entered first else");
      return null;
    }
  }

  dynamic delete() {}

  dynamic readMany() {}

  //update singleton user
  Future updateSingletonUser(String path, String docName) async {
    debugPrint("[MS] updateSingletonUser -> path: $path | docName: $docName");
    // Map<String, dynamic> mapOfUser = await read(path, docName);
    // debugPrint("MAP OF USER: " + mapOfUser.toString());

    UserSingleton newUserSingleton = await read(path, docName);
    if (/*mapOfUser*/ newUserSingleton != null) {
      Singleton _s = Singleton();
      if (_s.user == null) {
        _s.user = new UserSingleton();
      }
      _s.user = newUserSingleton;
      _s.user.uid = docName;
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
