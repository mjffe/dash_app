import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/dashboard/dash_counters.dart';
import 'package:dashapp/screens/dashboard/dash_invoiceOld.dart';
import 'package:dashapp/screens/dashboard/dash_invoice.dart';
import 'package:dashapp/screens/dashboard/dash_piechart.dart';
import 'package:dashapp/screens/dashboard/dash_prospection.dart';
import 'package:dashapp/screens/dashboard/dash_rating.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  Dash({this.uData});
  final UserData uData;

  @override
  _DashState createState() => _DashState(uData);
}

class _DashState extends State<Dash> {
  _DashState(this.uData);
  final UserData uData;
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    // return StreamBuilder<UserData>(
    //     stream: DatabaseService().userInfo(user.uid),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         UserData uData = snapshot.data;
    //         return SingleChildScrollView(
    //             child: Stack(children: <Widget>[
    //           //Stack(children: <Widget>[
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: <Widget>[
    //               Dash_Counters(uData),
    //               Dash_PieChart(uData),
    //               Dash_ProspectingTime(uData),
    //               Dash_LineChart(uData)
    //             ],
    //           )
    //         ]));
    //       } else {
    //         return Loading();
    //       }
    //     });

    return SingleChildScrollView(
        child: Stack(children: <Widget>[
      //Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Dash_Counters(uData),
          Dash_Rating(uData),
          Dash_PieChart(uData),
          Dash_ProspectingTime(uData),
          //Dash_LineChart(uData),
          Dash_LineChart2(uData)
        ],
      )
    ]));
  }
}
