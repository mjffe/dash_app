import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/brew.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/lead.dart';
import 'package:dashapp/models/mediationcontract.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/models/promisebuysell.dart';
import 'package:dashapp/models/proposal.dart';
import 'package:dashapp/models/prospectingtime.dart';
import 'package:dashapp/models/raising.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/models/scriptures.dart';
import 'package:dashapp/models/servicepresentation.dart';
import 'package:dashapp/models/user.dart';
import 'package:jiffy/jiffy.dart';

class DatabaseService {
  //DatabaseService({this.uid});
  DatabaseService({this.uid, this.docid});
  final String uid;
  final String docid;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String name, String role) async {
    return await userCollection.doc(uid).set({
      //'sugars': sugars,
      'name': name,
      'role': role,
      'filterDateRangeStart': new DateTime(DateTime.now().year, 1, 1),
      'filterDateRangeEnd': new DateTime(DateTime.now().year, 12, 31)
      //'strength': strength,
    });
  }

  Future<void> updateUserInfo(
      String role,
      String name,
      List<dynamic> consultants,
      List<dynamic> leadtypes,
      DateTime filterDateRangeStart,
      DateTime filterDateRangeEnd) async {
    return await userCollection.doc(uid).set({
      'role': role,
      'name': name,
      'consultants': consultants,
      'leadtypes': leadtypes,
      'filterDateRangeStart': filterDateRangeStart,
      'filterDateRangeEnd': filterDateRangeEnd
    });
  }

  //create leads
  Future<void> createLeadData(
      String name, String email, String phone, String leadtype) async {
    return await userCollection.doc(uid).collection('leads').add({
      'email': email,
      'name': name,
      'telefone': phone,
      'leadtype': leadtype,
      'createdon': new DateTime.now()
    });
  }

  //update leads
  Future<void> updateLeadData(
      String name, String email, String phone, String leadtype) async {
    try {
      return await userCollection.doc(uid).collection('leads').doc(docid).set({
        'email': email,
        'name': name,
        'telefone': phone,
        'leadtype': leadtype
      });
    } catch (error) {
      print('error updateLeadData: ${error.toString()}');
      return null;
    }
  }

// delete leads
  Future<void> deleteLeadData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('leads')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteLeadData: ${error.toString()}');
      return null;
    }
  }

  //create raisings
  Future<void> createRaisingData(RaisingItem item) async {
    return await userCollection.doc(uid).collection('raisings').add(
        {'name': item.name, 'createdon': new DateTime.now(), 'createdby': uid});
  }

//update raisings
  Future<void> updateRaisingData(RaisingItem item) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('raisings')
          .doc(docid)
          .set({
        'name': item.name ?? '',
        'createdon': item.createdon ?? DateTime.now(),
        'createdby': item.createdby ?? uid
      });
    } catch (error) {
      print('error updateRaisingData: ${error.toString()}');
      return null;
    }
  }

// delete raisings
  Future<void> deleteRaisingsData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('raisings')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteRaisingsData: ${error.toString()}');
      return null;
    }
  }

  //create sales
  Future<void> createSaleData(SaleItem item) async {
    return await userCollection.doc(uid).collection('sales').add({
      'name': item.name ?? '',
      'value': item.value ?? 0,
      'date': item.date ?? DateTime.now(),
      'type': item.type ?? '0',
      'state': item.state ?? '',
      'proposal': item.proposal ?? '',
      'proposalid': item.proposalid ?? '',
      'house': item.house ?? '',
      'houseid': item.houseid ?? '',
      'createdon': new DateTime.now(),
      'createdby': uid
    });
  }

  //create sales
  Future<String> createSaleFromProposalData(SaleItem item) async {
    DocumentReference doc =
        await userCollection.doc(uid).collection('sales').add({
      'name': item.name ?? '',
      'value': item.value ?? 0,
      'date': item.date ?? DateTime.now(),
      'type': item.type ?? '0',
      'state': item.state ?? '',
      'proposal': item.proposal ?? '',
      'proposalid': item.proposalid ?? '',
      'house': item.house ?? '',
      'houseid': item.houseid ?? '',
      'createdon': new DateTime.now(),
      'createdby': uid
    });
    return doc.id;
  }

