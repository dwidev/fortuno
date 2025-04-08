import '../core.dart';

class TextBadgeWidget extends StatelessWidget {
  const TextBadgeWidget({
    super.key,
    required this.text,
    this.color,
    this.opactiy,
    this.noOpacity = false,
  });

  final String text;
  final Color? color;
  final double? opactiy;
  final bool noOpacity;

  Color get backgroundColor {
    if (noOpacity) {
      return color ?? primaryColor;
    }

    return color?.withAlpha((255 * (opactiy ?? 0.5)).toInt()) ??
        primaryColor.withAlpha((255 * (opactiy ?? 0.5)).toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kSizeSS),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kSizeS * 0.5),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: getTextColorBased(backgroundColor),
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.clip,
        maxLines: 2,
      ),
    );
  }
}
