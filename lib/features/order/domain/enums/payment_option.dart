enum PaymentOption {
  transfer,
  cash;

  String get title {
    return switch (this) {
      PaymentOption.transfer => "Transfer",
      PaymentOption.cash => "Cash",
    };
  }
}

PaymentOption orderStatusfromString(String value) {
  switch (value) {
    case 'transfer':
      return PaymentOption.transfer;
    case 'process':
      return PaymentOption.cash;
    default:
      throw ArgumentError("$value not values for PaymentOption enums");
  }
}