//update raisings
  Future<void> updateSaleData(SaleItem item) async {
    try {
      return await userCollection.doc(uid).collection('sales').doc(docid).set({
        'name': item.name ?? '',
        'value': item.value ?? 0,
        'date': item.date ?? DateTime.now(),
        'type': item.type ?? '0',
        'state': item.state ?? '',
        'proposal': item.proposal ?? '',
        'proposalid': item.proposalid ?? '',
        'house': item.house ?? '',
        'houseid': item.houseid ?? '',
        'createdon': new DateTime.now(),
        'createdby': uid
      });
    } catch (error) {
      print('error updateSaleData: ${error.toString()}');
      return null;
    }
  }

// delete raisings
  Future<void> deleteSaleData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('sales')
          .doc(docid)
          .delete();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

//create scriptures
  Future<void> createScriptureData(String name, String date) async {
    return await userCollection
        .doc(uid)
        .collection('scriptures')
        .add({'name': name, 'date': date, 'createdon': new DateTime.now()});
  }

//update scriptures
  Future<void> updateScriptureData(String name, String date) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('scriptures')
          .doc(docid)
          .set({
        'name': name,
        'date': date,
      });
    } catch (error) {
      print('error updateScriptureData: ${error.toString()}');
      return null;
    }
  }

// delete scriptures
  Future<void> deleteScriptureData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('scriptures')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteScriptureData: ${error.toString()}');
      return null;
    }
  }

//create Service Presentation
  Future<void> createServicePresentationData(String name) async {
    return await userCollection
        .doc(uid)
        .collection('servicepresentation')
        .add({'name': name, 'createdon': new DateTime.now()});
  }

//update Service Presentation
  Future<void> updateServicePresentationData(String name) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('servicepresentation')
          .doc(docid)
          .set({
        'name': name,
      });
    } catch (error) {
      print('error updateServicePresentationData: ${error.toString()}');
      return null;
    }
  }

// delete Service Presentation
  Future<void> deleteServicePresentationData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('servicepresentation')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteServicePresentationData: ${error.toString()}');
      return null;
    }
  }

//create Mediation Contract
  Future<void> createMediationContractData(String name) async {
    return await userCollection
        .doc(uid)
        .collection('mediationcontract')
        .add({'name': name, 'createdon': new DateTime.now()});
  }

//update Mediation Contract
  Future<void> updateMediationContractData(String name) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('mediationcontract')
          .doc(docid)
          .set({
        'name': name,
      });
    } catch (error) {
      print('error updateMediationContractData: ${error.toString()}');
      return null;
    }
  }

// delete Mediation Contract
  Future<void> deleteMediationContractData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('mediationcontract')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteMediationContractData: ${error.toString()}');
      return null;
    }
  }

//create proposal
  Future<void> createProposalData(ProposalItem item) async {
    return await userCollection.doc(uid).collection('proposal').add({
      'name': item.name ?? '',
      'value': item.value ?? 0,
      'state': item.state ?? '0',
      'house': item.house ?? '',
      'houseid': item.houseid ?? '',
      'createdon': new DateTime.now(),
      'createdby': uid
    });
  }

