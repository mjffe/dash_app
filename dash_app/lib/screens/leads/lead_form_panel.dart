import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/lead.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeadFormPanel extends StatefulWidget {
  LeadFormPanel(this.userId, this.docId);
  final String userId;
  final String docId;
  @override
  _LeadFormPanelState createState() => _LeadFormPanelState(userId, docId);
}

class _LeadFormPanelState extends State<LeadFormPanel> {
  _LeadFormPanelState(this.userId, this.docId);
  final String userId;
  final String docId;

  final _formkey = GlobalKey<FormState>();
  final List<String> leadtypes = [
    '0',
    '1',
  ];

  // form values
  String _name = '';
  String _email = '';
  String _phone = '';
  String _leadtype = '';
  String _nameUpdated;
  String _emailUpdated;
  String _phoneUpdated;
  String _leadtypeUpdated;

  String _getLeadTypeName(String index) {
    //print(index);
    switch (index) {
      case 'prospecting':
        {
          return AppLocalizations.of(context).translate('prospecting');
        }
        break;
      case 'buyercustomers':
        {
          return AppLocalizations.of(context).translate('buyercustomers');
        }
        break;
      case 'site':
        {
          return AppLocalizations.of(context).translate('site');
        }
        break;
      case 'socialnetwork':
        {
          return AppLocalizations.of(context).translate('socialnetwork');
        }
        break;
      case 'reference':
        {
          return AppLocalizations.of(context).translate('reference');
        }
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (docId.isEmpty)
      return Scaffold(
        appBar:
            customAppBar(AppLocalizations.of(context).translate('leads')).bar(),
        body: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              // Text(
              //   AppLocalizations.of(context).translate('new_lead'),
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                initialValue: _phone,
                validator: (val) => val.isEmpty
                    ? AppLocalizations.of(context).translate('validphone')
                    : null,
                onChanged: (val) => setState(() => _phone = val),
              ),
              SizedBox(height: 20.0),
              // DropdownButtonFormField(
              //   //value: _leadtype,
              //   //decoration: textInputDecoration,
              //   decoration: textInputDecoration.copyWith(
              //     hintText: AppLocalizations.of(context).translate('lead_type'),
              //   ),
              //   items: leadtypes.map((type) {
              //     return DropdownMenuItem(
              //       value: type,
              //       child: Text(_getLeadTypeName(type)),
              //     );
              //   }).toList(),
              //   validator: (val) => val == null
              //       ? AppLocalizations.of(context).translate('validleadtype')
              //       : null,
              //   onChanged: (val) => setState(() => _leadtype = val),
              // ),
              StreamBuilder<UserData>(
                  //https://github.com/whatsupcoders/FlutterDropDown/blob/master/lib/main.dart
                  stream: DatabaseService(uid: userId).userInfo(userId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Text("Loading.....");
                    else {
                      UserData d = snapshot.data;
                      List<DropdownMenuItem> types = [];
                      types.add(
                        DropdownMenuItem(
                          child: Text(''),
                          value: '',
                        ),
                      );
                      for (var i = 0; i < d.leadtypes.length; i++) {
                        //RaisingItem raising = d[i];
                        types.add(
                          DropdownMenuItem(
                            child: Text(
                              _getLeadTypeName(d.leadtypes[i]),
                            ),
                            value: "${d.leadtypes[i]}",
                          ),
                        );
                      }

                      return DropdownButtonFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: AppLocalizations.of(context)
                              .translate('Selected an house'),
                        ),
                        items: types,
                        //value: leadData.houseid,
                        onChanged: (val) => setState(() => _leadtype = val),
                      );
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
                      await DatabaseService(uid: userId).createLeadData(
                          _name ?? '',
                          _email ?? '',
                          _phone ?? '',
                          _leadtype ?? '');
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
            customAppBar(AppLocalizations.of(context).translate('leads')).bar(),
        body: StreamBuilder<LeadItem>(
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
                _leadtype = leadData.leadtype;
                return Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        // Text(
                        //   AppLocalizations.of(context).translate('update_lead'),
                        //   style: TextStyle(fontSize: 18.0),
                        // ),
                        SizedBox(height: 20.0),
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
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText:
                                AppLocalizations.of(context).translate('email'),
                          ),
                          initialValue: _email,
                          validator: (val) => val.isEmpty
                              ? AppLocalizations.of(context)
                                  .translate('validemail')
                              : null,
                          onChanged: (val) =>
                              setState(() => _emailUpdated = val),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: AppLocalizations.of(context)
                                .translate('phone_number'),
                          ),
                          initialValue: _phone,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          validator: (val) => val.isEmpty
                              ? AppLocalizations.of(context)
                                  .translate('validphone')
                              : null,
                          onChanged: (val) =>
                              setState(() => _phoneUpdated = val),
                        ),
                        SizedBox(height: 20.0),
                        // DropdownButtonFormField(
                        //   value: _leadtype,
                        //   decoration: textInputDecoration,
                        //   items: leadtypes.map((type) {
                        //     return DropdownMenuItem(
                        //       value: type,
                        //       child: //Text('sdfsdf'),
                        //           Text(_getLeadTypeName(type)),
                        //     );
                        //   }).toList(),
                        //   onChanged: (val) =>
                        //       setState(() => _leadtypeUpdated = val),
                        // ),
                        StreamBuilder<UserData>(
                            //https://github.com/whatsupcoders/FlutterDropDown/blob/master/lib/main.dart
                            stream:
                                DatabaseService(uid: userId).userInfo(userId),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Text("Loading.....");
                              else {
                                UserData d = snapshot.data;
                                List<DropdownMenuItem> types = [];
                                types.add(
                                  DropdownMenuItem(
                                    child: Text(''),
                                    value: '',
                                  ),
                                );
                                for (var i = 0; i < d.leadtypes.length; i++) {
                                  //RaisingItem raising = d[i];
                                  types.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        _getLeadTypeName(d.leadtypes[i]),
                                      ),
                                      value: "${d.leadtypes[i]}",
                                    ),
                                  );
                                }

                                return DropdownButtonFormField(
                                  decoration: textInputDecoration.copyWith(
                                    hintText: AppLocalizations.of(context)
                                        .translate('Selected an house'),
                                  ),
                                  items: types,
                                  value: leadData.leadtype,
                                  onChanged: (val) =>
                                      setState(() => _leadtype = val),
                                );
                              }
                            }),
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
                                        _phoneUpdated ?? _phone,
                                        _leadtypeUpdated ?? _leadtype);
                                Navigator.pop(context);
                              }
                            }),
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
    // return Scaffold(
    //   appBar:
    //       customAppBar(AppLocalizations.of(context).translate('leads')).bar(),
    //   body: Center(
    //     child: ElevatedButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //       child: Text('Go back!'),
    //     ),
    //   ),
    // );
  }
}
