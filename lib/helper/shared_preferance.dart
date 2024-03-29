import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferances {
  static SharedPreferences? prefe;

  static Future<void> setString(String key, value) async {
    prefe = await SharedPreferences.getInstance();
    prefe?.setString(key, jsonEncode(value));
  }

  static Future<String?> getString(
    String key,
  ) async {
    prefe = await SharedPreferences.getInstance();
    if (prefe?.getString(key) != null) {
      return prefe?.getString(key);
    } else {
      return null;
    }
  }

  static Future<String?> prefGetString(String key, String strDef) async {
    prefe = await SharedPreferences.getInstance();
    if (prefe!.getString(key) != null) {
      return prefe!.getString(key);
    } else {
      return strDef;
    }
  }

  static Future removeStoredData(String key) async {
    prefe = await SharedPreferences.getInstance();
    if (prefe?.remove(key) != null) {
      return prefe?.remove(key);
    }
  }
}
