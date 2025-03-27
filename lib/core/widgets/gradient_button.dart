// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../core.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    this.width,
    this.height,
    required this.child,
    required this.onPressed,
    this.gradient,
    this.noShadow = false,
    this.isGradient = false,
    this.backgroundColor = primaryColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Widget child;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final bool noShadow;
  final bool isGradient;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(kDefaultRadius * 0.5);

    return AnimatedContainer(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height ?? 40,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: !noShadow ? defaultShadowButton : null,
        color: backgroundColor,
        gradient:
            isGradient
                ? (gradient ??
                    LinearGradient(colors: [primaryColor, secondaryColor]))
                : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isGradient ? Colors.transparent : backgroundColor,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
        child: Center(child: child),
      ),
    );
  }
}
