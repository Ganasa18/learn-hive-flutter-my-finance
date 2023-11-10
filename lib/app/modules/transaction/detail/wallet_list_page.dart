import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_blocs.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_events.dart';
import 'package:my_finance_apps/app/modules/transaction/widgets/transaction_widgets.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_blocs.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_states.dart';

class TransactionWallet extends StatefulWidget {
  const TransactionWallet({super.key});

  @override
  State<TransactionWallet> createState() => _TransactionWalletState();
}

class _TransactionWalletState extends State<TransactionWallet> {
  int selectedIdx = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wallets",
                  style: lightBlackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (state.wallets != null && selectedIdx != -1) {
                      final Wallet wallet = state.wallets![selectedIdx];
                      context
                          .read<TransactionBloc>()
                          .add(SetSelectedWallet(wallet));
                      Navigator.pop(context);
                    } else {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Message',
                          message: "Please select one wallet",
                          contentType: ContentType.warning,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentMaterialBanner()
                        ..showSnackBar(snackBar);
                    }
                  },
                  icon: Icon(Icons.check, size: 22.sp),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.wallets != null ? state.wallets!.length : 0,
              itemBuilder: (BuildContext context, index) {
                final wallet = state.wallets![index];
                bool isSelected = index == selectedIdx;

                return Padding(
                  padding: EdgeInsets.only(bottom: 8.sp),
                  child: selectedWallet(
                      ontap: () {
                        setState(() {
                          selectedIdx = index;
                        });
                      },
                      nameWallet: wallet.nameWallet,
                      amountWallet: wallet.amountWallet,
                      isSelected: isSelected),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
