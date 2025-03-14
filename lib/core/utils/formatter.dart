import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  if (date == null) return "";
  final formated = DateFormat.yMMMEd('id_ID').format(date);
  return formated;
}

String moneyFormatter(double? price) {
  if (price == null) return "";
  final formatted = NumberFormat.currency(
    locale: 'id_ID',
    symbol: "Rp. ",
    decimalDigits: 0,
  ).format(price);

  return formatted;
}
