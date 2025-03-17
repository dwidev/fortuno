enum OrderStatus {
  all,
  waiting,
  process,
  done,
  cancel;

  String tabValue(String count) {
    switch (this) {
      case OrderStatus.all:
        return "Semua";
      case OrderStatus.waiting:
        return "Menunggu ($count)";
      case OrderStatus.process:
        return "Proses";
      case OrderStatus.done:
        return "Selesai";
      case OrderStatus.cancel:
        return "Batal";
    }
  }
}

OrderStatus orderStatusfromString(String value) {
  switch (value) {
    case 'waiting':
      return OrderStatus.waiting;
    case 'process':
      return OrderStatus.process;
    case 'done':
      return OrderStatus.done;
    case 'cancel':
      return OrderStatus.cancel;
    default:
      throw ArgumentError("$value not values for OrderStatus enums");
  }
}
