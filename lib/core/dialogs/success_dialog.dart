import 'package:lottie/lottie.dart';

import '../core.dart';

Future<void> showSuccessDialog({
  required BuildContext context,
  required String desc,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sukses",
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: kSizeS),
              Lottie.asset(
                lottieSuccess,
                width: context.width / 7,
                height: context.width / 7,
              ),
              SizedBox(height: kSizeM),
              Text(
                "Pesanan berhasil dibuat",
                style: context.textTheme.bodyLarge,
              ),
              SizedBox(height: kSizeM),
              Align(
                alignment: Alignment.center,
                child: GradientButton(
                  noShadow: true,
                  width: 100,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
