import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance_apps/app/common/routes/names.dart';
import 'package:my_finance_apps/app/core/values/constant.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_blocs.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_events.dart';
import 'package:my_finance_apps/global.dart';

class MoreController {
  final BuildContext context;
  MoreController({required this.context});

  void handleLogout() {
    context.read<HomePageBlocs>().add(const HomePageIndex(0));
    Global.globalStorageService.remove(
      AppConstants.STORAGE_USER_TOKEN_KEY,
    );
    Global.globalStorageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.LOGIN,
      (route) => false,
    );
  }
}
