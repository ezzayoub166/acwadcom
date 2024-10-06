
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;

  static final CacheHelper _instance = CacheHelper();

  static CacheHelper get instance => _instance;


  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    
  }

  Future<bool> saveValueWithKey<T>(String key, T value) async {
    print("SharedPreferences: [Saving data] -> key: $key, value: $value");
    if (value is String) {
      return await _preferences!.setString(key, value);
    } else if (value is bool) {
      return await _preferences!.setBool(key, value);
    } else if (value is double) {
      return await _preferences!.setDouble(key, value);
    } else if (value is int) {
      return await _preferences!.setInt(key, value);
    } else if (value is List<String>) {
      print("WARNING: You are trying to save a [value] of type [List<String>]");
      await _preferences!.setStringList(key, value);
    } else {
      throw "not a supported type";
    }
    return false;
  }


  getValueWithKey(
      String key, {
        bool bypassValueChecking = true,
        bool hideDebugPrint = false,
      }) {
    var value = _preferences?.get(key);
    if (value == null && !bypassValueChecking) {
      throw PlatformException(
          code: "SHARED_PREFERENCES_VALUE_CAN'T_BE_NULL",
          message: "you have ordered a value which doesn't exist in Shared Preferences",
          details: "make sure you have saved the value in advance in order to get it back");
    }
    if (!hideDebugPrint) print("SharedPreferences: [Reading data] -> key: $key, value: $value");
    return value;
  }

  Future<bool> removeValueWithKey(String key) async {
    var value = _preferences?.get(key);
    if (value == null) return true;
    assert(_preferences != null);
    print("SharedPreferences: [Removing data] -> key: $key, value: $value");
    return await _preferences!.remove(key);
  }

  Future<void> clearAll() async {
    var onBoarding = _instance.getValueWithKey('OpenApp');
    assert(_preferences != null);
    await _preferences!.clear();
    if(onBoarding != null){
      await _instance.saveValueWithKey('OpenApp', onBoarding);
    }
  }

  // static Future<bool> saveData(
  //     {required String key, required dynamic value}) async {
  //   if (_preferences != null) {
  //     if (value is String) return await _preferences!.setString(key, value);
  //     if (value is int) return await _preferences!.setInt(key, value);
  //     if (value is bool) return await _preferences!.setBool(key, value);
  //
  //     return await _preferences!.setString(key, value ?? '');
  //   } else {
  //     throw Exception('SharedPreferences is not initialized.');
  //   }
  // }
  //
  //
  static Future<bool> clearData({required String key}) async {
    return await _preferences!.remove(key);
  }

  //
  // static Future<void> cacheLanguageCode(String languageCode) async {
  //   CacheHelper.saveData(key: 'LOCAL', value: languageCode);
  // }

  String getChacedLanguageCode()  {
  final String? cachedLanguageCode =  _preferences!.getString('LOCAL');
  if (cachedLanguageCode != null) {
    return cachedLanguageCode;
  } else {
    return 'en';
  }
}
}
