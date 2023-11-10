// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_finance_apps/app/data/models/user_model.dart';
import 'package:my_finance_apps/app/data/providers/user_provider.dart';
import 'package:my_finance_apps/app/data/repository/user_repository.dart';
import 'package:my_finance_apps/app/data/services/user_service.dart';
import 'package:my_finance_apps/global.dart';

class HomeController {
  // change from final to late because use _singleton
  late BuildContext context;

  User? get userData => Global.globalStorageService.getUserProfile();

  static final HomeController _singleton = HomeController._();
  HomeController._();

  // make sure you have the original only one instance
  factory HomeController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  Future<void> init() async {
    print('============ INIT HOME =========');
    // Global.globalStorageService.getUserProfile();
    // var res = context.read<HomePageBlocs>();
  }
}

void testHiveSetup() async {
  final userStorageService = UserStorageService();
  await userStorageService.init();
  // user create
  UserProvider userProvider = UserProvider(userStorageService);
  UserRepository userRepository = UserRepository(userProvider);
  User newUser = User('john doe', 1234);
  await userRepository.createUser(newUser);

  int userId = 0; // Replace with the actual user ID
  User? user = await userProvider.getUser(userId);

  if (user != null) {
    print('User: ${user.username}, Pin: ${user.pin}');
  } else {
    print('User not found');
  }
}

void testRemoveHiveSetup() async {
  // user initial
  final userStorageService = UserStorageService();

  UserProvider userProvider = UserProvider(userStorageService);
  UserRepository userRepository = UserRepository(userProvider);

  await userRepository.emptyHiveBoxUser();
}

Future<User?> getUserByUsername(String boxName, String username) async {
  try {
    final userBox = await Hive.openBox<User>(
        boxName); // Replace 'User' with your data model.

    User? foundUser;

    for (var i = 0; i < userBox.length; i++) {
      final user = userBox.getAt(i);
      if (user != null && user.username == username) {
        foundUser = user;
        break; // Exit the loop once a matching user is found.
      }
    }

    print('user $foundUser');
    // Close the box when you're done.
    await userBox.close();
    return foundUser;
  } catch (e) {
    // Handle exceptions, such as Hive not being initialized or the box not existing.
    print('Error: $e');
    return null;
  }
}