//update proposal
  Future<void> updateProposalData(ProposalItem item) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('proposal')
          .doc(docid)
          .set({
        'name': item.name ?? '',
        'value': item.value ?? 0,
        'state': item.state ?? '0',
        'house': item.house ?? '',
        'houseid': item.houseid ?? '',
        'createdon': item.createdon ?? new DateTime.now(),
        'createdby': item.createdby ?? uid
      });
    } catch (error) {
      print('error updateProposalData: ${error.toString()}');
      return null;
    }
  }

  Future<void> updateProposalToLost(ProposalItem item) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('proposal')
          .doc(docid)
          .set({
        'name': item.name ?? '',
        'value': item.value ?? 0,
        'state': item.state ?? '1',
        'house': item.house ?? '',
        'houseid': item.houseid ?? '',
        'createdon': item.createdon ?? new DateTime.now(),
        'createdby': item.createdby ?? uid
      });
    } catch (error) {
      print('error updateProposalToLost: ${error.toString()}');
      return null;
    }
  }

  Future<void> updateProposalToWon(ProposalItem item) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('proposal')
          .doc(docid)
          .set({
        'name': item.name ?? '',
        'value': item.value ?? 0,
        'state': item.state ?? '2',
        'house': item.house ?? '',
        'houseid': item.houseid ?? '',
        'createdon': item.createdon ?? new DateTime.now(),
        'createdby': item.createdby ?? uid
      });
    } catch (error) {
      print('error updateProposalToWon: ${error.toString()}');
      return null;
    }
  }

// delete proposal
  Future<void> deleteProposalData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('proposal')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteProposalData: ${error.toString()}');
      return null;
    }
  }

//create promisebuysell
  Future<void> createpPromiseBuySellData(String name) async {
    return await userCollection
        .doc(uid)
        .collection('promisebuysell')
        .add({'name': name, 'createdon': new DateTime.now()});
  }

//update promisebuysell
  Future<void> updatePromiseBuySellData(String name) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('promisebuysell')
          .doc(docid)
          .set({
        'name': name,
      });
    } catch (error) {
      print('error updatePromiseBuySellData: ${error.toString()}');
      return null;
    }
  }

// delete promisebuysell
  Future<void> deletePromiseBuySellData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('promisebuysell')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deletePromiseBuySellData: ${error.toString()}');
      return null;
    }
  }

//create prospectingtime
  Future<void> createProspectingTimeData(
      String name, DateTime date, double duration) async {
    return await userCollection.doc(uid).collection('prospectingtime').add({
      'name': name,
      'date': date,
      'duration': duration,
      'createdon': new DateTime.now()
    });
  }

//update prospectingtime
  Future<void> updateProspectingTimeData(
      String name, DateTime date, double duration) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('prospectingtime')
          .doc(docid)
          .set({
        'name': name,
        'date': date,
        'duration': duration,
      });
    } catch (error) {
      print('error updateProspectingTimeData: ${error.toString()}');
      return null;
    }
  }

// delete prospectingtime
  Future<void> deleteProspectingTimeData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('prospectingtime')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteProspectingTimeData: ${error.toString()}');
      return null;
    }
  }

//create invoicing
  Future<void> createInvoicingData(InvoicingItem item) async {
    return await userCollection.doc(uid).collection('invoicing').add({
      'name': item.name,
      'value': item.value,
      'date': item.date,
      'sale': item.sale ?? '',
      'saleid': item.saleid ?? '',
      'house': item.house ?? '',
      'houseid': item.houseid ?? '',
      'createdon': new DateTime.now(),
      'createdby': uid
    });
  }

  Future<String> createInvoicingDataFromSale(InvoicingItem item) async {
    DocumentReference doc =
        await userCollection.doc(uid).collection('invoicing').add({
      'name': item.name,
      'value': item.value,
      'date': item.date,
      'sale': item.sale ?? '',
      'saleid': item.saleid ?? '',
      'house': item.house ?? '',
      'houseid': item.houseid ?? '',
      'createdon': new DateTime.now(),
      'createdby': uid
    });
    return doc.id;
  }

//update invoicing
  Future<void> updateInvoicingData(InvoicingItem item) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('invoicing')
          .doc(docid)
          .set({
        'name': item.name,
        'value': item.value,
        'date': item.date,
        'sale': item.sale ?? '',
        'saleid': item.saleid ?? '',
        'house': item.house ?? '',
        'houseid': item.houseid ?? '',
        'createdon': item.createdon ?? new DateTime.now(),
        'createdby': item.createdby ?? uid
      });
    } catch (error) {
      print('error updateInvoicingData: ${error.toString()}');
      return null;
    }
  }

// delete invoicing
  Future<void> deleteInvoicingData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('invoicing')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteInvoicingData: ${error.toString()}');
      return null;
    }
  }

