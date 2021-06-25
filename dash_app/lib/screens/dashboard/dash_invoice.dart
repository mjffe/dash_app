import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/dash.dart';
import 'package:dashapp/models/invoicechart.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/dashboard/dash_invoice_view_model.dart';
import 'package:dashapp/screens/invoicing/invoicing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";

class Dash_LineChart2 extends StatefulWidget {
  // Dash_PieChart({Key key}) : super(key: key);
  Dash_LineChart2(this.uData);
  final UserData uData;

  @override
  _Dash_LineChart2State2 createState() => _Dash_LineChart2State2(uData);
}

class _Dash_LineChart2State2 extends State<Dash_LineChart2> {
  _Dash_LineChart2State2(this.uData);
  final UserData uData;

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
              child: new Center(child: LineChartStreamData02(uData)
                  //PieChartSample2(2, 3, 4, 1)
                  //PieChartSample2()
                  ))),
    ));
  }
}

class LineChartStreamData02 extends StatelessWidget {
  LineChartStreamData02(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<InvoiceChartViewModel>(
      create: (_) => InvoiceChartViewModel(uData: uData),
      child: LineChartStreamData2(uData),
    );
  }
}

class LineChartStreamData2 extends StatelessWidget {
  LineChartStreamData2(this.uData);
  final UserData uData;
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<InvoiceChartViewModel>(context, listen: false);
    return StreamBuilder<InvoiceChartItem>(
        stream: viewModel.invoiceChartStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Dash> invoicesDash;
            List<Dash> salesDash;
            List<Dash> objectivesDash;
            if (snapshot.data.invoices.length > 0) {
              Map invoicesgroup = groupBy(
                  snapshot.data.invoices, (ChartItem obj) => obj.datemonth);
              if (invoicesgroup == null) {
                return Text('data3');
              }
              Map invoicesSum = Map();
              invoicesgroup.forEach((k, v) {
                invoicesSum[k] = {
                  // 'group': k,
                  // 'list': v,
                  'sumOfduration': v.fold(
                      0, (prev, ChartItem element) => prev + element.value),
                };
              });
              invoicesDash = invoicesSum.entries
                  .map((entry) => Dash(entry.key, entry.value['sumOfduration'],
                      AppLocalizations.of(context).locale.languageCode))
                  .toList();

              //tenho que ter a certeza que existe uma entrada para todos os meses
              for (var i = 1; i < 13; i++) {
                //if (salesDash.any((element) => element.monthNumber != i))
                if (invoicesDash.firstWhere(
                        (element) => element.monthNumber == i,
                        orElse: () => null) ==
                    null) {
                  invoicesDash.add(new Dash(
                      i, 0, AppLocalizations.of(context).locale.languageCode));
                }
              }

              invoicesDash
                  .sort((a, b) => a.monthNumber.compareTo(b.monthNumber));
            }
            if (snapshot.data.sales.length > 0) {
              Map salesgroup = groupBy(
                  snapshot.data.sales, (ChartItem obj) => obj.datemonth);
              // if (salesgroup == null) {
              //   return Text('data3');
              // }
              Map salesSum = Map();
              salesgroup.forEach((k, v) {
                salesSum[k] = {
                  // 'group': k,
                  // 'list': v,
                  'sumOfduration': v.fold(
                      0, (prev, ChartItem element) => prev + element?.value),
                };
              });
              salesDash = salesSum.entries
                  .map((entry) => Dash(entry.key, entry.value['sumOfduration'],
                      AppLocalizations.of(context).locale.languageCode))
                  .toList();

              //tenho que ter a certeza que existe uma entrada para todos os meses
              for (var i = 1; i < 13; i++) {
                //if (salesDash.any((element) => element.monthNumber != i))
                if (salesDash.firstWhere((element) => element.monthNumber == i,
                        orElse: () => null) ==
                    null) {
                  salesDash.add(new Dash(
                      i, 0, AppLocalizations.of(context).locale.languageCode));
                }
              }

              salesDash.sort((a, b) => a.monthNumber.compareTo(b.monthNumber));
            }
            if (snapshot.data.objectives.length > 0) {
              Map newMap = groupBy(snapshot.data.objectives,
                  (ObjectiveItem obj) => obj.datemonth);
              if (newMap == null) {
                return Text('data4');
              }
              Map groupedAndSum = Map();
              newMap.forEach((k, v) {
                groupedAndSum[k] = {
                  // 'group': k,
                  // 'list': v,
                  'sumOfduration': v.fold(
                      0, (prev, ObjectiveItem element) => prev + element.value),
                };
              });
              objectivesDash = groupedAndSum.entries
                  .map((entry) => Dash(entry.key, entry.value['sumOfduration'],
                      AppLocalizations.of(context).locale.languageCode))
                  .toList();
              objectivesDash
                  .sort((a, b) => a.monthNumber.compareTo(b.monthNumber));
            }
            if (invoicesDash != null || objectivesDash != null)
              return Dash_Invoice2(
                  invoicesDash, salesDash, objectivesDash, uData);
            else
              return CircularProgressIndicator();
          }
          return CircularProgressIndicator();
        });
  }
}

