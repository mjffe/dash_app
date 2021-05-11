import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/dash.dart';
import 'package:dashapp/models/prospectingtime.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/dashboard/dash_prospection_view_model.dart';
import 'package:dashapp/screens/prospectingtime/prospectingtime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";

class Dash_ProspectingTime extends StatelessWidget {
  //final AuthService _auth = AuthService();
  Dash_ProspectingTime(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<DashProspectionViewModel>(
      create: (_) => DashProspectionViewModel(uData: uData),
      child: Dash_Prospection(uData),
    );

    // return StreamProvider<List<ProspectingTimeItem>>.value(
    //   initialData: null,
    //   value: DatabaseService().getprospectingtime(uData.uid, 0),
    //   child: Dash_Prospection(),
    // );
  }
}

class Dash_Prospection extends StatefulWidget {
  //Dash_Prospection2({Key key}) : super(key: key);
  Dash_Prospection(this.uData);
  final UserData uData;

  @override
  _Dash_ProspectionState createState() => _Dash_ProspectionState(uData);
}

class _Dash_ProspectionState extends State<Dash_Prospection> {
  _Dash_ProspectionState(this.uData);
  final UserData uData;

  List<Dash> data;
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<DashProspectionViewModel>(context, listen: false);
    return StreamBuilder<List<ProspectingTimeItem>>(
        stream: viewModel.prospectingTimeStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProspectingTimeItem> prospections = snapshot.data;
            if (prospections != null) if (prospections.length > 0) {
              //print('List of Prospection: ${prospections[0]}');
              Map newMap = groupBy(
                  prospections, (ProspectingTimeItem obj) => obj.datemonth);
              if (newMap == null) {
                return Text('data3');
              }
              Map groupedAndSum = Map();
              newMap.forEach((k, v) {
                groupedAndSum[k] = {
                  // 'group': k,
                  // 'list': v,
                  'sumOfduration': v.fold(
                      0,
                      (prev, ProspectingTimeItem element) =>
                          prev + element.duration),
                };
              });
              data = groupedAndSum.entries
                  .map((entry) => Dash(entry.key, entry.value['sumOfduration'],
                      AppLocalizations.of(context).locale.languageCode))
                  .toList();
              data.sort((a, b) => a.monthNumber.compareTo(b.monthNumber));
              //data.sortBy((Dash element) => element.monthNumber);
              // .sortedBy((Dash element) => element.monthNumber);
              //print(data.toString());
              return Container(
                  child: Container(
                padding: new EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
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
                              title: ChartTitle(
                                  text: AppLocalizations.of(context)
                                      .translate('ProspectingTimeTitle')),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: false),
                              //backgroundColor
                              backgroundColor: Colors.grey[100],
                              onPointTapped: (PointTapArgs args) {
                                // print(args.seriesIndex);
                                // print(args.pointIndex);
                                print(args.dataPoints[args.pointIndex].x);
                                int month = Dash.fromMonthToNumber(
                                    args.dataPoints[args.pointIndex].x);
                                print(month);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProspectingTimeFiltred(
                                                uData, month)));
                              },
                              selectionGesture: ActivationMode.doubleTap,
                              //onChartTouchInteractionDown: SelectionChangedHandler(),
                              //borderColor: Colors.red,// cor a volta do grafico
                              //series
                              series: <ChartSeries<Dash, String>>[
                                BarSeries<Dash, String>(
                                  dataSource: data,
                                  xValueMapper: (Dash sales, _) => sales.month,
                                  yValueMapper: (Dash sales, _) => sales.value,
                                  name: AppLocalizations.of(context)
                                      .translate('ProspectingTimeName'),

                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true),
                                  color: Color(
                                      0xff4ea8de), //118ab2 // 5390d9 //4ea8de
                                )
                              ]),
                        ))),
              ));
            }
          }
          // por defeito mostra um loading até o stream encontrar dados
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
                  padding: EdgeInsets.all(2),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );

          //return CircularProgressIndicator();
        });
  }

  // @override
  // Widget build(BuildContext context) {
  //   final prospections = Provider.of<List<ProspectingTimeItem>>(context) ?? [];
  //   final user = Provider.of<FirebaseUser>(context);
  //   //Provider.of<FirebaseUser>(context, listen: false);
  //   //print('List of Prospection: ${prospections.length}');
  //   if (prospections != null) if (prospections.length > 0) {
  //     //print('List of Prospection: ${prospections[0]}');
  //     Map newMap =
  //         groupBy(prospections, (ProspectingTimeItem obj) => obj.datemonth);
  //     if (newMap == null) {
  //       return Text('data3');
  //     }
  //     Map groupedAndSum = Map();
  //     newMap.forEach((k, v) {
  //       groupedAndSum[k] = {
  //         // 'group': k,
  //         // 'list': v,
  //         'sumOfduration': v.fold(0,
  //             (prev, ProspectingTimeItem element) => prev + element.duration),
  //       };
  //     });
  //     data = groupedAndSum.entries
  //         .map((entry) => Dash(entry.key, entry.value['sumOfduration'],
  //             AppLocalizations.of(context).locale.languageCode))
  //         .toList();
  //     data.sort((a, b) => a.monthNumber.compareTo(b.monthNumber));
  //     //data.sortBy((Dash element) => element.monthNumber);
  //     // .sortedBy((Dash element) => element.monthNumber);
  //     //print(data.toString());
  //     return Container(
  //         child: Container(
  //       // height: 150.0,
  //       // width: 300.0,
  //       padding: new EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
  //       color: Colors.transparent,
  //       child: Container(
  //           decoration: BoxDecoration(
  //               color: Colors.grey[100],
  //               borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //           child: new Padding(
  //               padding: EdgeInsets.all(2),
  //               child: new Center(
  //                 child: SfCartesianChart(
  //                     primaryXAxis: CategoryAxis(),
  //                     // Chart title
  //                     title: ChartTitle(
  //                         text: AppLocalizations.of(context)
  //                             .translate('ProspectingTimeTitle')),
  //                     // Enable legend
  //                     legend: Legend(isVisible: false),
  //                     // Enable tooltip
  //                     tooltipBehavior: TooltipBehavior(enable: false),
  //                     //backgroundColor
  //                     backgroundColor: Colors.grey[100],
  //                     onPointTapped: (PointTapArgs args) {
  //                       // print(args.seriesIndex);
  //                       // print(args.pointIndex);
  //                       print(args.dataPoints[args.pointIndex].x);
  //                       int month = Dash.fromMonthToNumber(
  //                           args.dataPoints[args.pointIndex].x);
  //                       print(month);
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) =>
  //                                   ProspectingTimeFiltred(user.uid, month)));
  //                     },
  //                     selectionGesture: ActivationMode.doubleTap,
  //                     //onChartTouchInteractionDown: SelectionChangedHandler(),
  //                     //borderColor: Colors.red,// cor a volta do grafico
  //                     //series
  //                     series: <ChartSeries<Dash, String>>[
  //                       BarSeries<Dash, String>(
  //                         dataSource: data,
  //                         xValueMapper: (Dash sales, _) => sales.month,
  //                         yValueMapper: (Dash sales, _) => sales.value,
  //                         name: AppLocalizations.of(context)
  //                             .translate('ProspectingTimeName'),

  //                         // Enable data label
  //                         dataLabelSettings: DataLabelSettings(isVisible: true),
  //                         color: Color(0xff4ea8de), //118ab2 // 5390d9 //4ea8de
  //                       )
  //                     ]),
  //               ))),
  //     ));
  //   }

  //   // por defeito mostra um loading até o stream encontrar dados
  //   return Container(
  //     child: Container(
  //       // height: 150.0,
  //       // width: 300.0,
  //       padding: new EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
  //       color: Colors.transparent,
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: Colors.grey[100],
  //             borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //         child: new Padding(
  //           padding: EdgeInsets.all(2),
  //           child: CircularProgressIndicator(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
