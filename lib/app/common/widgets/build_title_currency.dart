import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/utils/text_format.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';

buildTitleCurrency(
    {required int amount,
    String? prefix = "Rp",
    String? symbol = "",
    dynamic decimalDigits = 2}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$prefix",
        style: blackTextStyle.copyWith(
          fontSize: 20.sp,
          fontWeight: bold,
        ),
      ),
      SizedBox(width: 6.w),
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            formatCurrency(amount,
                symbol: symbol, decimalDigits: decimalDigits),
            style: blackTextStyle.copyWith(
              fontSize: 45.sp,
              fontWeight: bold,
            ),
          ),
        ),
      ),
    ],
  );
}
