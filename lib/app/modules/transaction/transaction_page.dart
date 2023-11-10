import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_finance_apps/app/common/routes/names.dart';
import 'package:my_finance_apps/app/core/utils/text_format.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/data/models/transaction_model.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_blocs.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_events.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_states.dart';
import 'package:my_finance_apps/app/modules/transaction/transaction_controller.dart';
import 'package:my_finance_apps/app/modules/transaction/widgets/transaction_widgets.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int selectedCategoryIdx = -1;
  final categoryController = TextEditingController();
  DateTime? selectedDate;

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  initState() {
    super.initState();
    selectedDate = DateTime.now();
    TransactionController(context: context).initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<TransactionBloc, TransactionStates>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            TransactionController(context: context).resetValueTransaction();
            return true; // Allow the back button to pop the screen
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  TransactionController(context: context)
                      .resetValueTransaction();
                  Navigator.pop(context); // Pop the current screen
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Transaction",
                    style: lightBlackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (state.wallet == null ||
                          state.category == null ||
                          state.amount == 0) {
                        final snackBar =
                            snackBarCustom(message: "Please fill all field");

                        ScaffoldMessenger.of(context)
                          ..hideCurrentMaterialBanner()
                          ..showSnackBar(snackBar);
                        return;
                      } else if (state.typeTransaction == "expense" &&
                          state.amount > state.wallet!.amountWallet) {
                        final snackBarWallet = snackBarCustom(
                            message:
                                "Amount cannot greater than wallet amount,");

                        ScaffoldMessenger.of(context)
                          ..hideCurrentMaterialBanner()
                          ..showSnackBar(snackBarWallet);
                        return;
                      } else {
                        Transaction transaction = Transaction(
                          nameCategory: state.category!.nameCategory,
                          iconCategory: state.category!.iconCategory,
                          amountTransaction: state.amount,
                          amountTransactionOld: state.wallet!.amountWallet,
                          typeTransaction: state.typeTransaction,
                          dateCreated: selectedDate!,
                          walletType: state.wallet!.nameWallet,
                        );

                        TransactionController(context: context)
                            .createTransaction(transaction);
                      }
                    },
                    icon: Icon(Icons.check, size: 22.sp),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      width: screenWidth,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: lightBlackColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildTabTypeTransaction(
                              onTap: () {
                                context.read<TransactionBloc>().add(
                                      const SelectedTransactionType('expense'),
                                    );
                              },
                              state: state,
                              text: "expense",
                              screenWidth: screenWidth,
                            ),
                            buildTabTypeTransaction(
                              onTap: () {
                                context.read<TransactionBloc>().add(
                                      const SelectedTransactionType('income'),
                                    );
                              },
                              state: state,
                              text: "income",
                              screenWidth: screenWidth,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.AMOUNT_TRANSACTION);
                    },
                    child: Text(
                      formatCurrency(state.amount,
                          decimalDigits: 0, symbol: 'Rp '),
                      style: lightBlackTextStyle.copyWith(
                        fontSize: 30.sp,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  state.categories != null
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: screenWidth,
                                height: 85.h,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: GridView.builder(
                                  itemCount: state.categories!.length,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    bool isSelected =
                                        index == selectedCategoryIdx;
                                    // Display category items
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCategoryIdx = index;
                                          context.read<TransactionBloc>().add(
                                                SetSelectedCategory(
                                                  state.categories![index],
                                                ),
                                              );
                                        });
                                      },
                                      child: categoryItem(
                                        isSelected: isSelected,
                                        category: state.categories![index],
                                        label: state
                                            .categories![index].nameCategory,
                                        screenWidth: screenWidth,
                                        icon: Icon(
                                          Icons.money_off,
                                          color: lightBlackColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () {
                                  showAlertDialog(
                                    context: context,
                                    states: state,
                                    controller: categoryController,
                                  );
                                },
                                child: categoryItem(
                                  isSelected: false,
                                  screenWidth: screenWidth,
                                  icon: Icon(
                                    Icons.add,
                                    color: lightBlackColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: screenWidth,
                          height: 85.h,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: GestureDetector(
                            onTap: () {
                              showAlertDialog(
                                context: context,
                                states: state,
                                controller: categoryController,
                              );
                            },
                            child: categoryItem(
                              isSelected: false,
                              screenWidth: screenWidth,
                              icon: Icon(
                                Icons.add,
                                color: lightBlackColor,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: lightBlackColor,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                selectedDate != null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(selectedDate!)
                                    : "Select Date",
                                style: lightBlackTextStyle.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.WALLETS_TRANSACTION);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.wallet,
                                color: lightBlackColor,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                state.wallet != null
                                    ? capitalizeFirstChar(
                                        state.wallet!.nameWallet)
                                    : "Select Wallet",
                                style: lightBlackTextStyle.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: const Divider(
                      thickness: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SnackBar snackBarCustom({required String message}) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: message,
        contentType: ContentType.help,
      ),
    );
  }
}
