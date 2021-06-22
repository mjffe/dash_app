import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/dashboard/counters/dash_counters_lead.dart';
import 'package:dashapp/screens/dashboard/counters/dash_counters_lead_types.dart';
import 'package:dashapp/screens/dashboard/counters/dash_counters_raising.dart';
import 'package:dashapp/screens/dashboard/counters/dash_counters_sale_full.dart';
import 'package:dashapp/screens/dashboard/counters/dash_counters_sale_shared.dart';
import 'package:dashapp/screens/dashboard/counters/dash_counters_sales.dart';
import 'package:dashapp/screens/dashboard/counters/dash_counters_scriptures.dart';
import 'package:dashapp/screens/leads/lead.dart';
import 'package:dashapp/screens/raisings/raising.dart';
import 'package:dashapp/screens/sales/sale.dart';
import 'package:dashapp/shared/app_icons.dart';
import 'package:flutter/material.dart';

class Dash_Counters extends StatefulWidget {
  Dash_Counters(this.uData);
  final UserData uData;

  @override
  _Dash_CountersState createState() => _Dash_CountersState(uData);
}

class _Dash_CountersState extends State<Dash_Counters> {
  _Dash_CountersState(this.uData) {
    // Stream<QuerySnapshot> fleadsCount =
    //     DatabaseService().getleadscount2(userId);
    // fleadsCount.hashCode ?? setState(() => leadsCount = 50);
  }
  final UserData uData;

  int leadsCount = 0;
  int angariacaoCount = 0;
  int vendasCount = 0;
  int escriturasCount = 0;

  @override
  Widget build(BuildContext context) {
    _LeadTypeCount() {
      ListBody body = ListBody(children: <Widget>[]);
      //for (String type in uData.leadtypes) {
      for (var i = 0; i < uData.leadtypes.length; i++) {
        String type = uData.leadtypes[i];

        body.children.add(
          GestureDetector(
            onTap: () {
              print('type onTap: ${type}');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LeadTypeFiltred(uData, type)));
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    CircleAvatar(
                      backgroundColor: const Color(0xff2A9D8F), //0xff26a69a
                      child: Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      AppLocalizations.of(context).translate(type),
                      style: TextStyle(
                          color: Colors.black, letterSpacing: 1, fontSize: 14),
                    ),
                  ]),
                  LeadTypeCount(uData, type),
                ]),
          ),
        );
        if (uData.leadtypes.length != (i + 1))
          body.children.add(SizedBox(height: 10.0));
      }
      return body;
    }

    _showLeadsDialog() {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: //Text(AppLocalizations.of(context).translate('leads')),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                  Text(AppLocalizations.of(context).translate('leads')),
                  LeadCount(uData),
                ]),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //                 LeadProspectingFiltred(uData)));
                  //   },
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: <Widget>[
                  //         Row(children: <Widget>[
                  //           CircleAvatar(
                  //             backgroundColor:
                  //                 const Color(0xff2A9D8F), //0xff26a69a
                  //             child: Icon(
                  //               Icons.people,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           Text(
                  //             AppLocalizations.of(context)
                  //                 .translate('prospecting'),
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 letterSpacing: 1,
                  //                 fontSize: 14),
                  //           ),
                  //         ]),
                  //         LeadProspectingCount(uData),
                  //       ]),
                  // ),
                  // SizedBox(height: 10.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //                 LeadBuyerCustomersFiltred(uData)));
                  //   },
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: <Widget>[
                  //         Row(children: <Widget>[
                  //           CircleAvatar(
                  //             backgroundColor:
                  //                 const Color(0xff2A9D8F), //0xff26a69a
                  //             child: Icon(
                  //               Icons.people,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           Text(
                  //             AppLocalizations.of(context)
                  //                 .translate('buyercustomers'),
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 letterSpacing: 1,
                  //                 fontSize: 14),
                  //           ),
                  //         ]),
                  //         LeadBuyerCustomersCount(uData),
                  //       ]),
                  // ),
                  _LeadTypeCount()
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    _showSalesDialog() {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: //Text(AppLocalizations.of(context).translate('leads')),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                  Text(AppLocalizations.of(context).translate('sales')),
                  SalesCount(uData),
                ]),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SaleTypeShareSharedFiltred(uData)));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(children: <Widget>[
                            CircleAvatar(
                              backgroundColor:
                                  const Color(0xff2A9D8F), //0xff26a69a
                              child: Icon(
                                AppIcoons.vendas,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('saleTypeSharefull'),
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1,
                                  fontSize: 14),
                            ),
                          ]),
                          SaleSharedCount(uData),
                        ]),
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SaleTypeShareFullFiltred(uData)));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(children: <Widget>[
                            CircleAvatar(
                              backgroundColor:
                                  const Color(0xff2A9D8F), //0xff26a69a
                              child: Icon(
                                AppIcoons.vendas,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('saleTypeShareshared'),
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1,
                                  fontSize: 14),
                            ),
                          ]),
                          SaleFullCount(uData),
                        ]),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      child: Container(
        // height: 150.0,
        // width: 300.0,
        padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 2.5),
        //symmetric(vertical: 2.5, horizontal: 5),
        color: Colors.transparent,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: new Center(
                child: Table(
                    //border: TableBorder.lerp(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RaisingFiltred(uData)));
                            },
                            child: Container(
                              height: 64,
                              padding: EdgeInsets.only(left: 10),
                              //color: Colors.grey,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: const Color(
                                            0xffE76F51), //0xffff7043
                                        child: Icon(
                                          Icons.home,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('raising'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1,
                                            fontSize: 14),
                                      ),
                                    ]),
                                    RaisingsCount(uData),
                                    // Text(
                                    //   angariacaoCount.toString(),
                                    //   style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 24,
                                    //       fontWeight: FontWeight.bold),
                                    // )
                                  ]),
                            ),
                          ),
                          GestureDetector(
                            // onLongPress: () {
                            //   _showMyDialog();
                            //   print('onLongPress');
                            // },
                            onTap: () {
                              _showLeadsDialog();
                            },
                            child: Container(
                              height: 64,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: const Color(
                                            0xff2A9D8F), //0xff26a69a
                                        child: Icon(
                                          Icons.people,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('leads'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1,
                                            fontSize: 14),
                                      ),
                                    ]),
                                    LeadCount(uData),
                                  ]),
                              //color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             SaleFiltred(uData)));
                              _showSalesDialog();
                            },
                            child: Container(
                              height: 64,
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xff118AB2),
                                        child: Icon(
                                          AppIcoons.vendas,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 5.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('sales'),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 1,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ]),
                                    SalesCount(uData),
                                    // Text(
                                    //   vendasCount.toString(),
                                    //   style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 24,
                                    //       fontWeight: FontWeight.bold),
                                    // )
                                  ]),
                              //color: Colors.yellow,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScripturesFiltred(uData)));
                            },
                            child: Container(
                              height: 64,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xffF4A261),
                                        child: Icon(
                                          AppIcoons.escrituras,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('scriptures'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1,
                                            fontSize: 14),
                                      ),
                                    ]),
                                    ScripturesCount(uData),
                                    // Text(
                                    //   escriturasCount.toString(),
                                    //   style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 24,
                                    //       fontWeight: FontWeight.bold),
                                    // )
                                  ]),
                              //color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ]))),
      ),
    );
  }
}
