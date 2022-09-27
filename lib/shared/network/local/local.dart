import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chache_Helper {
  static late SharedPreferences shared;
  static Future<SharedPreferences> init() async {
    return shared = await SharedPreferences.getInstance() as SharedPreferences;
  }

  static Future<bool> putBool({
    required String key,
    required bool value,
  }) async {
    return await shared.setBool(key, value);
  }

  static bool? getbool({required String key}) {
    return shared.getBool(key);
  }

  /* static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is bool) return await shared.setBool(key, value as bool);
    if (value is String) return await shared.setString(key, value);
    if (value is int) return await shared.setInt(key, value);
    return await shared.setDouble(key, value as double);
  }

  static dynamic getData({required String key}) {
    return shared.get(key);
  }

  static String? getString({required String key}) {
    return shared.getString(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await shared.remove(key);
  } */
}
