import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/dash.dart';
import 'package:dashapp/models/invoicechart.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/dashboard/dash_invoice_view_model.dart';
import 'package:dashapp/screens/invoicing/invoicing.dart';
import 'package:dashapp/screens/objective/objective.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";

class Dash_LineChart extends StatefulWidget {
  // Dash_PieChart({Key key}) : super(key: key);
  Dash_LineChart(this.uData);
  final UserData uData;

  @override
  _Dash_LineChartState createState() => _Dash_LineChartState(uData);
}

class _Dash_LineChartState extends State<Dash_LineChart> {
  _Dash_LineChartState(this.uData);
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
              child: new Center(child: LineChartStreamData0(uData)
                  //PieChartSample2(2, 3, 4, 1)
                  //PieChartSample2()
                  ))),
    ));
  }
}

class LineChartStreamData0 extends StatelessWidget {
  LineChartStreamData0(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<InvoiceChartViewModel>(
      create: (_) => InvoiceChartViewModel(uData: uData),
      child: LineChartStreamData(uData),
    );
  }
}

class LineChartStreamData extends StatelessWidget {
  LineChartStreamData(this.uData);
  final UserData uData;
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<InvoiceChartViewModel>(context, listen: false);
    return StreamBuilder<InvoiceChartItem>(
        stream: viewModel.moviesUserFavouritesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Dash> invoicesDash;
            List<Dash> objectivesDash;
            if (snapshot.data.invoices.length > 0) {
              Map invoicesgroup = groupBy(
                  snapshot.data.invoices, (InvoicingItem obj) => obj.datemonth);
              if (invoicesgroup == null) {
                return Text('data3');
              }
              Map invoicesSum = Map();
              invoicesgroup.forEach((k, v) {
                invoicesSum[k] = {
                  // 'group': k,
                  // 'list': v,
                  'sumOfduration': v.fold(
                      0, (prev, InvoicingItem element) => prev + element.value),
                };
              });
              invoicesDash = invoicesSum.entries
                  .map((entry) => Dash(entry.key, entry.value['sumOfduration'],
                      AppLocalizations.of(context).locale.languageCode))
                  .toList();
              invoicesDash
                  .sort((a, b) => a.monthNumber.compareTo(b.monthNumber));
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
            return Dash_Invoice(invoicesDash, objectivesDash, uData);
          }
          return CircularProgressIndicator();
          //Text('Loading');
          //return PieChartSample2(2, 2, 2, 2);
        });
  }
}

class Dash_Invoice extends StatefulWidget {
  Dash_Invoice(this.invoicesDash, this.objectivesDash, this.uData);
  List<Dash> invoicesDash;
  List<Dash> objectivesDash;
  final UserData uData;
  @override
  _Dash_InvoiceState createState() =>
      _Dash_InvoiceState(invoicesDash, objectivesDash, uData);
}

class _Dash_InvoiceState extends State<Dash_Invoice> {
  _Dash_InvoiceState(this.invoicesDash, this.objectivesDash, this.uData);
  List<Dash> invoicesDash;
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
                    text: AppLocalizations.of(context)
                        .translate('invoicing')), //invoicing
                // Enable legend
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                //backgroundColor
                backgroundColor: Colors.grey[100],
                onPointTapped: (PointTapArgs args) {
                  print(args.dataPoints[args.pointIndex].x);
                  print(args.dataPoints[args.pointIndex].regionData[2]);
                  int month = Dash.fromMonthToNumber(
                      args.dataPoints[args.pointIndex].x);
                  print(month);
                  if (args.dataPoints[args.pointIndex].regionData[2] ==
                      AppLocalizations.of(context).translate('objectives')) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ObjectiveFiltred(uData.uid, month)));
                  } else {
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
                series: <LineSeries<Dash, String>>[
                  LineSeries(
                      dataSource: objectivesDash,
                      xValueMapper: (Dash sales, _) => sales.month,
                      yValueMapper: (Dash sales, _) => sales.value,
                      name: AppLocalizations.of(context)
                          .translate('objectives'), //objectives
                      color: Color(0xffec8385),
                      markerSettings: MarkerSettings(
                          isVisible: true,
                          width: 5,
                          height: 5,
                          shape: DataMarkerType.circle,
                          borderWidth: 2,
                          borderColor: Color(0xffec8385))),
                  LineSeries(
                      dataSource: invoicesDash,
                      xValueMapper: (Dash sales, _) => sales.month,
                      yValueMapper: (Dash sales, _) => sales.value,
                      color: Color(0xff006400),
                      name: AppLocalizations.of(context)
                          .translate('invoicing'), //invoicing
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
