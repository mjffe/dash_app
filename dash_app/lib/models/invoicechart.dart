import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/objectives.dart';

class InvoiceChartItem {
  InvoiceChartItem({this.invoices, this.objectives});

  final List<InvoicingItem> invoices;
  final List<ObjectiveItem> objectives;
}
