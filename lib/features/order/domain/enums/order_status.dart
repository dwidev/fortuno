enum OrderStatus { waiting, process, done, cancel }

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
      throw ArgumentError("not value for OrderStatus enums");
  }
}
