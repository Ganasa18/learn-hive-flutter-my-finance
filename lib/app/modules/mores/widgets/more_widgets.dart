import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';

Container listItemMore({
  VoidCallback? ontap,
  required String title,
  required Icon icon,
}) {
  return Container(
    width: double.infinity,
    height: 40.h,
    margin: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ontap,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 18),
            Text(
              title,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
          ],
        ),
      ),
    ),
  );
}
