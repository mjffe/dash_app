import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
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
  final List<String> states = [
    '0',
    '1',
  ];
  final List<String> types = [
    '0',
    '1',
  ];

  // form values
  String _name = '';
  String _nameUpdated;
  int _value = 0;
  int _valueUpdated;
  String _type = '0';
  String _typeUpdated;
  String _state = '0';
  String _stateUpdated;
  String _proposal = '';
  String _proposalUpdated;

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
          child: Column(
            children: <Widget>[
              Text(
                '${AppLocalizations.of(context).translate('new')} ${AppLocalizations.of(context).translate('sales')}',
                style: TextStyle(fontSize: 18.0),
              ),
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
                  hintText: AppLocalizations.of(context).translate('proposal'),
                ),
                initialValue: _proposal,
                onChanged: (val) => setState(() => _proposal = val),
              ),
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
                onChanged: (val) => setState(() => _value = int.parse(val)),
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
                          _name ?? '',
                          _value ?? 0,
                          _proposal ?? '',
                          _type ?? '0',
                          _state ?? '0');
                      Navigator.pop(context);
                    }
                  }),
            ],
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
                return Form(
                  key: _formkey,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${AppLocalizations.of(context).translate('update')} ${AppLocalizations.of(context).translate('sales')}',
                        style: TextStyle(fontSize: 18.0),
                      ),
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
                        onChanged: (val) => setState(() => _nameUpdated = val),
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
                            setState(() => _valueUpdated = int.parse(val)),
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
                        onChanged: (val) => setState(() => _typeUpdated = val),
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
                        onChanged: (val) => setState(() => _stateUpdated = val),
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
                                  .updateSaleData(
                                      _nameUpdated ?? _name,
                                      _valueUpdated ?? _value,
                                      _proposalUpdated ?? _proposal,
                                      saleData.proposalid ?? '',
                                      _typeUpdated ?? _type,
                                      _stateUpdated ?? _state,
                                      saleData.createdon ?? new DateTime.now());
                              Navigator.pop(context);
                            }
                          }),
                    ],
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
