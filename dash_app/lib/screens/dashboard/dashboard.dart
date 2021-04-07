import 'package:dashapp/screens/dashboard/dash_counters.dart';
import 'package:dashapp/screens/dashboard/dash_invoice.dart';
import 'package:dashapp/screens/dashboard/dash_piechart.dart';
import 'package:dashapp/screens/dashboard/dash_prospection.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  Dash({Key key}) : super(key: key);

  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(children: <Widget>[
      //Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Dash_Counters(),
          Dash_PieChart(),
          //PieChartSample1(),
          Dash_Prospection(),
          Dash_Invoice()
        ],
      )
    ]));
  }
}
