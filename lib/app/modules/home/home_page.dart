import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/common/routes/names.dart';
import 'package:my_finance_apps/app/common/widgets/base_app_bar.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/data/models/user_model.dart';
import 'package:my_finance_apps/app/modules/export_page.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_blocs.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_events.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_states.dart';
import 'package:my_finance_apps/app/modules/home/home_controller.dart';
import 'package:my_finance_apps/app/modules/home/widgets/home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _homeController;

  late User? userData;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController(context: context);
    _homeController.init();
    userData = _homeController.userData;
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   HomeController(context: context);
  // }

  @override
  Widget build(BuildContext context) {
    int indexInitial = context.read<HomePageBlocs>().state.indexMenu;
    PageController pageController = PageController(
      initialPage: indexInitial,
    );
    return BlocBuilder<HomePageBlocs, HomePageStates>(
      builder: (context, state) {
        return userData != null
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: buildAppBarBase(userData!),
                body: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    BlocProvider.of<HomePageBlocs>(context)
                        .add(HomePageIndex(index));
                  },
                  children: [
                    pageIndex(0, const DashboardPage()),
                    pageIndex(1, const WalletPage()),
                    pageIndex(2, const ReportPage()),
                    pageIndex(3, const MoresPage()),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Align(
                  alignment: const Alignment(0, 0.98),
                  child: SizedBox(
                    height: 50.w,
                    width: 50.w,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: lightBlackColor,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.ADD_TRANSACTION);
                        },
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar:
                    customBottomNav(context, state, pageController),
              )
            : Container();
      },
    );
  }
}
