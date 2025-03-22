import 'dart:convert';

import '../../../../core/core.dart';
import '../../../../core/models/base_model.dart';

import '../../../order/domain/enums/payment_option.dart';
import '../../domain/entities/payment.dart';

class PaymentModel extends BaseModel<Payment> {
  final String id;
  final String invoiceId;
  final double amount;
  final String paymentMethod;
  final String paymentDate;

  PaymentModel({
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
  });

  @override
  Payment toEntity() {
    return Payment(
      id: id,
      invoiceId: invoiceId,
      amount: amount,
      paymentMethod: paymentOptionfromString(paymentMethod),
      paymentDate: parseDateRawToDateTime(paymentDate),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'invoice_id': invoiceId,
      'amount': amount,
      'payment_method': paymentMethod,
      'payment_date': paymentDate,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['ID'] as String,
      invoiceId: map['invoice_id'] as String,
      amount: map['amount'] as double,
      paymentMethod: map['payment_method'] as String,
      paymentDate: map['payment_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
