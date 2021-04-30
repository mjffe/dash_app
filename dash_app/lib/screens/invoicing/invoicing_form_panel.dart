import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/decimalinput.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class InvoicingFormPanel extends StatefulWidget {
  InvoicingFormPanel(this.userId, this.docId);
  final String userId;
  final String docId;

  @override
  _InvoicingFormPanelState createState() =>
      _InvoicingFormPanelState(userId, docId);
}

class _InvoicingFormPanelState extends State<InvoicingFormPanel> {
  _InvoicingFormPanelState(this.userId, this.docId);
  final String userId;
  final String docId;
  final _formkey = GlobalKey<FormState>();

  // form values
  String _name = '';
  double _value = 0;
  String _home = '';
  String _nameUpdated;
  double _valueUpdated;
  String _homeUpdated;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDateUpdated;

  @override
  Widget build(BuildContext context) {
    if (docId.isEmpty)
      return Scaffold(
        appBar:
            customAppBar(AppLocalizations.of(context).translate('sales')).bar(),
        body: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Text(
                '${AppLocalizations.of(context).translate('new')} ${AppLocalizations.of(context).translate('invoicing')}',
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
                  hintText: AppLocalizations.of(context).translate('value'),
                ),
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                initialValue: _name,
                validator: (val) => val.isEmpty
                    ? AppLocalizations.of(context).translate('validvalue')
                    : null,
                onChanged: (val) => setState(() => _value = double.parse(val)),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: AppLocalizations.of(context).translate('home'),
                ),
                initialValue: _home,
                validator: (val) => val.isEmpty
                    ? AppLocalizations.of(context).translate('validhome')
                    : null,
                onChanged: (val) => setState(() => _home = val),
              ),
              SizedBox(height: 20.0),
              DateTimePicker(
                dateMask: 'dd/MM/yyyy',
                initialValue: '',
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: AppLocalizations.of(context).translate('date'),
                onChanged: (val) =>
                    setState(() => _selectedDate = DateTime.parse(val)),
                validator: (val) => val.isEmpty
                    ? AppLocalizations.of(context).translate('validdate')
                    : null,
                //onSaved: (val) => print(val),
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
                      await DatabaseService(uid: userId).createInvoicingData(
                          _name ?? '',
                          _value ?? 0,
                          _home ?? '',
                          _selectedDate ?? DateTime.now());
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
        body: StreamBuilder<InvoicingItem>(
            stream: DatabaseService(uid: userId, docid: docId).invoicingData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                InvoicingItem data = snapshot.data;
                _name = data.name;
                _value = data.value;
                _selectedDate = data.date;
                return Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '${AppLocalizations.of(context).translate('update')} ${AppLocalizations.of(context).translate('invoicing')}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${AppLocalizations.of(context).translate('name')}:",
                            style: TextStyle(
                              letterSpacing: 1.2,
                            ),
                          )),
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
                            "${AppLocalizations.of(context).translate('value')}:",
                            style: TextStyle(
                              letterSpacing: 1.2,
                            ),
                          )),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText:
                              AppLocalizations.of(context).translate('value'),
                        ),
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 2)
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
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
                            "${AppLocalizations.of(context).translate('home')}:",
                            style: TextStyle(
                              letterSpacing: 1.2,
                            ),
                          )),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText:
                              AppLocalizations.of(context).translate('home'),
                        ),
                        initialValue: _home,
                        validator: (val) => val.isEmpty
                            ? AppLocalizations.of(context)
                                .translate('validhome')
                            : null,
                        onChanged: (val) => setState(() => _homeUpdated = val),
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
                                  .updateInvoicingData(
                                      _nameUpdated ?? _name,
                                      _valueUpdated ?? _value,
                                      _homeUpdated ?? _home,
                                      _selectedDateUpdated ?? _selectedDate);
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
