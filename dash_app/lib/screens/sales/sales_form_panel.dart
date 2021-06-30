import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/raising.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/screens/invoicing/invoicing_form_panel.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SalesFormPanel extends StatefulWidget {
  SalesFormPanel(this.userId, this.docId);
  final String userId;
  final String docId;

  @override
  _SalesFormPanelState createState() => _SalesFormPanelState(userId, docId);
}

class _SalesFormPanelState extends State<SalesFormPanel> {
  _SalesFormPanelState(this.userId, this.docId);
  final String userId;
  final String docId;
  final _formkey = GlobalKey<FormState>();
  final List<String> states = ['0', '1', '2'];
  final List<String> types = [
    '0',
    '1',
  ];

  // form values
  String _name = '';
  String _nameUpdated;
  double _value = 0;
  double _valueUpdated;
  String _type = '0';
  String _typeUpdated;
  String _state = '0';
  String _stateUpdated;
  String _proposal = '';
  String _proposalUpdated;
  String _house = '';
  String _houseid = '';
  String _houseUpdated;
  String _houseidUpdated;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDateUpdated;

  String _getTypeName(String index) {
    switch (index) {
      case '0':
        {
          return AppLocalizations.of(context).translate('saleTypeShareshared');
        }
        break;
      case '1':
        {
          return AppLocalizations.of(context).translate('saleTypeSharefull');
        }
        break;
      default:
        return '';
    }
  }

