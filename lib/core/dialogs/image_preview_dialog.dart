import '../core.dart';

Future<void> showImagePreviewDialog({required BuildContext context}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          // width: context.width / 3,
          // height: context.height / 2,
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: context.height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://mediakonsumen.com/files/2024/10/Screenshot_20240920-030802-3.jpg",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
