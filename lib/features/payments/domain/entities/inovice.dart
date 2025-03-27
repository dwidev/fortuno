// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fortuno/core/utils/formatter.dart';

import 'package:fortuno/features/order/domain/entities/client_order.dart';
import 'package:fortuno/features/payments/domain/entities/payment.dart';

import '../enums/invoice_status_enum.dart';

class Invoice extends Equatable {
  final String id;
  final String orderID;
  final String number;
  final DateTime issueDate;
  final DateTime dueDate;
  final double totalAmount;
  final InvoiceStatus status;
  final ClientOrder clientOrder;
  final List<Payment> payments;

  double get remainingPayment {
    var total = totalAmount;

    for (var e in payments) {
      total -= e.amount;
    }

    return total;
  }

  String get remainingPaymentDisplay => moneyFormatter(remainingPayment);

  const Invoice({
    required this.id,
    required this.orderID,
    required this.number,
    required this.issueDate,
    required this.dueDate,
    required this.totalAmount,
    required this.status,
    required this.clientOrder,
    required this.payments,
  });

  factory Invoice.init() => Invoice(
    id: '',
    orderID: 'orderID',
    number: '',
    issueDate: DateTime.now(),
    dueDate: DateTime.now(),
    totalAmount: 0,
    status: InvoiceStatus.unpaid,
    clientOrder: ClientOrder.init(),
    payments: [],
  );

  @override
  List<Object> get props {
    return [
      id,
      orderID,
      number,
      issueDate,
      dueDate,
      totalAmount,
      status,
      clientOrder,
      payments,
    ];
  }

  Invoice copyWith({
    String? id,
    String? orderID,
    String? number,
    DateTime? issueDate,
    DateTime? dueDate,
    double? totalAmount,
    InvoiceStatus? status,
    ClientOrder? clientOrder,
    List<Payment>? payments,
  }) {
    return Invoice(
      id: id ?? this.id,
      orderID: orderID ?? this.orderID,
      number: number ?? this.number,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      clientOrder: clientOrder ?? this.clientOrder,
      payments: payments ?? this.payments,
    );
  }

  @override
  bool get stringify => true;
}
