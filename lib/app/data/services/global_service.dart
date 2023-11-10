// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:my_finance_apps/app/core/values/constant.dart';
import 'package:my_finance_apps/app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalStorageService {
  late final SharedPreferences _prefs;

  Future<GlobalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  User? getUserProfile() {
    var profileOffiline =
        _prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";

    if (profileOffiline.isNotEmpty) {
      Map<String, dynamic> userData = jsonDecode(profileOffiline);
      print('$userData USER PROFILE');
      return User(userData['username'], userData['pin']);
    }

    return null;
  }

  bool getIsLoggedIn() {
    return _prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY) == null
        ? false
        : true;
  }
}