class Dash_Invoice2 extends StatefulWidget {
  Dash_Invoice2(
      this.invoicesDash, this.salesDash, this.objectivesDash, this.uData);
  List<Dash> invoicesDash;
  List<Dash> salesDash;
  List<Dash> objectivesDash;
  final UserData uData;
  @override
  _Dash_InvoiceState2 createState() =>
      _Dash_InvoiceState2(invoicesDash, salesDash, objectivesDash, uData);
}

class _Dash_InvoiceState2 extends State<Dash_Invoice2> {
  _Dash_InvoiceState2(
      this.invoicesDash, this.salesDash, this.objectivesDash, this.uData);
  List<Dash> invoicesDash;
  List<Dash> salesDash;
  List<Dash> objectivesDash;
  final UserData uData;

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
                title: ChartTitle(
                  text: AppLocalizations.of(context).translate('invoicing'),
                  // 'invoicingtest',
                ),
                // Enable legend
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                // Enable tooltip
                //tooltipBehavior: TooltipBehavior(enable: true),
                trackballBehavior: TrackballBehavior(enable: true),
                //backgroundColor
                backgroundColor: Colors.grey[100],
                onPointTapped: (PointTapArgs args) {
                  //print(args.dataPoints[args.pointIndex].x);
                  //print(args.dataPoints[args.pointIndex].regionData[2]);
                  int month = Dash.fromMonthToNumber(
                      args.dataPoints[args.pointIndex].x);
                  //print(month);
                  if (args.dataPoints[args.pointIndex].regionData[2] !=
                      AppLocalizations.of(context).translate('objectives')) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               ObjectiveFiltred(uData.uid, 0)));
                    // } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InvoicingFiltred(uData, month)));
                  }
                },
                //onChartTouchInteractionDown: SelectionChangedHandler(),
                //borderColor: Colors.red,// cor a volta do grafico
                //series
                series: <ChartSeries<Dash, String>>[
                  StackedColumnSeries(
                      dataSource: invoicesDash,
                      xValueMapper: (Dash invo, _) => invo.month,
                      yValueMapper: (Dash invo, _) => invo.value,
                      color: Color(0xff006400),
                      name: AppLocalizations.of(context)
                          .translate('invoicing'), //invoicing
                      //dataLabelSettings: DataLabelSettings(isVisible: true),
                      markerSettings: MarkerSettings(
                          isVisible: true,
                          width: 5,
                          height: 5,
                          shape: DataMarkerType.horizontalLine,
                          borderWidth: 2,
                          borderColor: Color(0xff006400))),
                  StackedColumnSeries(
                      dataSource: salesDash,
                      xValueMapper: (Dash sales, _) => sales.month,
                      yValueMapper: (Dash sales, _) => sales.value,
                      color: Color(0xff90be6d), //95d5b2
                      name: AppLocalizations.of(context)
                          .translate('sales'), //invoicing
                      //dataLabelSettings: DataLabelSettings(isVisible: true),
                      markerSettings: MarkerSettings(
                          isVisible: true,
                          width: 5,
                          height: 5,
                          shape: DataMarkerType.horizontalLine,
                          borderWidth: 2,
                          borderColor: Color(0xff95d5b2))),
                  LineSeries(
                      dataSource: objectivesDash,
                      xValueMapper: (Dash sales, _) => sales.month,
                      yValueMapper: (Dash sales, _) => sales.value,
                      name: AppLocalizations.of(context)
                          .translate('objectives'), //objectives
                      //color: Color(0xffec8385),
                      color: Color(0xffda344d),
                      //dataLabelSettings: DataLabelSettings(isVisible: true),

                      markerSettings: MarkerSettings(
                          isVisible: true,
                          width: 5,
                          height: 5,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: Color(0xffec8385))),
                ]),
          ),
        ),
      ),
    ));
  }
}
