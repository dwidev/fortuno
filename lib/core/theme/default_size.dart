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

extension S on List<EdgeInsets> {
  EdgeInsets get merge {
    var edge = EdgeInsets.zero;
    forEach((e) => edge = edge + e);
    return edge;
  }
}
