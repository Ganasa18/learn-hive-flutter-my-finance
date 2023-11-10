import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/modules/mores/more_controller.dart';
import 'package:my_finance_apps/app/modules/mores/widgets/more_widgets.dart';

class MoresPage extends StatelessWidget {
  const MoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: Column(
            children: [
              const SizedBox(height: 5),
              listItemMore(
                ontap: () {},
                title: "Settings",
                icon: const Icon(Icons.settings),
              ),
              listItemMore(
                ontap: () {
                  _openAnimatedDialog(context);
                },
                title: "Log Out",
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openAnimatedDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                title: Center(
                    child: Text(
                  "Are you sure\nWant to log out ?",
                  textAlign: TextAlign.center,
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: medium,
                  ),
                )),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          teaGreenColor,
                        ),
                      ),
                      child: const Text("No"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        MoreController(context: context).handleLogout();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          lightBlackColor,
                        ),
                      ),
                      child: const Text("Yes"),
                    )
                  ],
                ),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          );
        });
  }
}
