import 'dart:math';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_blocs.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_events.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../core/utils/text_format.dart';

class AmountPage extends StatefulWidget {
  const AmountPage({super.key});

  @override
  State<AmountPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<AmountPage> {
  String enteredAmount = '';
  bool isCalculate = false;

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredAmount.isEmpty && number == 0) {
              enteredAmount = '';
            } else {
              enteredAmount += number.toString();
            }
          });
        },
        child: Text(
          number.toString(),
          style: lightBlackTextStyle.copyWith(
            fontSize: 24.sp,
            fontWeight: bold,
          ),
        ),
      ),
    );
  }

  Widget calculateButton({required String symbol, VoidCallback? onPress}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: onPress,
        child: Text(
          symbol,
          style: lightBlackTextStyle.copyWith(
            fontSize: 24.sp,
            fontWeight: bold,
          ),
        ),
      ),
    );
  }

  bool isLastCharNotNumber(String str) {
    if (str.isEmpty) return true;
    final lastChar = str[str.length - 1];
    return !RegExp(r'\d').hasMatch(lastChar);
  }

  double calculateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, cm);

      return result;
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
      return 0;
    }
  }

  void performArithmeticOperation(String symbol) {
    setState(() {
      if (isLastCharNotNumber(enteredAmount)) {
        enteredAmount =
            enteredAmount.substring(0, max(0, enteredAmount.length - 1));
      }
      enteredAmount = "$enteredAmount$symbol";
      isCalculate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, size: 22.sp),
                ),
                Text(
                  "Input Amount",
                  style: lightBlackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14.sp,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      enteredAmount.isEmpty
                          ? "Enter Amount"
                          : isCalculate
                              ? enteredAmount
                              : formatAmount(enteredAmount),
                      style: lightBlackTextStyle.copyWith(
                        fontSize: 36.sp,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => numButton(1 + 3 * i + index),
                  ).toList(),
                ),
              ),

            // AMOUNT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (enteredAmount.isNotEmpty && isCalculate != true) {
                            enteredAmount += "00";
                          }
                        });
                      },
                      child: Text(
                        "00",
                        style: lightBlackTextStyle.copyWith(
                          fontSize: 24.sp,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),
                  numButton(0),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextButton(
                      onPressed: () {
                        if (enteredAmount.isNotEmpty) {
                          setState(() {
                            enteredAmount = enteredAmount.substring(
                                0, enteredAmount.length - 1);
                          });
                        }
                      },
                      child: const Icon(
                        Icons.backspace,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  calculateButton(
                      symbol: "/",
                      onPress: () {
                        setState(() {
                          performArithmeticOperation("/");
                        });
                      }),
                  calculateButton(
                      symbol: "*",
                      onPress: () {
                        setState(() {
                          setState(() {
                            performArithmeticOperation("*");
                          });
                        });
                      }),
                  calculateButton(
                      symbol: "+",
                      onPress: () {
                        setState(() {
                          performArithmeticOperation("+");
                        });
                      }),
                  calculateButton(
                      symbol: "-",
                      onPress: () {
                        setState(() {
                          performArithmeticOperation("-");
                        });
                      }),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      enteredAmount = '';
                      isCalculate = false;
                    });
                  },
                  child: Text(
                    'Reset',
                    style: lightBlackTextStyle.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    setState(() {
                      double result = calculateExpression(enteredAmount);
                      String stringValue = result.toStringAsFixed(0);

                      print("$result  STRING RESULT");
                      if (stringValue.endsWith(".0")) {
                        stringValue =
                            stringValue.substring(0, stringValue.length - 2);
                      }
                      enteredAmount = stringValue;
                      isCalculate = false;
                    });
                  },
                  icon: const Icon(
                    Icons.calculate_outlined,
                    color: Colors.blue,
                    size: 26,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 60.h,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (enteredAmount.isNotEmpty &&
                      RegExp(r'^[0-9]+$').hasMatch(enteredAmount)) {
                    context
                        .read<TransactionBloc>()
                        .add(SetAmountTransaction(int.parse(enteredAmount)));
                  } else {
                    context
                        .read<TransactionBloc>()
                        .add(const SetAmountTransaction(0));
                  }
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    lightBlackColor,
                  ),
                ),
                child: Text(
                  'Submit',
                  style: whiteTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
