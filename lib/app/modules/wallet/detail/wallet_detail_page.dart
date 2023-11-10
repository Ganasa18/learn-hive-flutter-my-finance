import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/common/routes/names.dart';
import 'package:my_finance_apps/app/common/widgets/build_title_currency.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_blocs.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_events.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_blocs.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_states.dart';
import 'package:my_finance_apps/app/modules/wallet/wallet_controller.dart';

import '../../../core/utils/text_format.dart';

class WalletDetailPage extends StatefulWidget {
  const WalletDetailPage({super.key});

  @override
  State<WalletDetailPage> createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String typeWallet = context.read<WalletBloc>().state.wallet!.nameWallet;
    WalletController(context: context).initializeWalletDetail(typeWallet);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: teaGreenColor,
      appBar: AppBar(
        backgroundColor: teaGreenColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<HomePageBlocs>(context).add(const HomePageIndex(1));
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.HOME, (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          'Wallet Details',
          style: lightBlackTextStyle.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocBuilder<WalletBloc, WalletStates>(
            builder: (context, state) {
              // if (state.expenseList != null) {
              //   print(
              //       "${json.encode(state.expenseList)}======================== RESULT OUT");
              // }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  buildTitleCurrency(amount: state.wallet!.amountWallet),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.wallet,
                        size: 32,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        capitalizeFirstChar(state.wallet!.nameWallet),
                        style: lightBlackTextStyle.copyWith(
                          fontSize: 24.sp,
                          fontWeight: extraBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "List In / Out",
                    style: greyTextStyle.copyWith(
                      fontSize: 13.sp,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: screenWidth,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      controller: tabController,
                      labelColor: lightBlackColor,
                      indicatorColor: lightBlackColor,
                      tabs: const [
                        Tab(text: "Expense"),
                        Tab(text: "Income"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth,
                    height: 400.h,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatCurrency(state.expenseAmount ?? 0,
                                        symbol: "Rp ", decimalDigits: 0),
                                    style: lightBlackTextStyle.copyWith(
                                      fontSize: 24.sp,
                                      fontWeight: extraBold,
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(state.incomeAmount ?? 0,
                                        symbol: "Rp ", decimalDigits: 0),
                                    style: lightBlackTextStyle.copyWith(
                                      fontSize: 24.sp,
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: SizedBox(
                                width: screenWidth,
                                height: 340.h,
                                child: SingleChildScrollView(
                                  child: state.expenseList != null
                                      ? Column(children: [
                                          ...state.expenseList!
                                              .map((element) =>
                                                  buildItemCardDetail(
                                                      date: element[
                                                          'dateCreated'],
                                                      type: "expense",
                                                      data: element[
                                                          'transaction']))
                                              .toList(),
                                        ])
                                      : Container(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatCurrency(state.expenseAmount ?? 0,
                                        symbol: "Rp ", decimalDigits: 0),
                                    style: lightBlackTextStyle.copyWith(
                                      fontSize: 24.sp,
                                      fontWeight: extraBold,
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(state.incomeAmount ?? 0,
                                        symbol: "Rp ", decimalDigits: 0),
                                    style: lightBlackTextStyle.copyWith(
                                      fontSize: 24.sp,
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: screenWidth,
                              height: 340.h,
                              child: SingleChildScrollView(
                                child: state.incomeList != null
                                    ? Column(children: [
                                        ...state.incomeList!
                                            .map((element) =>
                                                buildItemCardDetail(
                                                    date:
                                                        element['dateCreated'],
                                                    type: "income",
                                                    data:
                                                        element['transaction']))
                                            .toList(),
                                      ])
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

buildItemCardDetail(
    {required String date,
    required String type,
    List<Map<String, dynamic>>? data}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            formatDateString(date),
            style: baseTextStyle.copyWith(
              fontSize: 13.sp,
              color: Colors.black54,
              fontWeight: bold,
            ),
          ),
        ),
        data != null
            ? Column(
                children: [
                  ...data.map(
                    (element) => _buildInnerItemCardDetail(
                        type: type, transaction: element),
                  )
                ],
              )
            : Container()
      ],
    ),
  );
}

_buildInnerItemCardDetail(
    {required String type, required Map<String, dynamic> transaction}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: lightBlackColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Icon(
                IconData(transaction['iconCategory'],
                    fontFamily: 'MaterialIcons'),
                size: 26,
                color: whiteColor,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['nameCategory'],
                  style: lightBlackTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.wallet,
                      color: lightBlackColor,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      capitalizeFirstChar(transaction['walletType']),
                      style: lightBlackTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Text(
              formatCurrency(
                transaction['amountTransaction'],
                symbol: "Rp ",
                decimalDigits: 0,
              ),
              style: baseTextStyle.copyWith(
                color: type == 'expense' ? Colors.redAccent : Colors.green[400],
              ),
            ),
            const SizedBox(height: 6),
            type == 'expense'
                ? Text(
                    formatCurrency(
                      transaction['amountTransactionOld'],
                      symbol: "Rp ",
                      decimalDigits: 0,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    ),
  );
}
