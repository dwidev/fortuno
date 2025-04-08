part of '../currency_form_field_widget.dart';

class TextEditingIDRController extends TextEditingController {
  final double initialValue;
  late CurrencyTextInputFormatter formatter;

  TextEditingIDRController({this.initialValue = 0.0}) {
    assert(
      text.isEmpty,
      "required text is empty, the value will be overide by initialValue",
    );

    formatter = CurrencyTextInputFormatter.currency(
      symbol: "Rp. ",
      decimalDigits: 0,
      enableNegative: false,
    );
    _initialValueFormated(initialValue);
  }

  double getDoubleValue() {
    final value = formatter.getUnformattedValue();
    return value.toDouble();
  }

  void _initialValueFormated(doub) {
    if (initialValue == 0) return;
    text = formatter.formatDouble(initialValue);
    value = TextEditingValue(text: text);
  }
}
