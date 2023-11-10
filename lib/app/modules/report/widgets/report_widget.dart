import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_finance_apps/app/core/values/static_theme.dart';

buildPieChart({required BuildContext context, required List<double> data}) {
  print("${data[0]}  ${data[1]}STATES LOADED");
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('MMMM y').format(DateTime.now()),
                style: lightBlackTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(width: 8),
              // const Icon(Icons.calendar_today_rounded),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.95 * 0.65,
          decoration: BoxDecoration(
            color: lightBlackColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: [
                      PieChartSectionData(
                        title: '${data[0].round()} %',
                        titleStyle: whiteTextStyle,
                        value: data[0],
                        color: Colors.blue,
                      ),
                      PieChartSectionData(
                        title: '${data[1].round()} %',
                        titleStyle: whiteTextStyle,
                        value: data[1],
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15.sp),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildIndicator(
                    color: Colors.blue,
                    text: 'Expense',
                    isSquare: true,
                    textColor: whiteColor,
                  ),
                  const SizedBox(height: 10),
                  buildIndicator(
                    color: Colors.orange,
                    text: 'Income',
                    isSquare: true,
                    textColor: whiteColor,
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

buildIndicator({
  required Color color,
  required String text,
  required bool isSquare,
  double size = 14,
  Color? textColor,
}) {
  return Row(
    children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
          color: color,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(
        text,
        style: baseTextStyle.copyWith(
          fontSize: size.sp,
          color: whiteColor,
          fontWeight: medium,
        ),
      )
    ],
  );
}

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, meta) => Container(
              margin: const EdgeInsets.only(top: 6.0),
              child: Text(
                value.toString(),
                style: TextStyle(
                  color: const Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, meta) => Container(
              margin: const EdgeInsets.only(right: 4.0),
              child: Text(
                value.toString(),
                style: TextStyle(
                  color: const Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      );
}

buildLineChart({required BuildContext context}) {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: Column(
      children: [
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('MMMM y').format(DateTime.now()),
                style: lightBlackTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(width: 8),
              // const Icon(Icons.calendar_today_rounded),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.95 * 0.65,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 6,
              titlesData: LineTitles.getTitleData(),
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Color(0xff37434d),
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Color(0xff37434d),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1,
                ),
              ),
              // titlesData: FlTitlesData(show: true),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: const Color(0xff23b6e6),
                  gradient: LinearGradient(
                    colors: gradientColors,
                  ),
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: gradientColors
                          .map((color) => color.withOpacity(0.3))
                          .toList(),
                    ),
                  ),
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color(0xff23b6e6),
                  //     Color(0xff02d39a),
                  //   ],
                  // ),
                  // gradient: Gradient(colors: [Color(0xff23b6e6), Color(0xff02d39a)]),
                  spots: [
                    FlSpot(0, 3),
                    FlSpot(2.6, 2),
                    FlSpot(4.9, 5),
                    FlSpot(6.8, 2.5),
                    FlSpot(8, 4),
                    FlSpot(9.5, 3),
                    FlSpot(11, 4),
                  ],
                  // isCurved: true,
                  // dotData: FlDotData(show: false),
                  // belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
