import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/lead.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/material.dart';

class LeadForm extends StatefulWidget {
  //LeadForm({Key key}) : super(key: key);
  LeadForm(this.userId, this.docId);
  final String userId;
  final String docId;

  @override
  _LeadFormState createState() => _LeadFormState(userId, docId);
}

class _LeadFormState extends State<LeadForm> {
  _LeadFormState(this.userId, this.docId);
  final String userId;
  final String docId;
  final _formkey = GlobalKey<FormState>();

  // form values
  String _name = '';
  String _email = '';
  String _phone = '';
  String _nameUpdated;
  String _emailUpdated;
  String _phoneUpdated;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);

    if (docId.isEmpty)
      return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('new_lead'),
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
                hintText: AppLocalizations.of(context).translate('email'),
              ),
              initialValue: _email,
              validator: (val) => val.isEmpty
                  ? AppLocalizations.of(context).translate('validemail')
                  : null,
              onChanged: (val) => setState(() => _email = val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                hintText:
                    AppLocalizations.of(context).translate('phone_number'),
              ),
              initialValue: _phone,
              validator: (val) => val.isEmpty
                  ? AppLocalizations.of(context).translate('phone_number')
                  : null,
              onChanged: (val) => setState(() => _phone = val),
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
                    await DatabaseService(uid: userId).createLeadData(
                        _name ?? '', _email ?? '', _phone ?? '');
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      );
    else {
      return StreamBuilder<LeadItem>(
          stream: DatabaseService(uid: userId, docid: docId).leadData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              LeadItem leadData = snapshot.data;
              // setState(() {
              //   _name = leadData.name;
              //   _email = leadData.email;
              //   _phone = leadData.phone;
              // });
              _name = leadData.name;
              _email = leadData.email;
              _phone = leadData.phone;
              return Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('update_lead'),
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
                            AppLocalizations.of(context).translate('email'),
                      ),
                      initialValue: _email,
                      validator: (val) => val.isEmpty
                          ? AppLocalizations.of(context).translate('validemail')
                          : null,
                      onChanged: (val) => setState(() => _emailUpdated = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: AppLocalizations.of(context)
                            .translate('phone_number'),
                      ),
                      initialValue: _phone,
                      validator: (val) => val.isEmpty
                          ? AppLocalizations.of(context).translate('validphone')
                          : null,
                      onChanged: (val) => setState(() => _phoneUpdated = val),
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
                                .updateLeadData(
                                    _nameUpdated ?? _name,
                                    _emailUpdated ?? _email,
                                    _phoneUpdated ?? _phone);
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
