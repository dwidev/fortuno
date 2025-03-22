// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/models/base_model.dart';
import 'package:fortuno/features/order/data/model/client_order_model.dart';
import 'package:fortuno/features/payments/data/model/payment_model.dart';

import '../../domain/entities/inovice.dart';
import '../../domain/enums/invoice_status_enum.dart';

class InvoiceModel extends BaseModel<Invoice> {
  final String id;
  final String orderID;
  final String number;
  final String issueDate;
  final String dueDate;
  final double totalAmount;
  final String status;
  final ClientOrderModel clientOrderModel;
  final List<PaymentModel> paymentsModel;

  InvoiceModel({
    required this.id,
    required this.orderID,
    required this.number,
    required this.issueDate,
    required this.dueDate,
    required this.totalAmount,
    required this.status,
    required this.clientOrderModel,
    required this.paymentsModel,
  });

  @override
  Invoice toEntity() {
    return Invoice(
      id: id,
      orderID: orderID,
      number: number,
      issueDate: parseDateRawToDateTime(issueDate),
      dueDate: parseDateRawToDateTime(dueDate),
      totalAmount: totalAmount,
      status: invoiceStatusFromString(status),
      clientOrder: clientOrderModel.toEntity(),
      payments: paymentsModel.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderID,
      'number': number,
      'issueDate': issueDate,
      'dueDate': dueDate,
      'totalAmount': totalAmount,
      'status': status,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['ID'] as String,
      orderID: map['order_id'] as String,
      number: map['invoice_number'] as String,
      issueDate: map['issue_date'] as String,
      dueDate: map['due_date'] as String,
      totalAmount: BaseModel.parseToDouble(map['total_amount']),
      status: map['status'] as String,
      clientOrderModel: ClientOrderModel.fromMap(
        map['client'] as Map<String, dynamic>,
      ),
      paymentsModel: List<PaymentModel>.from(
        (map['payments'] as List<dynamic>).map<PaymentModel>(
          (x) => PaymentModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
