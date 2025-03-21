import 'package:equatable/equatable.dart';

import '../../../order/domain/enums/payment_option.dart';

class Payment extends Equatable {
  final String id;
  final String invoiceId;
  final double amount;
  final PaymentOption paymentMethod;
  final DateTime paymentDate;

  const Payment({
    this.id = '',
    required this.invoiceId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
  });

  @override
  List<Object> get props {
    return [id, invoiceId, amount, paymentMethod, paymentDate];
  }

  Payment copyWith({
    String? id,
    String? invoiceId,
    double? amount,
    PaymentOption? paymentMethod,
    DateTime? paymentDate,
  }) {
    return Payment(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentDate: paymentDate ?? this.paymentDate,
    );
  }

  @override
  bool get stringify => true;
}
