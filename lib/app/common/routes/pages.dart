// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance_apps/app/common/routes/names.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_blocs.dart';
import 'package:my_finance_apps/app/modules/export_page.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_blocs.dart';
import 'package:my_finance_apps/app/modules/report/bloc/report_blocs.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_blocs.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_blocs.dart';
import 'package:my_finance_apps/global.dart';

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, required this.bloc});
}

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const HomePage(),
        bloc: BlocProvider(create: (_) => HomePageBlocs()),
      ),
      PageEntity(
        route: AppRoutes.HOME,
        page: const HomePage(),
        bloc: BlocProvider(create: (_) => HomePageBlocs()),
      ),
      PageEntity(
        route: AppRoutes.DASHBOARD,
        page: const DashboardPage(),
        bloc: BlocProvider(create: (_) => DashboardPageBloc()),
      ),
      PageEntity(
        route: AppRoutes.ADD_TRANSACTION,
        page: const TransactionPage(),
        bloc: BlocProvider(create: (_) => TransactionBloc()),
      ),
      PageEntity(
        route: AppRoutes.AMOUNT_TRANSACTION,
        page: const AmountPage(),
        bloc: BlocProvider(create: (_) => TransactionBloc()),
      ),
      PageEntity(
        route: AppRoutes.WALLETS_TRANSACTION,
        page: const TransactionWallet(),
        bloc: BlocProvider(create: (_) => TransactionBloc()),
      ),
      PageEntity(
        route: AppRoutes.REPORT,
        page: const ReportPage(),
        bloc: BlocProvider(create: (_) => ReportBloc()),
      ),
      PageEntity(
        route: AppRoutes.WALLETS,
        page: const WalletPage(),
        bloc: BlocProvider(create: (_) => WalletBloc()),
      ),
      PageEntity(
        route: AppRoutes.WALLETS_DETAIL,
        page: const WalletDetailPage(),
        bloc: BlocProvider(create: (_) => WalletBloc()),
      ),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);

      if (result.isNotEmpty) {
        print("RESULT ============ ${result.first.page}");
        if (result.first.route == AppRoutes.INITIAL) {
          bool isLoggedIn = Global.globalStorageService.getIsLoggedIn();

          if (isLoggedIn) {
            return MaterialPageRoute(
                builder: (_) => const PinPage(), settings: settings);
          }

          return MaterialPageRoute(
              builder: (_) => const LoginPage(), settings: settings);
        }
        return MaterialPageRoute(
          builder: (_) => result.first.page,
          settings: settings,
        );
      }
    }
    return MaterialPageRoute(
      builder: (_) => const LoginPage(),
      settings: settings,
    );
  }
}
