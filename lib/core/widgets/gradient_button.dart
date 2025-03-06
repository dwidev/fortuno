import '../core.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.gradient,
    this.noShadow = false,
  });

  final double? width;
  final double? height;
  final Widget child;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final bool noShadow;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedContainer(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: EdgeInsets.zero,
      duration: const Duration(milliseconds: 200),
      width: width ?? size.width / 1.3,
      height: height ?? 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
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
        gradient:
            gradient ??
            LinearGradient(colors: [mutedLemonColor, sageGreenColor]),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: child,
      ),
    );
  }
}
