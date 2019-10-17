import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 10;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  StreamController<BarTouchResponse> barTouchResultStreamController;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 10, 8);
    final barGroup2 = makeGroupData(1, 14, 12);
    final barGroup3 = makeGroupData(2, 13, 13);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 8, 6);
    final barGroup6 = makeGroupData(5, 16, 12);
    final barGroup7 = makeGroupData(6, 5, 5);
    final barGroup8 = makeGroupData(7, 11, 9);
    final barGroup9 = makeGroupData(8, 14, 13);
    final barGroup10 = makeGroupData(9, 11, 11);
    final barGroup11 = makeGroupData(10, 14, 13);
    final barGroup12 = makeGroupData(11, 12, 10);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;

    barTouchResultStreamController = StreamController();
    barTouchResultStreamController.stream
      .distinct()
      .listen((BarTouchResponse response){
        if(response == null){
          return;
        }
        if(response.spot == null){
          setState(() {
            touchedGroupIndex = -1;
            showingBarGroups = List.of(rawBarGroups);
          });
          return;
        }

        touchedGroupIndex =
            showingBarGroups.indexOf(response.spot.touchedBarGroup);

        setState(() {
          if(response.touchInput is FlLongPressEnd){
            touchedGroupIndex = -1;
            showingBarGroups = List.of(rawBarGroups);
          }else{
            showingBarGroups = List.of(rawBarGroups);
            if(touchedGroupIndex != -1){
              double sum = 0;
              for(BarChartRodData rod
                    in showingBarGroups[touchedGroupIndex].barRods){
                sum += rod.y;
              }
              final avg =
                  sum / showingBarGroups[touchedGroupIndex].barRods.length;

              showingBarGroups[touchedGroupIndex] =
                  showingBarGroups[touchedGroupIndex].copyWith(
                    barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod){
                      return rod.copyWith(y: avg);
                    }).toList()
                  );
            }
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  makeTransactionsIcon(),
                  const SizedBox(
                    width: 38,
                  ),
                  Text(
                    '신고 / 처리',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'NotoSans-bold'),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FlChart(
                    chart: BarChart(
                      BarChartData(
                        maxY: 20,
                        barTouchData: BarTouchData(
                          touchTooltipData: TouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItems: (spots){
                              return spots.map((TouchedSpot spot){
                                return null;
                              }).toList();
                            }
                          ),
                          touchResponseSink: barTouchResultStreamController.sink,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            textStyle: TextStyle(
                              color: const Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
                            margin: 4,
                            getTitles: (double value){
                              switch(value.toInt()){
                                case 0:
                                  return 'Jan';
                                case 1:
                                  return 'Feb';
                                case 2:
                                  return 'Mar';
                                case 3:
                                  return 'Apr';
                                case 4:
                                  return 'May';
                                case 5:
                                  return 'Jun';
                                case 6:
                                  return 'Jul';
                                case 7:
                                  return 'Aug';
                                case 8:
                                  return 'Sep';
                                case 9:
                                  return 'Oct';
                                case 10:
                                  return 'Nov';
                                case 11:
                                  return 'Dec';
                                default: return '';
                              }
                            },
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            textStyle: TextStyle(
                              color: const Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
                            margin: 16,
                            reservedSize: 14,
                            getTitles: (value){
                              if(value == 0){
                                return '1';
                              }else if(value == 10){
                                return '10';
                              }else if(value == 19){
                                return '20';
                              }else{
                                return '';
                              }
                            },
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 1, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
        isRound: false,
      ),
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
        isRound: false,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
