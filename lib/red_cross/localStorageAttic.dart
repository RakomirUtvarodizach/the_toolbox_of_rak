import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

class LocalStorageAttic {
  LocalStorage storage;

  Future<void> putItem(String fileName, Map<String, dynamic> file) async {
    storage = LocalStorage(fileName);
    bool result = await storage.ready;
    if (result) {
      debugPrint('1a. Storage is ready:' + result.toString());
      await storage.setItem(fileName, file);
      debugPrint('2a. Item successfully set! ');
    } else {
      debugPrint('1b. Error when readying storage.');
    }
  }

  Future<dynamic> getItem(String fileName) async {
    storage = LocalStorage(fileName);
    bool result = await storage.ready;
    if (result) {
      Map<String, dynamic> gottenFile = storage.getItem(fileName);
      debugPrint('Getting following item: ' + gottenFile.toString());
      return gottenFile;
    } else {
      return false;
    }
  }

  Future<void> clearAllItemsFromStorage(String storageName) async {
    storage = LocalStorage(storageName);
    await storage.clear().then((_) {
      debugPrint('All Items cleared.');
    }).catchError((onError) {
      debugPrint('Clearing all items in storage failed: $onError');
    });
  }

  Future<void> deleteItem(String fileName) async {
    storage = LocalStorage(fileName);
    bool result = await storage.ready;
    if (result) {
      await storage.deleteItem("first_name").then((_) {
        debugPrint('Item $fileName successfully deleted.');
      }).catchError((onError) {
        debugPrint('Deleting item $fileName failed after then: ' + onError);
      });
    } else {
      debugPrint('Deleting item failed when readying storage.');
    }
  }

  Future<void> putDetailedItem(
      String storageName, String fileName, Map<String, dynamic> file) async {
    storage = LocalStorage(storageName);
    bool result = await storage.ready;
    if (result) {
      debugPrint('PDI Storage _ $storageName _ ready: ' + result.toString());
      await storage.setItem(fileName, file);
      debugPrint(
          'PDI Item _ $fileName _ successfully set into storage _ $storageName _. ');
    } else {
      debugPrint('PDI Error when readying storage _ $storageName _.');
    }
  }

  Future<dynamic> getDetailedItem(String storageName, String fileName) async {
    storage = LocalStorage(storageName);
    bool result = await storage.ready;
    if (result) {
      Map<String, dynamic> gottenFile = storage.getItem(fileName);
      debugPrint('Getting following item: ' + gottenFile.toString());
      return gottenFile;
    } else {
      return false;
    }
  }

  Future<void> deleteDetailedItem(String storageName, String fileName) async {
    storage = LocalStorage(storageName);
    bool result = await storage.ready;
    if (result) {
      await storage.deleteItem(fileName);
      dynamic testing = await storage.getItem(fileName);
      debugPrint('Testing item appearance after deleting: ' +
          testing['id'].toString() +
          " " +
          testing['article'].toString());
    } else {
      debugPrint('Deleting item failed when readying storage.');
    }
  }
}
