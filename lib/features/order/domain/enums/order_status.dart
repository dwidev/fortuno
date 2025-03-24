enum OrderStatus {
  waiting,
  process,
  done,
  cancel;

  bool get iswaiting => this == OrderStatus.waiting;
  bool get isprocess => this == OrderStatus.process;
  bool get isdone => this == OrderStatus.done;
  bool get iscancel => this == OrderStatus.cancel;

  String tabValue(String count) {
    switch (this) {
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

  String get valueAction {
    switch (this) {
      case OrderStatus.waiting:
        return "Proses";
      case OrderStatus.process:
        return "Done";
      default:
        throw ArgumentError("$this not available for value action");
    }
  }

  OrderStatus get moveStatus {
    switch (this) {
      case OrderStatus.waiting:
        return OrderStatus.process;
      case OrderStatus.process:
        return OrderStatus.done;
      default:
        throw ArgumentError("$this not available for moveStatus");
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
