import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Dash_PieChart extends StatefulWidget {
  // Dash_PieChart({Key key}) : super(key: key);

  @override
  _Dash_PieChartState createState() => _Dash_PieChartState();
}

class _Dash_PieChartState extends State<Dash_PieChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      // height: 150.0,
      // width: 300.0,
      padding: new EdgeInsets.all(10.0),
      color: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: new Padding(
              padding: EdgeInsets.all(3),
              child: new Center(child: PieChartSample2()))),
    ));
  }
}

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Container(
        color: Colors.grey[100],
        child: Row(
          children: <Widget>[
            //const SizedBox(
            //height: 18,
            // ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: Color(0xffD81159), //0xff0293ee
                  text: 'APS',
                  isSquare: true,
                  fontWeight:
                      touchedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xffFFBC42), //0xfff8b250
                  text: 'CMI',
                  isSquare: true,
                  fontWeight:
                      touchedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef), //0xff845bef
                  text: 'Propostas',
                  isSquare: true,
                  fontWeight:
                      touchedIndex == 2 ? FontWeight.bold : FontWeight.normal,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff218380), //0xff13d38e
                  text: 'CPCV',
                  isSquare: true,
                  fontWeight:
                      touchedIndex == 3 ? FontWeight.bold : FontWeight.normal,
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
            // const SizedBox(
            //   width: 28,
            // ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffD81159), //0xff0293ee 
            value: 40,
            title: '40',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffFFBC42), //0xfff8b250
            value: 30,
            title: '30',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 20,
            title: '20',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff218380), //0xff13d38e
            value: 15,
            title: '15',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;
  final FontWeight fontWeight;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = Colors.black, //const Color(0xff505050),
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
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
          style: TextStyle(
              //fontSize: 14, fontWeight: FontWeight.bold,
              fontWeight: fontWeight,
              color: textColor),
        )
      ],
    );
  }
}
