import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'indicator.dart';




class ChartPage extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  //pieChartSample2
  StreamController<PieTouchResponse> pieTouchedResultStreamController;
  int pieTouchedIndex;

  //lineSample2
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];
  bool showAvg = false;

  //sample1
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = Duration(milliseconds: 250);
  StreamController<BarTouchResponse> sample1BarTouchedResultStreamController;
  int touchedIndex;
  bool isPlaying = false;

  //sample2
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

    //pieChartSample2
    pieTouchedResultStreamController = StreamController();
    pieTouchedResultStreamController.stream.distinct().listen((details){
      if(details == null){
        return;
      }

      setState(() {
        if(details.touchInput is FlLongPressEnd){
          pieTouchedIndex = -1;
        }else{
          pieTouchedIndex = details.touchedSectionPosition;
        }
      });

    });

    //sample1
    sample1BarTouchedResultStreamController = StreamController();
    sample1BarTouchedResultStreamController.stream
      .distinct()
      .listen((BarTouchResponse response){
        if(response == null){
          return;
        }

        if(response.spot == null){
          setState(() {
            touchedIndex = -1;
          });
          return;
        }

        setState(() {
          if(response.touchInput is FlLongPressEnd){
            touchedIndex = -1;
          }else{
            touchedIndex = response.spot.touchedBarGroupPosition;
          }
        });
    });

    //sample2
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          pieSample2(),
//          lineSample2(),
//          barChartSample1(),
//          barChartSample2(),
        ],
      ),
    );
  }

  Widget pieSample2(){
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: FlChart(
                  chart: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(
                            touchResponseStreamSink: pieTouchedResultStreamController.sink),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections()
                    ),
                  ),
                )
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget lineSample2(){
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: const Color(0xff232d37)
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: FlChart(
                  chart: LineChart(
                    showAvg ? avgData() : mainData(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: 34,
            child: FlatButton(
              onPressed: (){
                setState(() {
                  showAvg = !showAvg;
                });
              },
              child: Text(
                'avg',
                style: TextStyle(fontSize: 12, fontFamily: 'NotoSans-bold', color: showAvg ? Colors.white.withOpacity(0.5): Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  LineChartData mainData(){
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalGrid: true,
        getDrawingHorizontalGridLine: (value){
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalGridLine: (value){
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize:22,
          textStyle: TextStyle(color: const Color(0xff68737d), fontFamily: 'NotoSans-bold', fontSize: 16),
          getTitles: (value){
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: const Color(0xff67727d), fontFamily: 'NotoSans-bold', fontSize: 15),
          getTitles: (value){
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const[
            FlSpot(0, 3),
            FlSpot(1, 9),
            FlSpot(2, 10),
            FlSpot(3, 3),
            FlSpot(4, 8),
            FlSpot(5, 5),
            FlSpot(6, 1),
            FlSpot(7, 4),
            FlSpot(8, 8),
            FlSpot(9, 1),
            FlSpot(10, 8),
            FlSpot(11, 5),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalGrid: true,
        getDrawingVerticalGridLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalGridLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
              color: const Color(0xff68737d),
              fontFamily: 'NotoSans-bold',
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontFamily: 'NotoSans-bold',
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 5),
            FlSpot(1, 5),
            FlSpot(2, 5),
            FlSpot(3, 5),
            FlSpot(4, 5),
            FlSpot(5, 5),
            FlSpot(6, 5),
            FlSpot(7, 5),
            FlSpot(8, 5),
            FlSpot(9, 5),
            FlSpot(10, 5),
            FlSpot(11, 5),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }

  Widget barChartSample1(){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.indigo,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text('신고 처리율',style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'NotoSans-bold'),),
                    const SizedBox(height: 1,),
                    Text('2019년',style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'NotoSans-thin'),),
                    const SizedBox(height: 24,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.8),
                        child: FlChart(
                          swapAnimationDuration: animDuration,
                          chart:
                          BarChart(isPlaying ? randomData() : mainBarData()),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.music_note, color: Colors.pinkAccent,),
                    onPressed: (){
                      setState(() {
                        isPlaying = !isPlaying;
                        if(isPlaying){
                          refreshState();
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData sample1MakeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color barColor = Colors.white,
        double width =20,
      }){
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: isTouched ? y + 1 : y,
        color: isTouched ? Colors.pinkAccent : barColor,
        width: width,
        isRound: true,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y:20,
          color: barBackgroundColor,
        )
      )
    ]);
  }


  @override
  void dispose() {
    super.dispose();
    sample1BarTouchedResultStreamController.close();
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
    switch (i) {
      case 0:
        return sample1MakeGroupData(0, 16, isTouched: i == touchedIndex);
      case 1:
        return sample1MakeGroupData(1, 6.5, isTouched: i == touchedIndex);
      case 2:
        return sample1MakeGroupData(2, 5, isTouched: i == touchedIndex);
      case 3:
        return sample1MakeGroupData(3, 7.5, isTouched: i == touchedIndex);
      case 4:
        return sample1MakeGroupData(4, 9, isTouched: i == touchedIndex);
      case 5:
        return sample1MakeGroupData(5, 19, isTouched: i == touchedIndex);
      case 6:
        return sample1MakeGroupData(6, 6.5, isTouched: i == touchedIndex);
      case 7:
        return sample1MakeGroupData(7, 5, isTouched: i == touchedIndex);
      case 8:
        return sample1MakeGroupData(8, 6.5, isTouched: i == touchedIndex);
      case 9:
        return sample1MakeGroupData(9, 5, isTouched: i == touchedIndex);
      case 10:
        return sample1MakeGroupData(10, 7.5, isTouched: i == touchedIndex);
      case 11:
        return sample1MakeGroupData(11, 9, isTouched: i == touchedIndex);
      default:
        return null;
    }
  });
  
  BarChartData mainBarData(){
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: TouchTooltipData(
          tooltipBgColor: Colors.indigoAccent,
          getTooltipItems: (touchedSpots){
            return touchedSpots.map((touchedSpot){
              String months;
              switch(touchedSpot.spot.x.toInt()){
                case 0:
                  months = 'Jan';
                  break;
                case 1:
                  months = 'Feb';
                  break;
                case 2:
                  months = 'Mar';
                  break;
                case 3:
                  months = 'Apr';
                  break;
                case 4:
                  months = 'May';
                  break;
                case 5:
                  months = 'Jun';
                  break;
                case 6:
                  months = 'Jul';
                  break;
                case 7:
                  months = 'Aug';
                  break;
                case 8:
                  months = 'Sep';
                  break;
                case 9:
                  months = 'Oct';
                  break;
                case 10:
                  months = 'Nov';
                  break;
                case 11:
                  months = 'Dec';
                  break;
              }
              return TooltipItem(months + '\n' + (touchedSpot.spot.y - 1).toString(), TextStyle(color: Colors.white, fontFamily: 'NotoSans-thin'));
            }).toList();
          }
        ),
        touchResponseSink: sample1BarTouchedResultStreamController.sink,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: Colors.white, fontFamily: 'NotoSans-bold', fontSize:14),
          margin: 16,
          getTitles: (double value){
            switch(value.toInt()){
              case 0:
                return '01';
              case 1:
                return '02';
              case 2:
                return '03';
              case 3:
                return '04';
              case 4:
                return '05';
              case 5:
                return '06';
              case 6:
                return '07';
              case 7:
                return '08';
              case 8:
                return '09';
              case 9:
                return '10';
              case 10:
                return '11';
              case 11:
                return '12';
              default:
                return '';
            }
          }
        ),
        leftTitles: const SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData(){
    return BarChartData(
      barTouchData: const BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: Colors.white, fontFamily: 'NotoSans-bold', fontSize: 14),
          margin: 16,
          getTitles: (double value){
            switch(value.toInt()){
              case 0:
                return '01';
              case 1:
                return '02';
              case 2:
                return '03';
              case 3:
                return '04';
              case 4:
                return '05';
              case 5:
                return '06';
              case 6:
                return '07';
              case 7:
                return '08';
              case 8:
                return '09';
              case 9:
                return '10';
              case 10:
                return '11';
              case 11:
                return '12';
              default:
                return '';
            }
          }
        ),
        leftTitles: const SideTitles(
          showTitles: false,
        )
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(12, (i){
        switch(i){
          case 0:
            return sample1MakeGroupData(0, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 1:
            return sample1MakeGroupData(1, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 2:
            return sample1MakeGroupData(2, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 3:
            return sample1MakeGroupData(3, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 4:
            return sample1MakeGroupData(4, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 5:
            return sample1MakeGroupData(5, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 6:
            return sample1MakeGroupData(6, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 7:
            return sample1MakeGroupData(7, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 8:
            return sample1MakeGroupData(8, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 9:
            return sample1MakeGroupData(9, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 10:
            return sample1MakeGroupData(10, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          case 11:
            return sample1MakeGroupData(11, Random().nextInt(15).toDouble() + 6,
            barColor: widget.availableColors[
            Random().nextInt(widget.availableColors.length)]);
          default:
          return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {

    });
    await Future<dynamic>.delayed(animDuration + Duration(milliseconds: 50));
    if(isPlaying){
      refreshState();
    }
  }

  Widget barChartSample2(){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
                                  fontFamily: 'NotoSans-bold',
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
                                  fontFamily: 'NotoSans-bold',
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
