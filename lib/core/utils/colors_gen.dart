import 'package:fortuno/core/core.dart';

Color getValueColor(String value) {
  final int hash = value.hashCode;
  final double hue = (hash % 360).toDouble();
  const double saturation = 0.6;
  const double lightness = 0.5;

  return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
}
