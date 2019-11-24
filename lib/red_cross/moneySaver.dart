import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toolbox/models/singleton.dart';
import 'package:toolbox/models/userSingleton.dart';
import 'package:toolbox/red_cross/localStorageAttic.dart';
import 'package:toolbox/red_cross/firestoreAttic.dart';

class MoneySaver {
  final LocalStorageAttic storage = LocalStorageAttic();
  final FirestoreAttic database = FirestoreAttic();
  bool hasConnection = false;

  MoneySaver() {
    //TODO Check if has connection on creation of class
  }

  void addNewRegisteredUser() {}

  dynamic write() {}

  Future read(String path, String docName) async {
    bool net = true;
    if (net) {
      DocumentSnapshot result = await database.getDocData(path, docName);
      if (result != null) {
        //TODO STILL NEEDS LOCAL STORAGE IMPLEMENTATION AFTERWARDS
        debugPrint("Document Get Map: " + result.data.toString());
        return result.data;
      } else {
        return null;
      }
    } else {
      //TODO LOCAL STORAGE STUFF
      debugPrint("Local storage action.");
    }
  }

  dynamic update() {}

  dynamic delete() {}

  dynamic readMany() {}

  //update singleton user
  Future updateSingletonUser(String path, String docName) async {
    Map<String, dynamic> mapOfUser = await read(path, docName);
    debugPrint("MAP OF USER: " + mapOfUser.toString());
    if (mapOfUser != null) {
      Singleton _s = Singleton();
      if (_s.user == null) {
        _s.user = new UserSingleton();
      }
      _s.user.email = mapOfUser["email"] ?? "dumdum@gmail.com";
      _s.user.firstName = mapOfUser["firstName"] ?? "DumFirst";
      _s.user.lastName = mapOfUser["lastName"] ?? "DumLast";
      debugPrint("SINGLETON USER : " + _s.user.toString());
      return true;
    } else
      return false;
  }
}
