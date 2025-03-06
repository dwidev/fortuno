import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:fortuno/core/core.dart';

class ImagePreviewWidget extends StatelessWidget {
  const ImagePreviewWidget({super.key, required this.title, this.size = 120});

  final double size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final image =
            Image.network(
              "https://mediakonsumen.com/files/2024/10/Screenshot_20240920-030802-3.jpg",
            ).image;

        showImageViewer(
          context,
          image,
          doubleTapZoomable: true,
          backgroundColor: darkColor.withAlpha(50),
          swipeDismissible: true,
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: darkLightColor,
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://mediakonsumen.com/files/2024/10/Screenshot_20240920-030802-3.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: darkColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
              ),
              SizedBox(
                width: size,
                height: size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.eye_fill,
                      size: size * 0.1,
                      color: whiteColor,
                    ),
                    if (title.isNotEmpty) SizedBox(height: kSizeS),
                    if (title.isNotEmpty)
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
