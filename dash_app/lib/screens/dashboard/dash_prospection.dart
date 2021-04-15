import 'package:dashapp/models/prospectingtime.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";

class Dash_ProspectingTime extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<ProspectingTimeItem>>.value(
      initialData: null,
      value: DatabaseService().getprospectingtime(user),
      child: Dash_Prospection(),
    );
  }
}

class Dash_Prospection extends StatelessWidget {
  const Dash_Prospection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final raisings = Provider.of<List<ProspectingTimeItem>>(context) ?? [];
    print('List of Prospection: ${raisings}');
    if (raisings != null) {
      Map newMap = groupBy(raisings, (obj) => obj['datemonth']);
      Map groupedAndSum = Map();
      newMap.forEach((k, v) {
        groupedAndSum[k] = {
          'group': k,
          'list': v,
          'sumOfduration':
              v.fold(0, (prev, element) => prev + element['duration']),
        };
      });
      print(groupedAndSum.toString());
    }
    return Text('data');
  }
}

class Dash_Prospection2 extends StatefulWidget {
  Dash_Prospection2({Key key}) : super(key: key);

  @override
  _Dash_Prospection2State createState() => _Dash_Prospection2State();
}

class _Dash_Prospection2State extends State<Dash_Prospection2> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Abr', 32),
    _SalesData('Mai', 40),
    _SalesData('Jun', 33),
    _SalesData('Jul', 39),
    _SalesData('Ago', 25),
    _SalesData('Set', 26),
    _SalesData('Oct', 42),
    _SalesData('Nov', 39),
    _SalesData('Dec', 29)
  ];

  @override
  Widget build(BuildContext context) {
    final raisings = Provider.of<List<ProspectingTimeItem>>(context) ?? [];

    Map newMap = groupBy(raisings, (obj) => obj['datemonth']);
    Map groupedAndSum = Map();
    newMap.forEach((k, v) {
      groupedAndSum[k] = {
        'group': k,
        'list': v,
        'sumOfduration':
            v.fold(0, (prev, element) => prev + element['duration']),
      };
    });

    print(groupedAndSum.toString());
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
              padding: EdgeInsets.all(2),
              child: new Center(
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'Prospecting Time'),
                    // Enable legend
                    legend: Legend(isVisible: false),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    //backgroundColor
                    backgroundColor: Colors.grey[100],

                    //onChartTouchInteractionDown: SelectionChangedHandler(),
                    //borderColor: Colors.red,// cor a volta do grafico
                    //series
                    series: <ChartSeries<_SalesData, String>>[
                      BarSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Time',

                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false),
                        color: Color(0xff4ea8de), //118ab2 // 5390d9 //4ea8de
                      )
                    ]),
              ))),
    ));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