//create invoicing
  Future<void> createObjectiveData(
    String name,
    double value,
    DateTime date,
  ) async {
    return await userCollection.doc(uid).collection('objective').add({
      'name': name,
      'value': value,
      'date': date,
      'createdon': new DateTime.now()
    });
  }

//update invoicing
  Future<void> updateObjectiveData(
    String name,
    double value,
    DateTime date,
  ) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('objective')
          .doc(docid)
          .set({'name': name, 'value': value, 'date': date});
    } catch (error) {
      print('error updateObjectiveData: ${error.toString()}');
      return null;
    }
  }

// delete invoicing
  Future<void> deleteObjectiveData() async {
    try {
      return await userCollection
          .doc(uid)
          .collection('objective')
          .doc(docid)
          .delete();
    } catch (error) {
      print('error deleteObjectiveData: ${error.toString()}');
      return null;
    }
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0',
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshots(DocumentSnapshot snapshot) {
    //print(doc.data);
    return UserData(
      name: snapshot.data()['name'] ?? '',
      // strength: snapshot.data()['strength'] ?? 0,
      // sugars: snapshot.data()['sugars'] ?? '0',
    );
  }

//lead data from snapchots
// brew list from snapshot
  List<LeadItem> _leadListFromSnapshot(QuerySnapshot snapshot) {
    List<LeadItem> _list;
    snapshot.docs.forEach((result) {
      userCollection
          .doc(result.id)
          .collection("leads")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          print(result.data());
          _list.add(LeadItem(
              email: result.data()['email'] ?? '',
              name: result.data()['name'] ?? '',
              phone: result.data()['telefone'] ?? 0));
        });
      });
    });
    return _list;
  }

// get brews stream
  Stream<List<Brew>> get brews {
    return userCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshots);
  }

  Stream<UserData> userInfo(String userid) {
    //return userCollection.doc(uid).snapshots().map(_userDataFromSnapshots);
    return userCollection
        .doc(userid)
        .snapshots()
        .map((doc) => UserData.fromFirestore(doc));
  }

  //get Leads doc stream
  Stream<List<LeadItem>> get leads {
    return userCollection.snapshots().map(_leadListFromSnapshot);
  }

  // Future<Stream<List<LeadItem>>> get getleads async {
  //   QuerySnapshot snapshots = await brewCollection.get();
  //   List<LeadItem> _list = [];

  //   snapshots.docs.forEach((result) {
  //     //LeadItem l = LeadItem.map(result.data());
  //     print(result.data());
  //     _list.add(LeadItem(
  //         email: result.data()['Email'] ?? '',
  //         name: result.data()['Nome'] ?? '',
  //         phone: result.data()['Telefone'] ?? 0));
  //   });

  //   return _list;
  // }

  //Obten a lista de leads de um utilizador
  Stream<List<LeadItem>> getleads() {
    var ref = userCollection
        .doc(uid)
        .collection('leads')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => LeadItem.fromFirestore(doc)).toList());
  }

  Stream<QuerySnapshot> getleadscount2(String userid) {
    var ref = userCollection.doc(uid).collection('leads');

    return ref.snapshots();
  }

  Stream<List<LeadItem>> getleadsBuyerCustomers(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('leads')
        .where('leadtype', isEqualTo: '1')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => LeadItem.fromFirestore(doc)).toList());
  }

  Stream<List<LeadItem>> getleadsProspecting(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('leads')
        .where('leadtype', isEqualTo: '0')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => LeadItem.fromFirestore(doc)).toList());
  }

  //Obten um lead especifica
  Stream<LeadItem> get getleadscount {
    return userCollection
        .doc(uid)
        .collection('leads')
        .doc(docid)
        .snapshots()
        .map((doc) => LeadItem.fromFirestore(doc));
  }

  //Obten um lead especifica
  Stream<LeadItem> get leadData {
    return userCollection
        .doc(uid)
        .collection('leads')
        .doc(docid)
        .snapshots()
        .map((doc) => LeadItem.fromFirestore(doc));
  }

