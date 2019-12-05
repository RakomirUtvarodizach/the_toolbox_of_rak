import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:toolbox/models/userSingleton.dart';

class FirestoreAttic {
  FirestoreAttic();
  final Firestore _database = Firestore.instance;

  // var encoding = json.encode(AnObject);
  // var decoding = json.decode(encoding);
  // var object = AnObject.fromJson(decoding);

  // Future updateUserData(UserSingleton user, String docName) async {
  //   return await _database
  //       .collection('users')
  //       .document(docName)
  //       .setData(user.toJson());
  // }

  Future updateUserData(dynamic document, String docName) async {
    return await _database
        .collection('users')
        .document(docName)
        .setData(document);
  }

  // Future initializeUser(String email, String firstName, String lastName) async {
  //   return await _database.collection('users').document(uid).setData({
  //     'email': email,
  //     'firstName': firstName,
  //     'lastName': lastName,
  //   });
  // }

  // Future getDocData(String path, String docName) async {
  //   // String fp = formatPath(path);
  //   return await _database.collection(path).document(docName).get();
  // }

  // String formatPath(String path) {
  //   List<String> divided = path.split("/");
  //   String newPath = divided[0];
  //   if (divided.length > 1) {
  //     for (int i = 1; i < divided.length; i++) {
  //       newPath += "/" + divided[i];
  //     }
  //   }
  //   return newPath;
  // }
  /*Future<QuerySnapshot> faGetDataCollection(String path) {
    CollectionReference _ref = _database.collection(path);
    return _ref.getDocuments();
  }

  Stream<QuerySnapshot> faStreamDataCollection(String path) {
    CollectionReference _ref = _database.collection(path);
    return _ref.snapshots();
  }

  Future<void> faRemoveDocument(String id, String path) {
    CollectionReference _ref = _database.collection(path);
    return _ref.document(id).delete();
  }

  Future<DocumentReference> faAddDocument(Map data, String path) {
    CollectionReference _ref = _database.collection(path);
    return _ref.add(data);
  }*/

  Future<DocumentSnapshot> faGetDocumentById(String path, String id) {
    CollectionReference _ref = _database.collection(path);
    return _ref.document(id).get();
  }

  Future<void> faUpdateDocument(String path, Map data, String id) {
    CollectionReference _ref = _database.collection(path);
    return _ref.document(id).updateData(data);
  }

  Future<void> faSetDocument(String path, Map data, {String id}) {
    CollectionReference _ref = _database.collection(path);
    if (id == null) {
      return _ref.add(data);
    } else
      return _ref.document(id).setData(data);
  }
}
