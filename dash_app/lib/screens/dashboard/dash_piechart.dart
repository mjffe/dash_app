import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/piechart.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/dashboard/dash_piechart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

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
      padding: new EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
      color: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: new Padding(
              padding: EdgeInsets.all(3),
              child: new Center(child: PieChartStreamData0()
                  //PieChartSample2(2, 3, 4, 1)
                  //PieChartSample2()
                  ))),
    ));
  }
}

class PieChartStreamData0 extends StatelessWidget {
  const PieChartStreamData0({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Provider<PieChartViewModel>(
      create: (_) => PieChartViewModel(userId: user.uid),
      child: PieChartStreamData(),
    );
  }
}

class PieChartStreamData extends StatelessWidget {
  //const PieChartStreamData({Key key}) : super(key: key);

  // static Widget create(BuildContext context) {
  //   final user = Provider.of<FirebaseUser>(context);
  //   return Provider<PieChartViewModel>(
  //     create: (_) => PieChartViewModel(userId: user.uid),
  //     child: PieChartStreamData(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PieChartViewModel>(context, listen: false);
    return StreamBuilder<PieChartItem>(
        stream: viewModel.moviesUserFavouritesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PieChartSample2(
                snapshot.data.apsCount,
                snapshot.data.cmiCount,
                snapshot.data.propostasCount,
                snapshot.data.cpvcCount);
          }
          return CircularProgressIndicator();
          //Text('Loading');
          //return PieChartSample2(2, 2, 2, 2);
        });
  }
}

class PieChartSample2 extends StatefulWidget {
  PieChartSample2(
    this.aps,
    this.cmi,
    this.pro,
    this.cpvc,
  );
  int aps;
  int cmi;
  int pro;
  int cpvc;
  @override
  State<StatefulWidget> createState() => PieChart2State(aps, cmi, pro, cpvc);
}

class PieChart2State extends State {
  PieChart2State(int aps, int cmi, int pro, int cpvc) {
    apsCount = aps.toDouble();
    cmiCount = cmi.toDouble();
    propostasCount = pro.toDouble();
    cpvcCount = cpvc.toDouble();
  }
  int touchedIndex = -1;
  double apsCount;
  double cmiCount;
  double propostasCount;
  double cpvcCount;

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
                  text: AppLocalizations.of(context)
                      .translate('service_presentation'),
                  isSquare: true,
                  fontWeight:
                      touchedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xffFFBC42), //0xfff8b250
                  text: AppLocalizations.of(context)
                      .translate('mediation_contract_abrv'),
                  isSquare: true,
                  fontWeight:
                      touchedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef), //0xff845bef
                  text: AppLocalizations.of(context).translate('proposal'),
                  isSquare: true,
                  fontWeight:
                      touchedIndex == 2 ? FontWeight.bold : FontWeight.normal,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff218380), //0xff13d38e
                  text: AppLocalizations.of(context)
                      .translate('promise_buy_sell_abrv'),
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
            value: apsCount,
            title: apsCount.toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffFFBC42), //0xfff8b250
            value: cmiCount,
            title: cmiCount.toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: propostasCount,
            title: propostasCount.toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff218380), //0xff13d38e
            value: cpvcCount,
            title: cpvcCount.toInt().toString(),
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
