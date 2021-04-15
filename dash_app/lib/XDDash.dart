import 'package:dashapp/screens/dashboard/dash_counters.dart';
import 'package:dashapp/screens/dashboard/dash_invoice.dart';
import 'package:dashapp/screens/dashboard/dash_piechart.dart';
import 'package:dashapp/screens/dashboard/dash_prospection.dart';

import 'widgets/drawerMenu.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  Dash({Key key}) : super(key: key);

  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(
              //fontFamily: 'Segoe UI',
              fontSize: 35,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff4169e1),
        ),
        drawer: dMenu(),
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          //Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Dash_Counters(''),
              Dash_PieChart(),
              //PieChartSample1(),
              Dash_Prospection2(),
              Dash_Invoice()
            ],
          )
        ])));
  }
}
