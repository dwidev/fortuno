import 'package:flutter/material.dart';
import 'package:fortuno/core/theme/colors.dart';
import 'package:fortuno/core/theme/default_size.dart';

class ButtonCircleWidget extends StatelessWidget {
  static const _defaultButtonSize = kSizeXL;

  const ButtonCircleWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    this.buttonSize = _defaultButtonSize,
    this.backgroundColor = Colors.white,
    this.isGradientBackground = false,
    this.gradiendBackgroundColor = const [],
    this.iconColor = Colors.white,
    this.noShadow = false,
  });

  factory ButtonCircleWidget.gradient({
    required dynamic icon,
    required VoidCallback? onPressed,
    double buttonSize = _defaultButtonSize,
    List<Color>? gradiendBackgroundColor,
    Color iconColor = Colors.white,
    bool noShadow = true,
  }) {
    return ButtonCircleWidget(
      icon: icon,
      iconColor: iconColor,
      isGradientBackground: true,
      gradiendBackgroundColor:
          gradiendBackgroundColor ?? [mutedLemonColor, sageGreenColor],
      onPressed: onPressed,
      buttonSize: buttonSize,
      noShadow: noShadow,
    );
  }

  final dynamic icon;

  /// if [icon] is type [Image] icon color not effect, this only for
  /// for [icon] is type [IconData]
  final Color iconColor;
  final double buttonSize;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  final bool isGradientBackground;
  final List<Color> gradiendBackgroundColor;
  final bool noShadow;

  @override
  Widget build(BuildContext context) {
    final primary = isGradientBackground ? Colors.transparent : backgroundColor;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient:
            isGradientBackground && onPressed != null
                ? LinearGradient(colors: gradiendBackgroundColor)
                : null,
        boxShadow:
            !noShadow
                ? const [
                  BoxShadow(
                    color: Color.fromARGB(128, 143, 143, 143),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ]
                : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: primary,
          shape: const CircleBorder(),
          padding: EdgeInsets.all(buttonSize / 4),
        ),
        child:
            icon is IconData
                ? Icon(icon as IconData, size: buttonSize / 2, color: iconColor)
                : Image.asset(icon),
      ),
    );
  }
}
