import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {

  List<LineChartBarData> lineChartBarData = [
    LineChartBarData(
        colors: [Colors.blue],
        isCurved: true,
        belowBarData: BarAreaData(show: true, colors: [
          ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a))
              .lerp(0.2)!
              .withOpacity(0.5),
          ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a))
              .lerp(0.2)!
              .withOpacity(0.5),
        ]),
        spots: [
          FlSpot(0, 0),
          FlSpot(1, 3),
          FlSpot(2, 4),
          FlSpot(3, 5),
          FlSpot(4, 8),
          FlSpot(5, 3),
          FlSpot(6, 5),
          FlSpot(7, 8),
          FlSpot(8, 4),
          FlSpot(9, 7),
          FlSpot(10, 7),
          FlSpot(11, 8),
        ]) ,
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: LineChart(
            LineChartData(
                minX: 1,
                minY: 0,
                maxX: 7,
                maxY: 16,
                lineBarsData: lineChartBarData,
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(showTitles: true),
                  leftTitles: SideTitles(showTitles: true),
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(
                    show: false,
                    border:
                        Border.all(color: const Color(0xff37434d), width: 1)),
                backgroundColor: Colors.white60,


            ),
          ),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.symmetric(),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          // color: Colors.red,
        ),
      ],
    )));
  }
}
