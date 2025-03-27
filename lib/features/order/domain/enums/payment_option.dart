enum PaymentOption {
  transfer,
  cash;

  bool get isCash => this == PaymentOption.cash;
  bool get isTransfer => this == PaymentOption.transfer;

  String get title {
    return switch (this) {
      PaymentOption.transfer => "Transfer",
      PaymentOption.cash => "Cash",
    };
  }
}

PaymentOption paymentOptionfromString(String value) {
  switch (value) {
    case 'transfer':
      return PaymentOption.transfer;
    case 'cash':
      return PaymentOption.cash;
    default:
      throw ArgumentError("$value not values for PaymentOption enums");
  }
}
