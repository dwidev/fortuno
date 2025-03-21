import 'package:equatable/equatable.dart';

import '../enums/invoice_status_enum.dart';

class Invoice extends Equatable {
  final String id;
  final String orderID;
  final String number;
  final DateTime issueDate;
  final DateTime dueDate;
  final double totalAmount;
  final InvoiceStatus status;

  const Invoice({
    required this.id,
    required this.orderID,
    required this.number,
    required this.issueDate,
    required this.dueDate,
    required this.totalAmount,
    required this.status,
  });

  factory Invoice.init() => Invoice(
    id: '',
    orderID: 'orderID',
    number: '',
    issueDate: DateTime.now(),
    dueDate: DateTime.now(),
    totalAmount: 0,
    status: InvoiceStatus.unpaid,
  );

  @override
  List<Object> get props {
    return [id, orderID, number, issueDate, dueDate, totalAmount, status];
  }

  Invoice copyWith({
    String? id,
    String? orderID,
    String? number,
    DateTime? issueDate,
    DateTime? dueDate,
    double? totalAmount,
    InvoiceStatus? status,
  }) {
    return Invoice(
      id: id ?? this.id,
      orderID: orderID ?? this.orderID,
      number: number ?? this.number,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
    );
  }

  @override
  bool get stringify => true;
}
