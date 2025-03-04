import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:fortuno/core/core.dart';

class ImagePreviewWidget extends StatelessWidget {
  const ImagePreviewWidget({super.key, required this.title});

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
                width: 200,
                height: 200,
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
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: darkColor.withAlpha(150),
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.eye, size: kSizeL, color: whiteColor),
                    SizedBox(height: kSizeS),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(
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
