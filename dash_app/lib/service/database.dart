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

class DatabaseService {
  //DatabaseService({this.uid});
  DatabaseService({this.uid, this.docid});
  final String uid;
  final String docid;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await userCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //create leads
  Future<void> createLeadData(String name, String email, String phone) async {
    return await userCollection.doc(uid).collection('leads').add({
      'email': email,
      'name': name,
      'telefone': phone,
      'createdon': new DateTime.now()
    });
  }

  //update leads
  Future<void> updateLeadData(String name, String email, String phone) async {
    try {
      return await userCollection.doc(uid).collection('leads').doc(docid).set({
        'email': email,
        'name': name,
        'telefone': phone,
      });
    } catch (error) {
      print(error.toString());
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
      print(error.toString());
      return null;
    }
  }

  //create raisings
  Future<void> createRaisingData(String name) async {
    return await userCollection
        .doc(uid)
        .collection('raisings')
        .add({'name': name, 'createdon': new DateTime.now()});
  }

//update raisings
  Future<void> updateRaisingData(String name) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('raisings')
          .doc(docid)
          .set({
        'name': name,
      });
    } catch (error) {
      print(error.toString());
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
      print(error.toString());
      return null;
    }
  }

  //create sales
  Future<void> createSaleData(String name, int value) async {
    return await userCollection
        .doc(uid)
        .collection('sales')
        .add({'name': name, 'value': value, 'createdon': new DateTime.now()});
  }

//update raisings
  Future<void> updateSaleData(String name, int value) async {
    try {
      return await userCollection.doc(uid).collection('sales').doc(docid).set({
        'name': name,
        'value': value,
      });
    } catch (error) {
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
      return null;
    }
  }

//create proposal
  Future<void> createProposalData(String name, int value) async {
    return await userCollection
        .doc(uid)
        .collection('proposal')
        .add({'name': name, 'value': value, 'createdon': new DateTime.now()});
  }

//update proposal
  Future<void> updateProposalData(String name, int value) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('proposal')
          .doc(docid)
          .set({'name': name, 'value': value});
    } catch (error) {
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
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
      print(error.toString());
      return null;
    }
  }

//create invoicing
  Future<void> createInvoicingData(String name, int value) async {
    return await userCollection
        .doc(uid)
        .collection('invoicing')
        .add({'name': name, 'value': value, 'createdon': new DateTime.now()});
  }

//update invoicing
  Future<void> updateInvoicingData(String name, int value) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('invoicing')
          .doc(docid)
          .set({'name': name, 'value': value});
    } catch (error) {
      print(error.toString());
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
      print(error.toString());
      return null;
    }
  }

//create invoicing
  Future<void> createObjectiveData(String name, int value) async {
    return await userCollection
        .doc(uid)
        .collection('objective')
        .add({'name': name, 'value': value, 'createdon': new DateTime.now()});
  }

//update invoicing
  Future<void> updateObjectiveData(String name, int value) async {
    try {
      return await userCollection
          .doc(uid)
          .collection('objective')
          .doc(docid)
          .set({'name': name, 'value': value});
    } catch (error) {
      print(error.toString());
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
      print(error.toString());
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
  UserData _userDataFromSnapshots(DocumentSnapshot snapshots) {
    return UserData(
      uid: uid,
      name: snapshots.data()['name'] ?? '',
      strength: snapshots.data()['strength'] ?? 0,
      sugars: snapshots.data()['sugars'] ?? '0',
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
    var ref = userCollection.doc(uid).collection('leads');

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => LeadItem.fromFirestore(doc)).toList());
  }

  Stream<QuerySnapshot> getleadscount2(String userid) {
    var ref = userCollection.doc(uid).collection('leads');

    return ref.snapshots();
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
  Stream<List<RaisingItem>> getraisings(FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('raisings');

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

  //Obten a lista de sales de um utilizador
  Stream<List<SaleItem>> getsales(FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('sales');

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
  Stream<List<ServicePresentationItem>> getservicepresentations(
      FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('servicepresentation');

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
  Stream<List<MediationContractItem>> getmediationcontracts(FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('mediationcontract');

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
  Stream<List<ProposalItem>> getproposals(FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('proposal');

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
    var ref = userCollection.doc(user.uid).collection('promisebuysell');

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
  Stream<List<ProspectingTimeItem>> getprospectingtime(FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('prospectingtime');

    return ref.snapshots().map((list) => list.docs
        .map((doc) => ProspectingTimeItem.fromFirestore(doc))
        .toList());
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
  Stream<List<InvoicingItem>> getinvoices(FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('invoicing');

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => InvoicingItem.fromFirestore(doc)).toList());
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
  Stream<List<ObjectiveItem>> getobjectives(FirebaseUser user) {
    var ref = userCollection.doc(user.uid).collection('objective');

    return ref.snapshots().map((list) =>
        list.docs.map((doc) => ObjectiveItem.fromFirestore(doc)).toList());
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