
import 'dart:convert';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/user_model.dart';
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

    // Generic method to read data
  Future<T?> readData<T>(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw UnsupportedError("Type not supported");
    }
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

Future<void> savePersonList(UserModel user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Convert the user object to a JSON string
  String jsonUser = jsonEncode(user.toJson());
  
  // Save the JSON string
  await prefs.setString('user', jsonUser);
}

// Function to retrieve UserModel from SharedPreferences
Future<UserModel?> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if user data exists in SharedPreferences
  String? jsonString = prefs.getString('user');
  if (jsonString != null) {
    // Convert the JSON string back to UserModel
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    return UserModel.fromJson(userMap);
  }

  // If no data exists, return null
  return null;
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
    return 'ar';
  }
}
}
