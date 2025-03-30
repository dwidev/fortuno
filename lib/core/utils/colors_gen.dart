import 'package:fortuno/core/core.dart';

Color getValueColor(String value) {
  final int hash = value.hashCode * 999;
  final double hue = (hash % 360).toDouble();
  const double saturation = 0.6;
  const double lightness = 0.2;

  return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
}

Color getTextColorBased(Color backgroundColor) {
  final hsl = HSLColor.fromColor(backgroundColor);
  final double newLightness = hsl.lightness > 0.5 ? 0.2 : 0.9;

  return hsl.withLightness(newLightness).toColor();
}
