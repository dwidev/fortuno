import 'package:dotted_border/dotted_border.dart';
import 'package:fortuno/core/core.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(kDefaultRadius),
      padding: EdgeInsets.all(kSizeSS),
      color: lightGrey3,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(kDefaultRadius * 0.8),
        child: Ink(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: lightGrey5,
            borderRadius: BorderRadius.circular(kDefaultRadius * 0.8),
          ),
          child: Center(
            child: Text(
              "Upload Gambar",
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(color: lightGrey2),
            ),
          ),
        ),
      ),
    );
  }
}
