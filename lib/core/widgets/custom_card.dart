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
    this.border,
  });

  final BoxBorder? border;

  @override
  Decoration? get decoration {
    assert(
      super.decoration == null || border != null,
      "decoration must be null when add border",
    );
    if (super.decoration != null) return super.decoration;

    return BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(kDefaultRadius * 1.5),
      boxShadow: defaultShadow,
      border: border,
    );
  }

  @override
  EdgeInsetsGeometry? get padding => super.padding ?? [anchorAllContent].merge;
}
