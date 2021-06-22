import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/objectives.dart';

class InvoiceChartItem {
  InvoiceChartItem({this.invoices, this.objectives, this.sales});

  final List<ChartItem> invoices;
  final List<ObjectiveItem> objectives;
  final List<ChartItem> sales;
}

class ChartItem {
  ChartItem(
      {this.id,
      this.collection,
      this.date,
      this.value,
      this.datemonth,
      this.createdon});

  final String id;
  final String collection;
  final DateTime date;
  final double value;
  final int datemonth;
  final DateTime createdon;

  factory ChartItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];
    String collection = doc.reference.parent.path.split('/')[2];
    if (collection == 'sales') {
      // caso a venda ja tenha avançado ou esteja sido descartada este valor nao sera contabilizado
      String state = data['state'] ?? '0';
      if (state != '0') return new ChartItem();
    }

    return ChartItem(
        id: doc.id,
        collection: doc.reference.parent.path.split('/')[2],
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        //value: data['value'] ?? 0.0,
        value: data['value'] != null ? data['value'].toDouble() : 0.0,
        date: data['date'] != null && data['date'] != ''
            ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
            : new DateTime.now(),
        datemonth: data['date'] != null && data['date'] != ''
            ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
                .month
            : new DateTime.now().month);
  }
}
