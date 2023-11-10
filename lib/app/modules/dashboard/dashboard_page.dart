import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/common/widgets/build_title_currency.dart';
import 'package:my_finance_apps/app/core/utils/text_format.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_blocs.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:my_finance_apps/app/modules/dashboard/dashboard_controller.dart';
import 'package:my_finance_apps/app/modules/dashboard/widgets/dashboard_widgets.dart';
import 'package:my_finance_apps/app/modules/wallet/wallet_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   WalletController(context: context).initializeDataWallet();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final activeCateogry =
        context.read<DashboardPageBloc>().state.activeCategory;
    WalletController(context: context).initializeDataWallet();
    DashboardController(context: context).getListTransaction(activeCateogry);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<DashboardPageBloc, DashboardPageStates>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // DATA BALANCE
                    SizedBox(height: 25.h),
                    buildTitleCurrency(amount: state.totalAmountWallet),
                    Container(
                      padding: EdgeInsets.only(bottom: 20.h, top: 5.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: greyColor.withOpacity(0.4),
                            width: 0.4,
                          ),
                        ),
                      ),
                      child: Text(
                        "Total balance",
                        style: greyTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: medium,
                        ),
                      ),
                    ),

                    // TYPE BALANCE
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        buildCategoryContainer(
                          label: 'expense',
                          context: context,
                        ),
                        SizedBox(width: 5.w),
                        buildCategoryContainer(
                          label: 'income',
                          context: context,
                        ),
                        SizedBox(width: 5.w),
                        // buildCategoryContainer(label: 'wish', context: context),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // CATEGORY HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Category",
                          style: blackTextStyle.copyWith(
                            fontSize: 20.sp,
                            fontWeight: semiBold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),

                // LIST DATA
                switch (state.activeCategory) {
                  'expense' => state.transactionList != null
                      ? Expanded(
                          child: RefreshIndicator(
                            color: lightBlackColor,
                            onRefresh: () async {
                              Future.delayed(const Duration(seconds: 2),
                                  () async {
                                DashboardController(context: context)
                                    .getListTransaction(state.activeCategory);
                              });
                            },
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.transactionList!.length,
                              itemBuilder: (_, index) {
                                final item = state.transactionList![index];
                                return buildItemList(
                                  screenWidth,
                                  item.nameCategory,
                                  item.iconCategory,
                                  item.amountTransaction,
                                  item.amountTransactionOld,
                                  type: item.typeTransaction,
                                );
                              },
                              separatorBuilder: (_, __) {
                                return SizedBox(
                                  height: 8.h,
                                );
                              },
                            ),
                          ),
                        )
                      : const SizedBox(),
                  'income' => state.transactionList != null
                      ? Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.transactionList!.length,
                            itemBuilder: (_, index) {
                              final item = state.transactionList![index];
                              return buildItemList(
                                screenWidth,
                                item.nameCategory,
                                item.iconCategory,
                                item.amountTransaction,
                                item.amountTransactionOld,
                                type: item.typeTransaction,
                              );
                            },
                            separatorBuilder: (_, __) {
                              return SizedBox(
                                height: 8.h,
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  _ => const Text('Unknown case'),
                }

                //   Expanded(
                //   child: ListView.separated(
                //     shrinkWrap: true,
                //     itemBuilder: (_, index) {
                //       return buildItemList(screenWidth, "Food", index + 1);
                //     },
                //     separatorBuilder: (_, __) {
                //       return SizedBox(
                //         height: 8.h,
                //       );
                //     },
                //     itemCount: 6,
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DummyItem {
  final int index;
  final String title;
  final Icon icon;
  final int expense;

  DummyItem(this.index, this.title, this.icon, this.expense);
}

final List<DummyItem> dummyData = [
  DummyItem(
    1,
    "Food",
    const Icon(Icons.keyboard_double_arrow_down_rounded),
    10000,
  ),
  DummyItem(
      2, "Drink", const Icon(Icons.keyboard_double_arrow_down_rounded), 4000),
  DummyItem(
      3, "Hobby", const Icon(Icons.keyboard_double_arrow_down_rounded), 20000),
  DummyItem(
      4, "Bills", const Icon(Icons.keyboard_double_arrow_down_rounded), 1000),
  DummyItem(
      5, "Charity", const Icon(Icons.keyboard_double_arrow_down_rounded), 5000),
];