//Obten a lista de raisings de um utilizador
  Stream<List<RaisingItem>> getraisings(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('raisings')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => RaisingItem.fromFirestore(doc)).toList());
  }

  //Obten um raisings especifica
  Stream<RaisingItem> get raisingData {
    return userCollection
        .doc(uid)
        .collection('raisings')
        .doc(docid)
        .snapshots()
        .map((doc) => RaisingItem.fromFirestore(doc));
  }

  Stream<List<RaisingItem>> get getAvailableHousesData {
    var ref = userCollection
        .doc(uid)
        .collection('raisings')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => RaisingItem.fromFirestore(doc)).toList());
  }

  //Obten a lista de sales de um utilizador
  Stream<List<SaleItem>> getsales(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('sales')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => SaleItem.fromFirestore(doc)).toList());
  }

  Stream<List<SaleItem>> getsalesScriptures(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('sales')
        .where('state', isEqualTo: '1');

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => SaleItem.fromFirestore(doc)).toList());
  }

  Stream<List<SaleItem>> getsalesPromiseBuySell(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('sales')
        .where('state', isEqualTo: '0')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => SaleItem.fromFirestore(doc)).toList());
  }

  //Obten um sales especifica
  Stream<SaleItem> get saleData {
    return userCollection
        .doc(uid)
        .collection('sales')
        .doc(docid)
        .snapshots()
        .map((doc) => SaleItem.fromFirestore(doc));
  }

//Obten a lista de scriptures de um utilizador
  Stream<List<ScripturesItem>> getscriptures(FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('scriptures');

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => ScripturesItem.fromFirestore(doc)).toList());
  }

  //Obten um scriptures especifica
  Stream<ScripturesItem> get scriptureData {
    return userCollection
        .doc(uid)
        .collection('scriptures')
        .doc(docid)
        .snapshots()
        .map((doc) => ScripturesItem.fromFirestore(doc));
  }

//Obten a lista de servicepresentation de um utilizador
  Stream<List<ServicePresentationItem>> getservicepresentations(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('servicepresentation')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map((list) => list.docs
        .map((doc) => ServicePresentationItem.fromFirestore(doc))
        .toList());
  }

  //Obten um servicepresentation especifica
  Stream<ServicePresentationItem> get servicepresentationData {
    return userCollection
        .doc(uid)
        .collection('servicepresentation')
        .doc(docid)
        .snapshots()
        .map((doc) => ServicePresentationItem.fromFirestore(doc));
  }

//Obten a lista de mediationcontract de um utilizador
  Stream<List<MediationContractItem>> getmediationcontracts(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('mediationcontract')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map((list) => list.docs
        .map((doc) => MediationContractItem.fromFirestore(doc))
        .toList());
  }

  //Obten um mediationcontract especifica
  Stream<MediationContractItem> get mediationcontractData {
    return userCollection
        .doc(uid)
        .collection('mediationcontract')
        .doc(docid)
        .snapshots()
        .map((doc) => MediationContractItem.fromFirestore(doc));
  }

//Obten a lista de proposal de um utilizador
  Stream<List<ProposalItem>> getproposals(String userId) {
    var ref = userCollection
        .doc(userId)
        .collection('proposal')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => ProposalItem.fromFirestore(doc)).toList());
  }

  //Obten um proposal especifica
  Stream<ProposalItem> get proposalData {
    return userCollection
        .doc(uid)
        .collection('proposal')
        .doc(docid)
        .snapshots()
        .map((doc) => ProposalItem.fromFirestore(doc));
  }

//Obten a lista de promisebuysell de um utilizador
  Stream<List<PromiseBuySellItem>> getpromisesbuysell(FirebaseUser user) {
    var ref = userCollection
        .doc(user.uid)
        .collection('promisebuysell')
        .orderBy("createdon", descending: true);

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => PromiseBuySellItem.fromFirestore(doc)).toList());
  }

  //Obten um promisebuysell especifica
  Stream<PromiseBuySellItem> get promisebuysellData {
    return userCollection
        .doc(uid)
        .collection('promisebuysell')
        .doc(docid)
        .snapshots()
        .map((doc) => PromiseBuySellItem.fromFirestore(doc));
  }

