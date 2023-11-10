import 'package:flutter/material.dart';
import 'package:my_finance_apps/app/data/models/user_model.dart';
import 'package:my_finance_apps/global.dart';

class PinController {
  late BuildContext context;
  User? get userData => Global.globalStorageService.getUserProfile();
  static final PinController _singleton = PinController._();
  PinController._();

  factory PinController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }
}
