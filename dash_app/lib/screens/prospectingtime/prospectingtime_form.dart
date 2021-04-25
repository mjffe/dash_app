import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/prospectingtime.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/decimalinput.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProspectingTimeForm extends StatefulWidget {
  ProspectingTimeForm(this.userId, this.docId);
  final String userId;
  final String docId;

  @override
  _ProspectingTimeFormState createState() =>
      _ProspectingTimeFormState(userId, docId);
}

class _ProspectingTimeFormState extends State<ProspectingTimeForm> {
  _ProspectingTimeFormState(this.userId, this.docId);
  final String userId;
  final String docId;
  final _formkey = GlobalKey<FormState>();

  // form values
  String _name = '';
  String _nameUpdated;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDateUpdated;
  double _duration = 0;
  double _durationUpdated;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);

    if (docId.isEmpty)
      return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Text(
              '${AppLocalizations.of(context).translate('new')} ${AppLocalizations.of(context).translate('prospecting_time')}',
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
            DateTimePicker(
              dateMask: 'dd/MM/yyyy',
              initialValue: '',
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              onChanged: (val) =>
                  setState(() => _selectedDate = DateTime.parse(val)),
              validator: (val) => val.isEmpty
                  ? AppLocalizations.of(context).translate('validname')
                  : null,
              //onSaved: (val) => print(val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                hintText: AppLocalizations.of(context).translate('duration'),
              ),
              inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              // keyboardType: TextInputType.number,
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.digitsOnly
              // ],
              initialValue: _name,
              validator: (val) => val.isEmpty
                  ? AppLocalizations.of(context).translate('validduration')
                  : null,
              onChanged: (val) => setState(() => _duration = double.parse(val)),
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
                    await DatabaseService(uid: userId)
                        .createProspectingTimeData(_name ?? '',
                            _selectedDate ?? DateTime.now(), _duration ?? 0);
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      );
    else {
      return StreamBuilder<ProspectingTimeItem>(
          stream:
              DatabaseService(uid: userId, docid: docId).prospectingtimeData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ProspectingTimeItem data = snapshot.data;
              _name = data.name;
              _selectedDate = data.date;
              _duration = data.duration;
              return Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${AppLocalizations.of(context).translate('update')} ${AppLocalizations.of(context).translate('prospecting_time')}',
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
                    DateTimePicker(
                      dateMask: 'dd/MM/yyyy',
                      initialValue: _selectedDate.toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      decoration: textInputDecoration,
                      dateLabelText: 'Date',
                      onChanged: (val) => setState(
                          () => _selectedDateUpdated = DateTime.parse(val)),
                      validator: (val) => val.isEmpty
                          ? AppLocalizations.of(context).translate('validname')
                          : null,
                      //onSaved: (val) => print(val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText:
                            AppLocalizations.of(context).translate('duration'),
                      ),
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2)
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      // keyboardType: TextInputType.number,
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.digitsOnly
                      // ],
                      initialValue: _duration.toString(),
                      validator: (val) => val.isEmpty
                          ? AppLocalizations.of(context)
                              .translate('validduration')
                          : null,
                      onChanged: (val) =>
                          setState(() => _durationUpdated = double.parse(val)),
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
                                .updateProspectingTimeData(
                                    _nameUpdated ?? _name,
                                    _selectedDateUpdated ?? _selectedDate,
                                    _durationUpdated ?? _duration);
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
