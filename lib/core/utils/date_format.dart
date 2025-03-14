import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  if (date == null) return "";
  final formated = DateFormat.yMMMEd('id_ID').format(date);
  return formated;
}
