import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/common/widgets/icons.dart';
import 'package:my_finance_apps/app/core/utils/text_format.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/data/models/category_model.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_blocs.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_events.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_states.dart';
import 'package:my_finance_apps/app/modules/transaction/transaction_controller.dart';

GestureDetector buildTabTypeTransaction({
  VoidCallback? onTap,
  required String text,
  required TransactionStates state,
  required double screenWidth,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: state.typeTransaction == text
          ? (screenWidth - 25.w) / 2
          : (screenWidth - 50.w) / 2,
      decoration: BoxDecoration(
        color: state.typeTransaction == text
            ? lightBlackColor
            : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Text(
          capitalizeFirstChar(text),
          textAlign: TextAlign.center,
          style: state.typeTransaction == text
              ? whiteTextStyle.copyWith(
                  fontSize: 14.sp,
                )
              : lightBlackTextStyle.copyWith(
                  fontSize: 14.sp,
                ),
        ),
      ),
    ),
  );
}

Column categoryItem({
  Category? category,
  required double screenWidth,
  String? label,
  required Icon icon,
  required bool isSelected,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: (screenWidth - 100.w) / 5,
        height: 60.h,
        decoration: BoxDecoration(
          color: isSelected ? lightBlackColor : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          border: Border.all(
            color: greyColor,
            width: 1,
          ),
        ),
        child: category != null
            ? Icon(
                IconData(category.iconCategory, fontFamily: 'MaterialIcons'),
                color: isSelected ? whiteColor : lightBlackColor,
              )
            : icon,
      ),
      const SizedBox(height: 4),
      Text(
        label ?? "Add",
        style: lightBlackTextStyle.copyWith(
          fontSize: 12.sp,
        ),
      ),
    ],
  );
}

Icon getIconAtIndex(int index) {
  if (index >= 0 && index < getIcons().length) {
    return getIcons()[index];
  } else {
    return const Icon(Icons.error);
  }
}

showAlertDialog(
    {required BuildContext context,
    required TransactionStates states,
    required TextEditingController controller}) {
  final icons = getIcons();

  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Create",
      style: baseTextStyle.copyWith(
        fontWeight: bold,
      ),
    ),
    onPressed: () {
      if (controller.text.isNotEmpty) {
        int idCategory;
        int icon = icons[states.chipIndex].icon!.codePoint;
        if (states.categories != null) {
          idCategory = states.categories!.length + 1;
        } else {
          idCategory = 1;
        }

        Category category = Category(
          idCategory: idCategory,
          nameCategory: controller.value.text,
          iconCategory: icon,
        );
        TransactionController(context: context).createCategory(category);
        context.read<TransactionBloc>().add(const SetSelectedIcon(0));
        controller.clear();
      }
    },
  );
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: baseTextStyle.copyWith(
        fontWeight: bold,
        color: Colors.redAccent,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
      context.read<TransactionBloc>().add(const SetSelectedIcon(0));
    },
  );

  Widget bodyContent = BlocBuilder<TransactionBloc, TransactionStates>(
    builder: (context, state) {
      return SizedBox(
        height: 200.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Category Name',
              ),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 3.w,
              children: icons.map((e) {
                final index = icons.indexOf(e);
                return ChoiceChip(
                  selectedColor: Colors.grey[200],
                  backgroundColor: Colors.white,
                  label: e,
                  selected: states.chipIndex == index,
                  onSelected: (bool selected) {
                    if (selected) {
                      states.chipIndex = index;
                      context
                          .read<TransactionBloc>()
                          .add(SetSelectedIcon(index));
                    }
                    // print(e);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Add Category"),
    content: bodyContent,
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: alert,
      );
    },
  );
}

GestureDetector selectedWallet({
  final VoidCallback? ontap,
  required String nameWallet,
  required int amountWallet,
  required bool isSelected,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: isSelected ? lightBlackColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.transparent : lightBlackColor,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.wallet,
                  size: 24,
                  color: isSelected ? whiteColor : lightBlackColor,
                ),
                const SizedBox(width: 10),
                Text(
                  capitalizeFirstChar(nameWallet),
                  style: isSelected
                      ? whiteTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: regular,
                        )
                      : lightBlackTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: regular,
                        ),
                ),
              ],
            ),
            Text(
              formatCurrency(amountWallet, decimalDigits: 0, symbol: 'Rp '),
              style: isSelected
                  ? whiteTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: regular,
                    )
                  : lightBlackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: regular,
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}
