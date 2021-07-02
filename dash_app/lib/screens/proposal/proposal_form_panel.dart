import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/proposal.dart';
import 'package:dashapp/models/raising.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/screens/sales/sales_form_panel.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProposalForm extends StatefulWidget {
  ProposalForm(this.userId, this.docId);
  final String userId;
  final String docId;

  @override
  _ProposalFormState createState() => _ProposalFormState(userId, docId);
}

class _ProposalFormState extends State<ProposalForm> {
  _ProposalFormState(this.userId, this.docId);
  final String userId;
  final String docId;
  final _formkey = GlobalKey<FormState>();

  // form values
  String _name = '';
  String _nameUpdated;
  double _value = 0;
  double _valueUpdated;
  String _house = "";
  String _houseid = "";
  List<RaisingItem> raisings = [];

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);

    if (docId.isEmpty)
      return Scaffold(
          appBar:
              customAppBar(AppLocalizations.of(context).translate('proposal'))
                  .bar(),
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  // Text(
                  //   '${AppLocalizations.of(context).translate('new')} ${AppLocalizations.of(context).translate('proposal')}',
                  //   style: TextStyle(fontSize: 18.0),
                  // ),
                  SizedBox(height: 20.0),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${AppLocalizations.of(context).translate('name')}:",
                        style: TextStyle(
                          //fontSize: 10,
                          letterSpacing: 1.2,
                        ),
                      )),
                  TextFormField(
                    decoration: textInputDecoration,
                    // .copyWith(
                    //   hintText: AppLocalizations.of(context).translate('name'),
                    // ),
                    initialValue: _name,
                    validator: (val) => val.isEmpty
                        ? AppLocalizations.of(context).translate('validname')
                        : null,
                    onChanged: (val) => setState(() => _name = val),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${AppLocalizations.of(context).translate('value')}:",
                        style: TextStyle(
                          //fontSize: 10,
                          letterSpacing: 1.2,
                        ),
                      )),

                  TextFormField(
                    decoration: textInputDecoration,
                    // .copyWith(
                    //   hintText: AppLocalizations.of(context).translate('value'),
                    // ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    initialValue: _name,
                    validator: (val) => val.isEmpty
                        ? AppLocalizations.of(context).translate('validvalue')
                        : null,
                    onChanged: (val) =>
                        setState(() => _value = double.parse(val)),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${AppLocalizations.of(context).translate('house')}:",
                        style: TextStyle(
                          letterSpacing: 1.2,
                        ),
                      )),

                  StreamBuilder<List<RaisingItem>>(
                      //https://github.com/whatsupcoders/FlutterDropDown/blob/master/lib/main.dart
                      stream: DatabaseService(uid: userId, docid: docId)
                          .getAvailableHousesData,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Text("Loading.....");
                        else {
                          List<RaisingItem> d = snapshot.data;
                          raisings = d;
                          List<DropdownMenuItem> houseItems = [];
                          for (var i = 0; i < d.length; i++) {
                            RaisingItem raising = d[i];
                            houseItems.add(
                              DropdownMenuItem(
                                child: Text(
                                  raising.name,
                                  // style: TextStyle(
                                  //     color: Color(0xff11b719)),
                                ),
                                value: "${raising.id}",
                              ),
                            );
                          }

                          return DropdownButtonFormField(
                              decoration: textInputDecoration.copyWith(
                                hintText: AppLocalizations.of(context)
                                    .translate('Selected an house'),
                              ),
                              //items: houseItems,
                              items: d.map((type) {
                                return DropdownMenuItem(
                                  value: type.id,
                                  child: Text(type.name),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() => _houseid = val);
                                setState(() => _house =
                                    d.where((e) => e.id == val).first.name);
                              });
                        }
                      }),

                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: MyColors.lightBlue,
                      child: Text(
                        AppLocalizations.of(context).translate('create'),
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          // RaisingItem ri;
                          // if (raisings.length > 0) {
                          //   ri = raisings
                          //       .where((e) =>
                          //           e.id == _houseid ?? data.houseid)
                          //       .first;
                          //   ri.state = 'reserved';
                          //   await DatabaseService(
                          //           uid: userId, docid: docId)
                          //       .updateRaisingData(ri);
                          // }

                          await DatabaseService(uid: userId)
                              .createProposalData(new ProposalItem(
                            name: _name ?? '',
                            value: _value ?? 0,
                            state: '0',
                            house: _house,
                            houseid: _houseid,
                          ));
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            ),
          ));
    else {
      return Scaffold(
          appBar:
              customAppBar(AppLocalizations.of(context).translate('proposal'))
                  .bar(),
          body: StreamBuilder<ProposalItem>(
              stream: DatabaseService(uid: userId, docid: docId).proposalData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ProposalItem data = snapshot.data;
                  _name = data.name;
                  _value = data.value;
                  return Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          // Text(
                          //   '${AppLocalizations.of(context).translate('update')} ${AppLocalizations.of(context).translate('proposal')}',
                          //   style: TextStyle(fontSize: 18.0),
                          // ),
                          SizedBox(height: 20.0),
                          Container(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${AppLocalizations.of(context).translate('name')}:",
                                    style: TextStyle(
                                      //fontSize: 10,
                                      letterSpacing: 1.2,
                                    ),
                                  ))),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: AppLocalizations.of(context)
                                  .translate('name'),
                            ),
                            initialValue: _name,
                            validator: (val) => val.isEmpty
                                ? AppLocalizations.of(context)
                                    .translate('validname')
                                : null,
                            onChanged: (val) =>
                                setState(() => _nameUpdated = val),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${AppLocalizations.of(context).translate('value')}:",
                                    style: TextStyle(
                                      //fontSize: 10,
                                      letterSpacing: 1.2,
                                    ),
                                  ))),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: AppLocalizations.of(context)
                                  .translate('value'),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            initialValue: _value.toString(),
                            validator: (val) => val.isEmpty
                                ? AppLocalizations.of(context)
                                    .translate('validvalue')
                                : null,
                            onChanged: (val) => setState(
                                () => _valueUpdated = double.parse(val)),
                          ),
                          SizedBox(height: 20.0),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${AppLocalizations.of(context).translate('house')}:",
                                style: TextStyle(
                                  letterSpacing: 1.2,
                                ),
                              )),

                          StreamBuilder<List<RaisingItem>>(
                              //https://github.com/whatsupcoders/FlutterDropDown/blob/master/lib/main.dart
                              stream: DatabaseService(uid: userId, docid: docId)
                                  .getAvailableHousesData,
                              builder: (context, snapshot) {
                                List<RaisingItem> d = [];
                                List<DropdownMenuItem> houseItems = [];

                                if (!snapshot.hasData)
                                  return Text("Loading.....");
                                else {
                                  d = snapshot.data;
                                  raisings = d;

                                  houseItems.add(
                                    DropdownMenuItem(
                                      child: Text(''),
                                      value: '',
                                    ),
                                  );
                                  for (var i = 0; i < d.length; i++) {
                                    RaisingItem raising = d[i];

                                    houseItems.add(
                                      DropdownMenuItem(
                                        child: Text(
                                          raising.name,
                                        ),
                                        value: "${raising.id}",
                                      ),
                                    );
                                  }

                                  return DropdownButtonFormField(
                                      decoration: textInputDecoration.copyWith(
                                        hintText: AppLocalizations.of(context)
                                            .translate('Selected an house'),
                                      ),
                                      //items: houseItems,
                                      items: houseItems,
                                      value: data.houseid,
                                      onChanged: (val) {
                                        setState(() => _houseid = val);
                                        setState(() => _house = d
                                            .where((e) => e.id == val)
                                            .first
                                            .name);
                                      });
                                }
                              }),

                          SizedBox(height: 10.0),
                          RaisedButton(
                              color: MyColors.lightBlue,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('update'),
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  // RaisingItem ri;
                                  // if (raisings.length > 0) {
                                  //   ri = raisings
                                  //       .where((e) =>
                                  //           e.id == _houseid ?? data.houseid)
                                  //       .first;
                                  //   ri.state = 'reserved';
                                  //   await DatabaseService(
                                  //           uid: userId, docid: docId)
                                  //       .updateRaisingData(ri);
                                  // }

                                  await DatabaseService(
                                          uid: userId, docid: docId)
                                      .updateProposalData(new ProposalItem(
                                          name: _nameUpdated ?? _name,
                                          value: _valueUpdated ?? _value,
                                          state: data.state,
                                          house: _house ?? data.house,
                                          houseid: _houseid ?? data.houseid,
                                          createdby: data.createdby,
                                          createdon: data.createdon));
                                  Navigator.pop(context);
                                }
                              }),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OutlinedButton(
                                    //color: MyColors.lightBlue,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('tolost'),
                                      style:
                                          TextStyle(color: MyColors.lightRed),
                                    ),
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        await DatabaseService(
                                                uid: userId, docid: docId)
                                            .updateProposalToLost(
                                                new ProposalItem(
                                                    name: _nameUpdated ?? _name,
                                                    value:
                                                        _valueUpdated ?? _value,
                                                    state: '1',
                                                    house: data.house,
                                                    houseid: data.houseid,
                                                    createdby: data.createdby,
                                                    createdon: data.createdon));
                                        Navigator.pop(context);
                                      }
                                    }),
                                SizedBox(width: 20.0),
                                OutlinedButton(
                                    //color: MyColors.lightBlue,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('towon'),
                                      style:
                                          TextStyle(color: MyColors.lightGreen),
                                    ),
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        await DatabaseService(
                                                uid: userId, docid: docId)
                                            .updateProposalToWon(
                                                new ProposalItem(
                                                    name: _nameUpdated ?? _name,
                                                    value:
                                                        _valueUpdated ?? _value,
                                                    state: '2',
                                                    house: data.house,
                                                    houseid: data.houseid,
                                                    createdby: data.createdby,
                                                    createdon: data.createdon));
                                        String docid = await DatabaseService(
                                                uid: userId)
                                            .createSaleFromProposalData(
                                                new SaleItem(
                                                    name: '',
                                                    value:
                                                        _valueUpdated ?? _value,
                                                    type: '0',
                                                    state: '0',
                                                    statereason: '0',
                                                    proposal:
                                                        _nameUpdated ?? _name,
                                                    proposalid: data.id,
                                                    house: data.house ?? '',
                                                    houseid:
                                                        data.houseid ?? ''));

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SalesFormPanel(
                                                        userId, docid)));
                                      }
                                    }),
                              ]),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Loading();
                }
              }));
    }
  }
}
