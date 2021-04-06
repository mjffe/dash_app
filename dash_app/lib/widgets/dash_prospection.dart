import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dash_Prospection extends StatefulWidget {
  Dash_Prospection({Key key}) : super(key: key);

  @override
  _Dash_ProspectionState createState() => _Dash_ProspectionState();
}

class _Dash_ProspectionState extends State<Dash_Prospection> {
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
