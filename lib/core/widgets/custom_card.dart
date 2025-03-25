import '../core.dart';

class CustomCard extends Container {
  CustomCard({
    super.key,
    super.alignment,
    super.padding,
    super.color,
    super.decoration,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.clipBehavior = Clip.none,
    super.child,
  });

  @override
  Decoration? get decoration =>
      super.decoration ??
      BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(kDefaultRadius * 1.5),
        boxShadow: defaultShadow,
      );

  @override
  EdgeInsetsGeometry? get padding => super.padding ?? [anchorAllContent].merge;
}
