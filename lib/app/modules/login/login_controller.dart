// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:my_finance_apps/app/common/routes/names.dart';
import 'package:my_finance_apps/app/core/values/constant.dart';
import 'package:my_finance_apps/app/core/values/keys.dart';
import 'package:my_finance_apps/app/data/models/user_model.dart';
import 'package:my_finance_apps/app/data/providers/user_provider.dart';
import 'package:my_finance_apps/app/data/repository/user_repository.dart';
import 'package:my_finance_apps/app/data/services/user_service.dart';
import 'package:my_finance_apps/global.dart';

class SignInController {
  final BuildContext context;

  SignInController({required this.context});

  Future<void> handleRegisterUser(
      {required String username, required int pin}) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );

    final userStorageService = UserStorageService();
    await userStorageService.init();
    UserProvider userProvider = UserProvider(userStorageService);
    UserRepository userRepository = UserRepository(userProvider);
    final userBox = await Hive.openBox<User>(userKey);

    // Check if the user already exists
    final existingUser = userBox.values.firstWhere(
        (user) => user.username == username,
        orElse: () => User('', 0));

    print('$username $pin input form');
    print('${existingUser.username} existing user');

    if (existingUser.username.isNotEmpty) {
      if (existingUser.username == username && existingUser.pin != pin) {
        EasyLoading.dismiss();
        print('Invalid login');
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Message',
            message: "Invalid login",
            contentType: ContentType.failure,
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(snackBar);
        await userBox.close();
        return;
      }

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Message',
          message: "Success login",
          contentType: ContentType.success,
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
      print('User already exists');
      await userBox.close();
      Map<String, dynamic> userMap = {
        'username': existingUser.username,
        'pin': existingUser.pin,
      };

      Global.globalStorageService.setString(
        AppConstants.STORAGE_USER_PROFILE_KEY,
        jsonEncode(userMap),
      );

      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
        EasyLoading.dismiss();
      });

      // return 'Login Successful';
    } else {
       final userBox = await Hive.openBox<User>(userKey);

      User newUser = User(username, pin);
      await userRepository.createUser(newUser);
     
      EasyLoading.dismiss();
      print('Invalid login');
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Message',
          message: "User registered successfully",
          contentType: ContentType.help,
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
      return;
    }
  }

  // if (existingUser != null) {
  //   // await userBox.close();
  //   return 'User already exists';
  // } else {
  //   // // Create user if not existing
  //   // final userStorageService = UserStorageService();
  //   // await userStorageService.init();
  //   // UserProvider userProvider = UserProvider(userStorageService);
  //   // UserRepository userRepository = UserRepository(userProvider);
  //   // User newUser = User(username, pin);
  //   // await userRepository.createUser(newUser);

  //   // await userBox.close();
  //   return 'User registered successfully';
  // }

//   if (foundUser != null) {
//     return 'user existing';
//   } else {
// //  create user if not existing
//     final userStorageService = UserStorageService();
//     await userStorageService.init();
//     UserProvider userProvider = UserProvider(userStorageService);
//     UserRepository userRepository = UserRepository(userProvider);
//     User newUser = User(username, pin);
//     await userRepository.createUser(newUser);
//   }
}
