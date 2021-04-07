import 'package:dashapp/shared/app_icons.dart';
import 'package:flutter/material.dart';

class Dash_Counters extends StatefulWidget {
  Dash_Counters({Key key}) : super(key: key);

  @override
  _Dash_CountersState createState() => _Dash_CountersState();
}

class _Dash_CountersState extends State<Dash_Counters> {
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
                          Container(
                            height: 64,
                            padding: EdgeInsets.only(left: 10),
                            //color: Colors.grey,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor:
                                          const Color(0xffE76F51), //0xffff7043
                                      child: Icon(
                                        Icons.home,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Angariação",
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1,
                                          fontSize: 14),
                                    ),
                                  ]),
                                  Text(
                                    "6",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: 64,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor:
                                          const Color(0xff2A9D8F), //0xff26a69a
                                      child: Icon(
                                        Icons.people,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Lead",
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1,
                                          fontSize: 14),
                                    ),
                                  ]),
                                  Text(
                                    "26",
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 1,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                            //color: Colors.blue,
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(
                            height: 64,
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: const Color(0xff118AB2),
                                      child: Icon(
                                        AppIcoons.vendas,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Vendas",
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1,
                                          fontSize: 14),
                                    ),
                                  ]),
                                  Text(
                                    "9",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                            //color: Colors.yellow,
                          ),
                          Container(
                            height: 64,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: const Color(0xffF4A261),
                                      child: Icon(
                                        AppIcoons.escrituras,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Escrituras",
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1,
                                          fontSize: 14),
                                    ),
                                  ]),
                                  Text(
                                    "16",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                            //color: Colors.red,
                          ),
                        ],
                      ),
                    ]))),
      ),
    );
  }
}