//Obten a lista de prospectingtime de um utilizador
  Stream<List<ProspectingTimeItem>> getprospectingtime(
      String userId, int month) {
    //var date = DateTime.now();
    if (month == 0) {
      Query ref = userCollection
          .doc(userId)
          .collection('prospectingtime')
          .orderBy("createdon", descending: true);
      return ref.snapshots().map((list) => list.docs
          .map((doc) => ProspectingTimeItem.fromFirestore(doc))
          .toList());
    } else {
      DateTime startDate = new DateTime(DateTime.now().year, month, 1);
      Jiffy end = Jiffy(DateTime(DateTime.now().year, month, 1)).add(months: 1);
      DateTime endDate = new DateTime(DateTime.now().year, end.month, 1);
      Query ref = userCollection
          .doc(userId)
          .collection('prospectingtime')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThan: endDate)
          .orderBy("createdon", descending: true);
      return ref.snapshots().map((list) => list.docs
          .map((doc) => ProspectingTimeItem.fromFirestore(doc))
          .toList());
    }
  }

  //Obten um prospectingtime especifica
  Stream<ProspectingTimeItem> get prospectingtimeData {
    return userCollection
        .doc(uid)
        .collection('prospectingtime')
        .doc(docid)
        .snapshots()
        .map((doc) => ProspectingTimeItem.fromFirestore(doc));
  }

//Obten a lista de invoicing de um utilizador
  Stream<List<InvoicingItem>> getinvoices(String userId, int month) {
    if (month == 0) {
      var ref = userCollection
          .doc(userId)
          .collection('invoicing')
          .orderBy("createdon", descending: true);

      return ref.snapshots().map((list) =>
          list.docs.map((doc) => InvoicingItem.fromFirestore(doc)).toList());
    } else {
      DateTime startDate = new DateTime(DateTime.now().year, month, 1);
      Jiffy end = Jiffy(DateTime(DateTime.now().year, month, 1)).add(months: 1);
      DateTime endDate = new DateTime(DateTime.now().year, end.month, 1);
      Query ref = userCollection
          .doc(userId)
          .collection('invoicing')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThan: endDate)
          .orderBy("createdon", descending: true);
      return ref.snapshots().map((list) =>
          list.docs.map((doc) => InvoicingItem.fromFirestore(doc)).toList());
    }
  }

  //Obten um invoicing especifica
  Stream<InvoicingItem> get invoicingData {
    return userCollection
        .doc(uid)
        .collection('invoicing')
        .doc(docid)
        .snapshots()
        .map((doc) => InvoicingItem.fromFirestore(doc));
  }

//Obten a lista de invoicing de um utilizador
  Stream<List<ObjectiveItem>> getobjectives(String userId, int month) {
    if (month == 0) {
      var ref = userCollection
          .doc(userId)
          .collection('objective')
          .orderBy("createdon", descending: true);

      return ref.snapshots().map((list) =>
          list.docs.map((doc) => ObjectiveItem.fromFirestore(doc)).toList());
    } else {
      DateTime startDate = new DateTime(DateTime.now().year, month, 1);
      Jiffy end = Jiffy(DateTime(DateTime.now().year, month, 1)).add(months: 1);
      DateTime endDate = new DateTime(DateTime.now().year, end.month, 1);
      Query ref = userCollection
          .doc(userId)
          .collection('objective')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThan: endDate);
      // .orderBy("createdon", descending: true);
      return ref.snapshots().map((list) =>
          list.docs.map((doc) => ObjectiveItem.fromFirestore(doc)).toList());
    }
  }

  //Obten um invoicing especifica
  Stream<ObjectiveItem> get objectiveData {
    return userCollection
        .doc(uid)
        .collection('objective')
        .doc(docid)
        .snapshots()
        .map((doc) => ObjectiveItem.fromFirestore(doc));
  }
}
