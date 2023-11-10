import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/utils/text_format.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_states.dart';
import 'package:my_finance_apps/app/modules/wallet/wallet_controller.dart';

showAlertDialog(
    {required BuildContext context,
    required WalletStates states,
    required TextEditingController name,
    required TextEditingController amount,
    required GlobalKey<FormState> formKey}) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Create",
      style: baseTextStyle.copyWith(
        fontWeight: bold,
      ),
    ),
    onPressed: () {
      if (formKey.currentState!.validate()) {
        Wallet wallet = Wallet(
            nameWallet: name.value.text.toLowerCase(),
            amountWallet: int.parse(amount.value.text));
        WalletController(context: context).createWallet(wallet);
        name.clear();
        amount.clear();
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
    },
  );

  Widget bodyContent = SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Wallet Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter name";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: amount,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Amount',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter amount";
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Add Wallet"),
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
      return alert;
    },
  );
}

GestureDetector makeCardWallet({
  required double screenWidth,
  required int index,
  required WalletStates state,
  bool? isSelected = false,
  VoidCallback? ontap,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Padding(
      padding: EdgeInsets.only(left: index != 0 ? 15.w : 0),
      child: Container(
        width: (screenWidth - 45.w) / 2,
        height: 200.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1) // changes position of shadow
                ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: teaGreenColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Icon(Icons.wallet),
                  ),
                  SizedBox(width: 6.w),
                  Text(capitalizeFirstChar(
                    state.wallets![index].nameWallet,
                  )),
                ],
              ),
              Text(
                formatCurrency(
                  state.wallets![index].amountWallet,
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ),
                style: lightBlackTextStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
