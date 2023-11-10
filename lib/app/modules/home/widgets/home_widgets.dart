import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_blocs.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_events.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_states.dart';

Widget pageIndex(int index, Widget page) {
  return SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HOME PAGE
        page
      ],
    ),
  );
}

Theme customBottomNav(
    BuildContext context, HomePageStates state, PageController pageController) {
  return Theme(
    data: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    child: BottomAppBar(
      // shape: CircularNotchedRectangle(),
      // notchMargin: 8,
      child: SizedBox(
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                createMenuItem(
                  context: context,
                  state: state,
                  pageController: pageController,
                  icon: Icons.home,
                  label: 'Home',
                  index: 0,
                ),
                SizedBox(width: 10.w),
                createMenuItem(
                  context: context,
                  state: state,
                  pageController: pageController,
                  icon: Icons.wallet,
                  label: 'Wallet',
                  index: 1,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                createMenuItem(
                  context: context,
                  state: state,
                  pageController: pageController,
                  icon: Icons.pie_chart,
                  label: 'Analytics',
                  index: 2,
                ),
                SizedBox(width: 10.w),
                createMenuItem(
                  context: context,
                  state: state,
                  pageController: pageController,
                  icon: Icons.more_horiz,
                  label: 'More',
                  index: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget createMenuItem({
  required BuildContext context,
  required HomePageStates state,
  required PageController pageController,
  required IconData icon,
  required String label,
  int index = 0,
}) {
  final isSelected = state.indexMenu == index;

  return MaterialButton(
    minWidth: 40,
    onPressed: () {
      BlocProvider.of<HomePageBlocs>(context).add(HomePageIndex(index));
      pageController.jumpToPage(index);
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? lightBlackColor : greyColor,
        ),
        Text(
          label,
          style: isSelected
              ? blackTextStyle.copyWith(fontSize: 12.sp, fontWeight: medium)
              : greyTextStyle.copyWith(fontSize: 12.sp, fontWeight: medium),
        ),
      ],
    ),
  );
}
