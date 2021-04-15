import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int _value = 0;
  String _nameUpdated;
  int _valueUpdated;

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
                        .createObjectiveData(_name ?? '', _value ?? 0);
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
                          ? AppLocalizations.of(context).translate('validvalue')
                          : null,
                      onChanged: (val) =>
                          setState(() => _valueUpdated = int.parse(val)),
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
                                .updateObjectiveData(_nameUpdated ?? _name,
                                    _valueUpdated ?? _value);
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