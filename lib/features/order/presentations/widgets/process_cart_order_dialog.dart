import 'package:flutter_swipe_button/flutter_swipe_button.dart';

import '../../../../core/core.dart';

Future<T?> showProcessCartDialog<T>({
  required BuildContext context,
  required VoidCallback onSwipe,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(child: ProcessOrderViewPage(onSwipe: onSwipe));
    },
  );
}

class ProcessOrderViewPage extends StatelessWidget {
  final VoidCallback onSwipe;

  const ProcessOrderViewPage({super.key, required this.onSwipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 3,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 45,
                child: Center(
                  child: Text(
                    "Konfimasi",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: kSizeS,
                child: ButtonCircleWidget.gradient(
                  icon: CupertinoIcons.clear,
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeM),
          Text("Pesanan sudah sesuai? cek kembali jika belum yakin!"),
          SizedBox(height: kSizeM),
          Align(
            alignment: Alignment.center,
            child: SwipeButton.expand(
                  onSwipe: () {
                    onSwipe();
                  },
                  activeThumbColor: softLimeColor,
                  activeTrackColor: darkLightColor,
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                  thumb: Icon(Icons.double_arrow_rounded),
                  child: Text(
                    "Geser untuk Buat order ...",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: darkColor.withAlpha(120),
                    ),
                  ),
                )
                .animate(onPlay: (c) => c.repeat())
                .shimmer(
                  duration: Duration(milliseconds: 600),
                  delay: Duration(seconds: 2),
                  color: darkLightColor,
                ),
          ),
        ],
      ),
    );
  }
}
