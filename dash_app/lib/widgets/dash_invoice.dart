import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dash_Invoice extends StatefulWidget {
  Dash_Invoice({Key key}) : super(key: key);

  @override
  _Dash_InvoiceState createState() => _Dash_InvoiceState();
}

class _Dash_InvoiceState extends State<Dash_Invoice> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  List<_SalesData> dat2 = [
    _SalesData('Jan', 40),
    _SalesData('Feb', 30),
    _SalesData('Mar', 30),
    _SalesData('Apr', 35),
    _SalesData('May', 45)
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
                //margin: EdgeInsets.all(20),

                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Faturação'),
                // Enable legend
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                //backgroundColor
                backgroundColor: Colors.grey[100],

                //onChartTouchInteractionDown: SelectionChangedHandler(),
                //borderColor: Colors.red,// cor a volta do grafico
                //series
                series: <LineSeries<_SalesData, String>>[
                  LineSeries(
                      dataSource: dat2,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: "Objetivo",
                      color: Color(0xffec8385),
                      markerSettings: MarkerSettings(
                          isVisible: true,
                          width: 5,
                          height: 5,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: Color(0xffec8385))),
                  LineSeries(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      color: Color(0xff006400),
                      name: "Faturação",
                      markerSettings: MarkerSettings(
                          isVisible: true,
                          width: 5,
                          height: 5,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: Color(0xff006400))),
                ]),
          ),
        ),
      ),
    ));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
