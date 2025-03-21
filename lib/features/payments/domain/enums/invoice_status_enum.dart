enum InvoiceStatus { unpaid, paid, expired }

InvoiceStatus invoiceStatusFromString(String value) {
  return switch (value) {
    'unpaid' => InvoiceStatus.unpaid,
    'paid' => InvoiceStatus.paid,
    'expired' => InvoiceStatus.expired,
    _ => throw ArgumentError('$value is not type InvoiceStatus enums'),
  };
}
