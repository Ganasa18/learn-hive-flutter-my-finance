import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/utils/text_format.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_blocs.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:my_finance_apps/app/modules/dashboard/dashboard_controller.dart';

Widget buildCategoryContainer({
  required String label,
  required BuildContext context,
}) {
  DashboardPageBloc dashboardBloc = context.read<DashboardPageBloc>();

  return GestureDetector(
    onTap: () {
      BlocProvider.of<DashboardPageBloc>(context).add(
        CategoryActiveIndex(label),
      );
      DashboardController(context: context).getListTransaction(label);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: dashboardBloc.state.activeCategory == label
            ? lightBlackColor
            : Colors.transparent,
        border: Border.all(
          color: lightBlackColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          capitalizeFirstChar(label),
          style: baseTextStyle.copyWith(
            color: dashboardBloc.state.activeCategory == label
                ? whiteColor
                : lightBlackColor,
            fontSize: 13.sp,
            fontWeight: semiBold,
          ),
        ),
      ),
    ),
  );
}

Padding buildItemList(
  double screenWidth,
  String label,
  int icon,
  int expense,
  int balance, {
  String type = 'expense',
}) {
  double percentage = (expense / balance) * 100;

  return Padding(
    padding: EdgeInsets.only(top: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Text(
            label,
            style: lightBlackTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: bold,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Stack(
          children: [
            Container(
              width: screenWidth,
              height: 50.h,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            Container(
              width: type == 'expense'
                  ? screenWidth * (percentage / 100)
                  : screenWidth,
              height: 45.h,
              decoration: BoxDecoration(
                color: teaGreenColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            Positioned(
                left: 14.w,
                top: 8.w,
                child: Icon(
                  IconData(icon, fontFamily: 'MaterialIcons'),
                )),
            Positioned(
              right: 12.w,
              top: 14.h,
              child: Text(
                formatCurrency(expense),
                style: lightBlackTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
