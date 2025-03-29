import 'dart:math';

String codeGen(String string) {
  var data = string.split(" ").map((e) => e[0]).join();

  DateTime now = DateTime.now();
  String timeCode =
      "${now.second}${now.millisecond.toString().padLeft(3, '0')}";

  int randomNum = Random().nextInt(999) + 100;

  data += timeCode;
  data += randomNum.toString();
  return data;
}
