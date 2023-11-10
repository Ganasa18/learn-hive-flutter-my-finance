import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';
import 'package:my_finance_apps/app/modules/report/bloc/report_blocs.dart';
import 'package:my_finance_apps/app/modules/report/bloc/report_states.dart';
import 'package:my_finance_apps/app/modules/report/report_controller.dart';
import 'package:my_finance_apps/app/modules/report/widgets/report_widget.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReportController(context: context).getTotalPercentage();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final TabController tabControllerReport =
        TabController(length: 2, vsync: this);

    return BlocBuilder<ReportBloc, ReportStates>(
      builder: (context, state) {
        if (state is ReportLoadings) {
          return SizedBox(
            width: screenWidth,
            height: screenHeight / 2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ReportLoaded) {
          return Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 10),
                      child: Text(
                        "Analytics",
                        style: blackTextStyle.copyWith(
                          fontSize: 24.sp,
                          fontWeight: extraBold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabBar(
                          isScrollable: true,
                          labelPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          controller: tabControllerReport,
                          labelColor: lightBlackColor,
                          unselectedLabelColor: greyColor,
                          tabs: const [
                            Tab(text: "Donut"),
                            Tab(text: "Chart"),
                          ],
                        ),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(Icons.date_range),
                        //   color: Colors.blue,
                        //   iconSize: 28,
                        // )
                      ],
                    ),
                    SizedBox(
                      width: screenWidth,
                      height: 320.h,
                      child: TabBarView(
                        controller: tabControllerReport,
                        children: [
                          buildPieChart(context: context, data: state.totalPercentages),
                          buildLineChart(context: context),
                        ],
                      ),
                    ),
                  ]),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
    // final Offset offsetLine =
    //     offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    // canvas.drawLine(offsetLine, offsetLine, paint);
  }
}
