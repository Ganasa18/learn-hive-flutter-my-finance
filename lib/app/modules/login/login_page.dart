import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/modules/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final userNameField = TextEditingController();
  final pinField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor.withOpacity(0.9),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Text(
                  "Here To Get",
                  style: lightBlackTextStyle.copyWith(
                    fontSize: 24.sp,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  "Sign In",
                  style: blackTextStyle.copyWith(
                    fontSize: 34.sp,
                    fontWeight: extraBold,
                  ),
                ),
                SizedBox(height: 30.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userNameField,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your username";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: pinField,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Pin',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your pin";
                          } else if (!RegExp(r'\d').hasMatch(value)) {
                            return "Pin must contain only numbers";
                          } else if (value.length != 6) {
                            return "Pin must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              lightBlackColor,
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              SignInController(context: context)
                                  .handleRegisterUser(
                                username: userNameField.text,
                                pin: int.parse(pinField.text),
                              );

                              // String result = await handleRegisterUser(
                              //   username: userNameField.text,
                              //   pin: int.parse(pinField.text),
                              // );

                              // if (context.mounted) {
                              //   context.read<HomePageBlocs>().add(
                              //         UserDataLogin(
                              //           User(
                              //             userNameField.text,
                              //             int.parse(pinField.text),
                              //           ),
                              //         ),
                              //       );
                              // }

                              formKey.currentState?.reset();

                              // final snackBar = SnackBar(
                              //   elevation: 0,
                              //   behavior: SnackBarBehavior.floating,
                              //   backgroundColor: Colors.transparent,
                              //   content: AwesomeSnackbarContent(
                              //     title: 'Message',
                              //     message: result,
                              //     contentType: ContentType.help,
                              //   ),
                              // );
                              // // ignore: use_build_context_synchronously
                              // ScaffoldMessenger.of(context)
                              //   ..hideCurrentMaterialBanner()
                              //   ..showSnackBar(snackBar);

                              // // ignore: use_build_context_synchronously

                              // Future.delayed(const Duration(seconds: 3), () {
                              //   Navigator.of(context)
                              //       .pushNamed(AppRoutes.DASHBOARD);
                              // });
                            }
                          },
                          child: const Text('LOGIN'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
