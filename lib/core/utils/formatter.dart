import 'package:intl/intl.dart';

final now = DateTime.now();

String formatDate(DateTime? date, {String? pattern}) {
  if (date == null) return "";
  final formated = DateFormat(
    pattern ?? DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
    'id_ID',
  ).format(date);
  return formated;
}

DateTime parseToDate(String date, {String? pattern}) {
  final parsed = DateFormat(
    pattern ?? DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
    'id_ID',
  ).parse(date);
  return parsed;
}

DateTime parseToTime(String time) {
  final parsed = DateFormat(DateFormat.HOUR24_MINUTE).parse(time);
  return parsed;
}

String formatToDateTime(DateTime dateTime) {
  final formated = DateFormat('EEE, dd MMM yyyy HH:mm').format(dateTime);
  return "$formated WIB";
}

/// the format [date] is DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY
/// and the format [time] is xx:xx, example : 10:00
DateTime mergeDateAndTime(String date, String time) {
  final d = parseToDate(date);
  final t = parseToTime(time);
  final dateTime = DateTime(d.year, d.month, d.day, t.hour, t.minute, t.second);
  return dateTime;
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
