import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageAttic {
  FlutterSecureStorage storage;

  SecureStorageAttic() {
    storage = FlutterSecureStorage();
  }

  Future<dynamic> readValue(String key) async {
    String value = await storage.read(key: key);
    if (value == null) {
      debugPrint('[RV] value is null.');
      return false;
    } else {
      debugPrint('[RV] Value as String: ' + value);
      Map<String, dynamic> valueMap = json.decode(value);
      debugPrint('[RV] ValueMap: ' + valueMap.toString());
      return valueMap;
    }
  }

  Future<dynamic> readAllValues(Map<String, String> allValues) async {
    Map<String, String> values = await storage.readAll();
    if (values == null) {
      debugPrint('[RA] values are null.');
      return false;
    } else {
      debugPrint('[RA] all values: ' + values.toString());
      return values;
    }
  }

  Future<void> writeValue(String key, Map<String, dynamic> value) async {
    String valueJson = json.encode(value);
    debugPrint('[WV] valueJson: $valueJson');
    await storage.write(key: key, value: valueJson).then((_) {
      debugPrint('[WV] value written inside then.');
    }).catchError((onError) {
      debugPrint('[WV] Error: $onError');
    });
    debugPrint('[WV] value written after await.');
  }

  Future<void> deleteValue(String key) async {
    await storage.delete(key: key).then((_) {
      debugPrint('[DV] value deleted inside then.');
    }).catchError((onError) {
      debugPrint('[DV] Error: $onError');
    });
    debugPrint('[DV] value deleted after await.');
  }

  Future<void> deleteAllValues() async {
    await storage.deleteAll().then((_) {
      debugPrint('[DA] all values deleted inside then.');
    }).catchError((onError) {
      debugPrint('[DA] Error: $onError');
    });
    debugPrint('[DA] all values deleted after await.');
  }
}
