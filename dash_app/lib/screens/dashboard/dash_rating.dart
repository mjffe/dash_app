import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/rating.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/dashboard/dash_rating_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dash_Rating extends StatefulWidget {
  //Dash_Rating({Key? key}) : super(key: key);
  Dash_Rating(this.uData);
  final UserData uData;

  @override
  _Dash_RatingState createState() => _Dash_RatingState(uData);
}

class _Dash_RatingState extends State<Dash_Rating> {
  _Dash_RatingState(this.uData);
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
              child: new Center(child: RatingStreamData_set(uData)
                  //PieChartSample2(2, 3, 4, 1)
                  //PieChartSample2()
                  ))),
    ));
  }
}

class RatingStreamData_set extends StatelessWidget {
  RatingStreamData_set(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<RatingViewModel>(
      create: (_) => RatingViewModel(uData: uData),
      child: RatingStreamData(uData),
    );
  }
}

class RatingStreamData extends StatelessWidget {
  RatingStreamData(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RatingViewModel>(context, listen: false);
    return StreamBuilder<List<RatingItem>>(
        stream: viewModel.ratingStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            List<RatingItem> itens = snapshot.data;
            return Rating(
              uData,
              itens,
            );
          }
          return CircularProgressIndicator();
          //Text('Loading');
          //return PieChartSample2(2, 2, 2, 2);
        });
  }
}

class Rating extends StatefulWidget {
  //Rating({Key? key}) : super(key: key);
  Rating(this.uData, this.itens);
  final UserData uData;
  final List<RatingItem> itens;
  @override
  _RatingState createState() => _RatingState(uData, itens);
}

class _RatingState extends State<Rating> {
  _RatingState(this.uData, this.itens);
  final UserData uData;
  final List<RatingItem> itens;
  //double _rating;
  double _userRating = 2.5; //3.0;
  // int _ratingBarMode = 1;
  // double _initialRating = 2.0;
  // bool _isRTLMode = false;
  bool _isVertical = false;
  // IconData _selectedIcon;
  @override
  Widget build(BuildContext context) {
    RatingItem item =
        itens.firstWhere((element) => element.userId == uData.uid);
    _userRating = 5 * item.raisingsales / item.raisingCount;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //SizedBox(width: 0),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    AppLocalizations.of(context).translate('success_rate'),
                    style: TextStyle(
                        color: Colors.black, letterSpacing: 1, fontSize: 14),
                  ),
                ),
                SizedBox(width: 5.0),
                RatingBarIndicator(
                  rating: _userRating,
                  itemBuilder: (context, index) => Icon(
                    Icons.home,
                    color: Color(0xffFCCA46),
                  ),
                  itemCount: 5,
                  itemSize: 40.0,
                  unratedColor: Colors.amber.withAlpha(50),
                  direction: _isVertical ? Axis.vertical : Axis.horizontal,
                )
              ]),
          ClassificationPoints(uData, itens),
        ],
      ),
    );
  }
}

class ClassificationPoints extends StatefulWidget {
  //ClassificationPoints({Key? key}) : super(key: key);
  ClassificationPoints(this.uData, this.itens);
  final UserData uData;
  final List<RatingItem> itens;
  @override
  _ClassificationPointsState createState() =>
      _ClassificationPointsState(uData, itens);
}

class _ClassificationPointsState extends State<ClassificationPoints> {
  _ClassificationPointsState(this.uData, this.itens);
  final UserData uData;
  final List<RatingItem> itens;

  @override
  Widget build(BuildContext context) {
    if (uData.role == '0' || uData.role == '1') {
      // return SfCircularChart(
      //     //https://help.syncfusion.com/flutter/circular-charts/circular-series-customization
      //     legend: Legend(isVisible: true),
      //     // Enable tooltip
      //     tooltipBehavior: TooltipBehavior(enable: true),
      //     series: <PieSeries<RatingItem, String>>[
      //       PieSeries(
      //         dataSource: itens,
      //         xValueMapper: (RatingItem invo, _) => invo.userName,
      //         yValueMapper: (RatingItem invo, _) => invo.points,
      //       )
      //     ]);
      double chartheight = 55.0 * itens.length;
      return Container(
        height: chartheight, // height of the Container widget
        //width: 250, // width of the Container widget
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(isVisible: false),
            // Chart title
            title: ChartTitle(
                text: AppLocalizations.of(context).translate('points_rating'),
                alignment: ChartAlignment.near,
                textStyle: TextStyle(
                    color: Colors.black, letterSpacing: 1, fontSize: 12)),
            // Enable legend
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: false),
            //backgroundColor
            backgroundColor: Colors.grey[100],
            //selectionGesture: ActivationMode.doubleTap,
            //onChartTouchInteractionDown: SelectionChangedHandler(),
            //borderColor: Colors.red,// cor a volta do grafico
            //series
            series: <ChartSeries<RatingItem, String>>[
              BarSeries<RatingItem, String>(
                dataSource: itens,
                xValueMapper: (RatingItem sales, _) => sales.userName,
                yValueMapper: (RatingItem sales, _) => sales.points,
                name: AppLocalizations.of(context)
                    .translate('ProspectingTimeName'),

                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: false),
                color: Color(0xffffaa00), //4ea8de //118ab2 // 5390d9 //4ea8de
              )
            ]),
      );
    } else {
      return Container(
        child: null,
      );
    }
  }
}
