import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/decimalinput.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ObjectiveForm extends StatefulWidget {
  ObjectiveForm(this.userId, this.docId);
  final String userId;
  final String docId;

  @override
  _ObjectiveFormState createState() => _ObjectiveFormState(userId, docId);
}

class _ObjectiveFormState extends State<ObjectiveForm> {
  _ObjectiveFormState(this.userId, this.docId);
  final String userId;
  final String docId;
  final _formkey = GlobalKey<FormState>();

  // form values
  String _name = '';
  double _value = 0;
  String _nameUpdated;
  double _valueUpdated;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDateUpdated;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);

    if (docId.isEmpty)
      return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Text(
              '${AppLocalizations.of(context).translate('new')} ${AppLocalizations.of(context).translate('objectives')}',
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
            RaisedButton(
                onPressed: () {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: _selectedDate,
                    locale: AppLocalizations.of(context).locale,
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                      });
                    }
                  });
                },
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text('Target'),
                    SizedBox(width: 10.0),
                    Icon(Icons.calendar_today),
                  ],
                )),
            // DateTimePicker(
            //   dateMask: 'MM/yyyy',
            //   initialValue: '',
            //   firstDate: DateTime(2000),
            //   lastDate: DateTime(2100),
            //   dateLabelText: 'Date',
            //   onChanged: (val) =>
            //       setState(() => _selectedDate = DateTime.parse(val)),
            //   validator: (val) => val.isEmpty
            //       ? AppLocalizations.of(context).translate('validname')
            //       : null,
            //   //onSaved: (val) => print(val),
            // ),
            SizedBox(height: 10.0),
            RaisedButton(
                color: MyColors.lightBlue,
                child: Text(
                  AppLocalizations.of(context).translate('create'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    await DatabaseService(uid: userId).createObjectiveData(
                        _name ?? '',
                        _value ?? 0,
                        _selectedDate ?? DateTime.now());
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      );
    else {
      return StreamBuilder<ObjectiveItem>(
          stream: DatabaseService(uid: userId, docid: docId).objectiveData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ObjectiveItem data = snapshot.data;
              _name = data.name;
              _value = data.value;
              _selectedDate = data.date;
              return Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${AppLocalizations.of(context).translate('update')} ${AppLocalizations.of(context).translate('objectives')}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText:
                            AppLocalizations.of(context).translate('name'),
                      ),
                      initialValue: _name,
                      validator: (val) => val.isEmpty
                          ? AppLocalizations.of(context).translate('validname')
                          : null,
                      onChanged: (val) => setState(() => _nameUpdated = val),
                    ),
                    SizedBox(height: 20.0),
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
                          ? AppLocalizations.of(context).translate('validvalue')
                          : null,
                      onChanged: (val) =>
                          setState(() => _valueUpdated = double.parse(val)),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        onPressed: () {
                          showMonthPicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 1, 5),
                            lastDate: DateTime(DateTime.now().year + 1, 9),
                            initialDate: _selectedDate,
                            locale: AppLocalizations.of(context).locale,
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                _selectedDateUpdated = date;
                              });
                            }
                          });
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)
                                .translate('DateTarget')),
                            SizedBox(width: 10.0),
                            Icon(Icons.calendar_today),
                          ],
                        )),
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
                                .updateObjectiveData(
                                    _nameUpdated ?? _name,
                                    _valueUpdated ?? _value,
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
          });
    }
  }
}
