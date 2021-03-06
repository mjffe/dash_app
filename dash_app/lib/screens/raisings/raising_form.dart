import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/raising.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class RaisingForm extends StatefulWidget {
  RaisingForm(this.userId, this.docId);
  final String userId;
  final String docId;

  @override
  _RaisingFormState createState() => _RaisingFormState(userId, docId);
}

class _RaisingFormState extends State<RaisingForm> {
  _RaisingFormState(this.userId, this.docId);
  final String userId;
  final String docId;
  final _formkey = GlobalKey<FormState>();

  // form values
  String _name = '';
  String _nameUpdated;
  DateTime _selectedDate = DateTime.now().add(Duration(days: 365));
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
              '${AppLocalizations.of(context).translate('new')} ${AppLocalizations.of(context).translate('raising')}',
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
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${AppLocalizations.of(context).translate('expirationdate')}:",
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
              onChanged: (val) =>
                  setState(() => _selectedDateUpdated = DateTime.parse(val)),
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
                    await DatabaseService(uid: userId)
                        .createRaisingData(new RaisingItem(
                      name: _name ?? '',
                      expirationdate: _selectedDateUpdated ?? DateTime.now(),
                    ));
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      );
    else {
      return StreamBuilder<RaisingItem>(
          stream: DatabaseService(uid: userId, docid: docId).raisingData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              RaisingItem data = snapshot.data;
              // setState(() {
              //   _name = leadData.name;
              //   _email = leadData.email;
              //   _phone = leadData.phone;
              // });
              _name = data.name;
              return Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${AppLocalizations.of(context).translate('update')} ${AppLocalizations.of(context).translate('raising')}',
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
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${AppLocalizations.of(context).translate('expirationdate')}:",
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
                          ? AppLocalizations.of(context).translate('validdate')
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
                                .updateRaisingData(new RaisingItem(
                                    name: _nameUpdated ?? _name,
                                    expirationdate:
                                        _selectedDateUpdated ?? DateTime.now(),
                                    createdon: data.createdon,
                                    createdby: data.createdby));
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
