import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/common/routes/names.dart';
import 'package:my_finance_apps/app/core/utils/text_format.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_blocs.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_blocs.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_event.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_states.dart';
import 'package:my_finance_apps/app/modules/wallet/widgets/wallet_widget.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final formKey = GlobalKey<FormState>();
  final nameWalletController = TextEditingController();
  final amountWalletController = TextEditingController();
  int selectedWalletIdx = -1;

  @override
  initState() {
    super.initState();
    // WalletController(context: context).initializeDataWallet();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<DashboardPageBloc, DashboardPageStates>(
      builder: (context, statedashboard) {
        return Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
              child: BlocBuilder<WalletBloc, WalletStates>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatCurrency(statedashboard.totalAmountWallet,
                            symbol: 'Rp '),
                        style: lightBlackTextStyle.copyWith(
                          fontSize: 32.sp,
                          fontWeight: extraBold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'Total Balance',
                        style: greyTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: regular,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Wallets",
                            style: lightBlackTextStyle.copyWith(
                              fontSize: 13.sp,
                              fontWeight: medium,
                            ),
                          ),
                          Text(
                            formatCurrency(statedashboard.totalAmountWallet,
                                symbol: 'Rp ', decimalDigits: 0),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      state.wallets != null
                          ? SizedBox(
                              height: 200.h,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.wallets!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  bool isSelected = index == selectedWalletIdx;
                                  return makeCardWallet(
                                    screenWidth: screenWidth,
                                    index: index,
                                    state: state,
                                    isSelected: isSelected,
                                    ontap: () {
                                      if (context.mounted) {
                                        context.read<WalletBloc>().add(
                                              SetWalletSelect(
                                                state.wallets![index],
                                              ),
                                            );
                                        Navigator.popAndPushNamed(
                                          context,
                                          AppRoutes.WALLETS_DETAIL,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(height: 20.h),
                      Container(
                        width: (screenWidth - 45.w) / 2,
                        height: 70.h,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                            color: lightBlackColor.withOpacity(0.8),
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            showAlertDialog(
                              formKey: formKey,
                              states: state,
                              context: context,
                              name: nameWalletController,
                              amount: amountWalletController,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w),
                              Container(
                                width: 35.w,
                                height: 35.w,
                                decoration: BoxDecoration(
                                  color: teaGreenColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: const Icon(Icons.add),
                              ),
                              SizedBox(width: 12.w),
                              const Text("Add Wallet")
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
