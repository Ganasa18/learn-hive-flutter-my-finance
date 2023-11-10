import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_finance_apps/app/common/routes/bloc_observer.dart';
import 'package:my_finance_apps/app/data/services/global_service.dart';

class Global {
  static late GlobalStorageService globalStorageService;

  static Future init() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    Bloc.observer = MyGlobalObserver();
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    globalStorageService = await GlobalStorageService().init();
  }
}
