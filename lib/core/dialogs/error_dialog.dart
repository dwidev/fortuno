import 'package:lottie/lottie.dart';

import '../core.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required Failure failure,
  required VoidCallback onOke,
}) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: context.width / 3,
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Peringatan",
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: kSizeS),
              Lottie.asset(
                lottieError,
                width: context.width / 7,
                height: context.width / 7,
              ),
              SizedBox(height: kSizeM),
              Text(failure.message, style: context.textTheme.bodyLarge),
              SizedBox(height: kSizeM),
              Align(
                alignment: Alignment.center,
                child: GradientButton(
                  width: 100,
                  onPressed: onOke,
                  child: Text("OK", style: context.textTheme.bodySmall),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
