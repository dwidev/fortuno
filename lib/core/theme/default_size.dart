// default size
import 'package:fortuno/core/core.dart';

const kDefaultPadding = kSizeMS;
const kDefaultRadius = kSizeM;

// size
const kSizeSS = 5.0;
const kSizeS = 10.0;
const kSizeMS = 15.0;
const kSizeM = 20.0;
const kSizeML = 25.0;
const kSizeL = 30.0;
const kSizeXL = 40.0;
const kSizeXXL = 50.0;

final anchorCustomAppBar = EdgeInsets.all(
  kDefaultRadius,
).copyWith(top: kSizeML + kSizeML);

final anchorAllContent = EdgeInsets.all(kSizeM);
final anchorHorizontalContent = EdgeInsets.symmetric(horizontal: kSizeM);
final anchorVerticalContent = EdgeInsets.symmetric(vertical: kSizeM);

final anchorLeftContent = EdgeInsets.only(left: kSizeM);
final anchorRightContent = EdgeInsets.only(right: kSizeM);
final anchorTopContent = EdgeInsets.only(top: kSizeM);
final anchorBottomContent = EdgeInsets.only(bottom: kSizeM);

extension ListEdgeInsetsEx on List<EdgeInsets> {
  EdgeInsets get merge {
    var edge = EdgeInsets.zero;
    forEach((e) => edge = edge + e);
    return edge;
  }
}

extension EdgeInsetsEx on EdgeInsets {
  EdgeInsets replace({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
  }) {
    final v = vertical;
    final h = horizontal;
    if (v != null || h != null) {
      return EdgeInsets.symmetric(
        vertical: v ?? this.vertical,
        horizontal: h ?? this.horizontal,
      );
    }

    return EdgeInsets.fromLTRB(
      left ?? this.left,
      top ?? this.top,
      right ?? this.right,
      bottom ?? this.bottom,
    );
  }

  EdgeInsets min(
    double? value, {
    double? vertical,
    double? horizontal,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (value != null && value != 0) {
      return this - EdgeInsets.all(value);
    }

    var edge = this;
    if (vertical != null || horizontal != null) {
      return EdgeInsets.symmetric(
        vertical: vertical != null ? this.vertical - vertical : this.vertical,
        horizontal:
            horizontal != null ? this.horizontal - horizontal : this.horizontal,
      );
    }

    edge = EdgeInsets.fromLTRB(
      this.left - (left ?? 0.0),
      this.top - (top ?? 0.0),
      this.right - (right ?? 0.0),
      this.bottom - (bottom ?? 0.0),
    );

    return edge;
  }
}