  String _getStateName(String index) {
    switch (index) {
      case '0':
        {
          return AppLocalizations.of(context).translate('promise_buy_sell');
        }
        break;
      case '1':
        {
          return AppLocalizations.of(context).translate('scriptures');
        }
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);

    if (docId.isEmpty)
      return Scaffold(
        appBar:
            customAppBar(AppLocalizations.of(context).translate('sales')).bar(),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                // Text(
                //   '${AppLocalizations.of(context).translate('new')} ${AppLocalizations.of(context).translate('sales')}',
                //   style: TextStyle(fontSize: 18.0),
                // ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: AppLocalizations.of(context).translate('name'),
                  ),
                  initialValue: _name,
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.of(context).translate('validname')
                      : null,
                  onChanged: (val) => setState(() => _name = val),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText:
                        AppLocalizations.of(context).translate('proposal'),
                  ),
                  initialValue: _proposal,
                  onChanged: (val) => setState(() => _proposal = val),
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

                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: AppLocalizations.of(context).translate('value'),
                  ),
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
                      "${AppLocalizations.of(context).translate('date')}:",
                      style: TextStyle(
                        letterSpacing: 1.2,
                      ),
                    )),
                DateTimePicker(
                  dateMask: 'dd/MM/yyyy',
                  initialValue: _selectedDate.toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: AppLocalizations.of(context).translate('date'),
                  onChanged: (val) => setState(
                      () => _selectedDateUpdated = DateTime.parse(val)),
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.of(context).translate('validdate')
                      : null,
                  //onSaved: (val) => print(val),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  value: _type,
                  decoration: textInputDecoration,
                  items: states.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: //Text('sdfsdf'),
                          Text(_getTypeName(type)),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _type = val),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  value: _state,
                  decoration: textInputDecoration,
                  items: states.map((state) {
                    return DropdownMenuItem(
                      value: state,
                      child: //Text('sdfsdf'),
                          Text(_getStateName(state)),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _state = val),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                    color: MyColors.lightBlue,
                    child: Text(
                      AppLocalizations.of(context).translate('create'),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        await DatabaseService(uid: userId).createSaleData(
                            new SaleItem(
                                name: _name ?? '',
                                value: _value ?? 0,
                                type: _type ?? '0',
                                date: _selectedDate ?? DateTime.now(),
                                state: _state ?? '0',
                                proposal: _proposal ?? '',
                                proposalid: '',
                                house: _house ?? '',
                                houseid: _houseid ?? ''));
                        Navigator.pop(context);
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    else {
      return Scaffold(
        appBar:
            customAppBar(AppLocalizations.of(context).translate('sales')).bar(),
        body: StreamBuilder<SaleItem>(
            stream: DatabaseService(uid: userId, docid: docId).saleData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SaleItem saleData = snapshot.data;
                _name = saleData.name;
                _value = saleData.value;
                _proposal = saleData.proposal;
                _type = saleData.type;
                _state = saleData.state;
                //_houseid = saleData.houseid;
                //_house = saleData.house;
                return Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text(
                        //   '${AppLocalizations.of(context).translate('update')} ${AppLocalizations.of(context).translate('sales')}',
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
                            hintText:
                                AppLocalizations.of(context).translate('name'),
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
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${AppLocalizations.of(context).translate('proposal')}:",
                              style: TextStyle(
                                letterSpacing: 1.2,
                              ),
                            )),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: AppLocalizations.of(context)
                                .translate('proposal'),
                          ),
                          initialValue: _proposal,
                          onChanged: (val) =>
                              setState(() => _proposalUpdated = val),
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
                                List<DropdownMenuItem> houseItems = [];
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
                                    value: saleData.houseid,
                                    onChanged: (val) {
                                      setState(() => _houseidUpdated = val);
                                      setState(() => _houseUpdated = d
                                          .where((e) => e.id == val)
                                          .first
                                          .name);
                                    });
                              }
                            }),

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
                            hintText:
                                AppLocalizations.of(context).translate('value'),
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
                          onChanged: (val) =>
                              setState(() => _valueUpdated = double.parse(val)),
                        ),
                        SizedBox(height: 20.0),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${AppLocalizations.of(context).translate('date')}:",
                              style: TextStyle(
                                letterSpacing: 1.2,
                              ),
                            )),
                        DateTimePicker(
                          dateMask: 'dd/MM/yyyy',
                          initialValue: saleData.date.toString(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText:
                              AppLocalizations.of(context).translate('date'),
                          onChanged: (val) => setState(
                              () => _selectedDateUpdated = DateTime.parse(val)),
                          validator: (val) => val.isEmpty
                              ? AppLocalizations.of(context)
                                  .translate('validdate')
                              : null,
                          //onSaved: (val) => print(val),
                        ),
                        SizedBox(height: 20.0),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${AppLocalizations.of(context).translate('saleType')}:",
                              style: TextStyle(
                                //fontSize: 10,
                                letterSpacing: 1.2,
                              ),
                            )),
                        DropdownButtonFormField(
                          value: _type,
                          decoration: textInputDecoration,
                          items: types.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: //Text('sdfsdf'),
                                  Text(_getTypeName(type)),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _typeUpdated = val),
                        ),
                        SizedBox(height: 20.0),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${AppLocalizations.of(context).translate('state')}:",
                              style: TextStyle(
                                //fontSize: 10,
                                letterSpacing: 1.2,
                              ),
                            )),
                        DropdownButtonFormField(
                          value: _state,
                          decoration: textInputDecoration,
                          items: states.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: //Text('sdfsdf'),
                                  Text(_getStateName(type)),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _stateUpdated = val),
                        ),
                        SizedBox(height: 10.0),
                        RaisedButton(
                            color: MyColors.lightBlue,
                            child: Text(
                              AppLocalizations.of(context).translate('update'),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                await DatabaseService(uid: userId, docid: docId)
                                    .updateSaleData(new SaleItem(
                                        name: _nameUpdated ?? _name,
                                        value: _valueUpdated ?? _value,
                                        date: _selectedDateUpdated ??
                                            _selectedDate,
                                        type: _typeUpdated ?? _type,
                                        state: _stateUpdated ?? _state,
                                        proposal: _proposal ?? '',
                                        proposalid: saleData.proposalid,
                                        house: _houseUpdated ?? saleData.house,
                                        houseid:
                                            _houseidUpdated ?? saleData.houseid,
                                        createdby: saleData.createdby,
                                        createdon: saleData.createdon ??
                                            new DateTime.now()));
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
                                        .translate('tolostsale'),
                                    style: TextStyle(color: MyColors.lightRed),
                                  ),
                                  onPressed: () async {
                                    if (_formkey.currentState.validate()) {
                                      await DatabaseService(
                                              uid: userId, docid: docId)
                                          .updateSaleData(new SaleItem(
                                              name: _nameUpdated ?? _name,
                                              value: _valueUpdated ?? _value,
                                              type: _typeUpdated ?? _type,
                                              state: '1',
                                              proposal: _proposal ?? '',
                                              proposalid: saleData.proposalid,
                                              house: saleData.house,
                                              houseid: saleData.houseid,
                                              createdby: saleData.createdby,
                                              createdon: saleData.createdon ??
                                                  new DateTime.now()));
                                      Navigator.pop(context);
                                    }
                                  }),
                              SizedBox(width: 20.0),
                              OutlinedButton(
                                  //color: MyColors.lightBlue,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('towonsale'),
                                    style:
                                        TextStyle(color: MyColors.lightGreen),
                                  ),
                                  onPressed: () async {
                                    if (_formkey.currentState.validate()) {
                                      await DatabaseService(
                                              uid: userId, docid: docId)
                                          .updateSaleData(new SaleItem(
                                              name: _nameUpdated ?? _name,
                                              value: _valueUpdated ?? _value,
                                              type: _typeUpdated ?? _type,
                                              state: '2',
                                              proposal: _proposal ?? '',
                                              proposalid: saleData.proposalid,
                                              house: saleData.house,
                                              houseid: saleData.houseid,
                                              createdby: saleData.createdby,
                                              createdon: saleData.createdon ??
                                                  new DateTime.now()));
                                      String docid = await DatabaseService(
                                              uid: userId)
                                          .createInvoicingDataFromSale(
                                              new InvoicingItem(
                                                  name: _nameUpdated ?? _name,
                                                  value:
                                                      _valueUpdated ?? _value,
                                                  house: saleData.house,
                                                  houseid: saleData.houseid,
                                                  date: DateTime.now(),
                                                  sale: _nameUpdated ?? _name,
                                                  saleid: docId));

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InvoicingFormPanel(
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
            }),
      );
    }
  }
}
