// ignore_for_file: avoid_print

import 'package:hive/hive.dart';
import 'package:my_finance_apps/app/core/values/keys.dart';
import 'package:my_finance_apps/app/data/models/user_model.dart';

class UserStorageService {
// initialize the storage service

  late Box<User> _userBox;

  Future<void> init() async {
    // initialize create dummy user if not exist
    try {
      // Initialize Hive and open the box for users.
      if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
        // If it's not registered, then register the adapter
        Hive.registerAdapter(UserAdapter());
      }

      _userBox = await Hive.openBox<User>(userKey);
    } catch (e) {
      // Handle errors, such as Hive initialization or box opening failure.

      print('Error initializing user storage: $e');
    }
  }

  Future<void> emptyHiveBoxUser() async {
    final userBox = await Hive.openBox<User>(userKey);
    // Clear the box (deletes all data in the box).
    await userBox.clear();
    // Close the box after clearing it.
    await userBox.close();
  }

// create user stroage service
  Future<void> createUser(User user) async {
    await _userBox.add(user);
  }

// read user stroage service
  Future<User?> readUser(int userId) async {
    return _userBox.get(userId);
  }
}
