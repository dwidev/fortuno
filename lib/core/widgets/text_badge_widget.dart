import '../core.dart';

class TextBadgeWidget extends StatelessWidget {
  const TextBadgeWidget({super.key, required this.text, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kSizeSS),
      decoration: BoxDecoration(
        color: color?.withAlpha(50) ?? primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(kSizeS * 0.5),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: color ?? primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
