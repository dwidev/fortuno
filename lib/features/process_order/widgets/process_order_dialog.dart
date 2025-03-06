import 'package:flutter_swipe_button/flutter_swipe_button.dart';

import '../../../core/core.dart';
import '../../../core/widgets/form/text_form_field_widget.dart';

Future<T?> showProcessDialog<T>({
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

class ProcessOrderViewPage extends StatefulWidget {
  final VoidCallback onSwipe;

  const ProcessOrderViewPage({super.key, required this.onSwipe});

  @override
  State<ProcessOrderViewPage> createState() => _ProcessOrderViewPageState();
}

class _ProcessOrderViewPageState extends State<ProcessOrderViewPage> {
  final optionProcess = ["Bayar/Dp", "Nanti"];

  String? value = "Bayar/Dp";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 3,
      // height: context.height / 3,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Proses pesanan SMK ADI SANGGORO",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeM),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:
                optionProcess.map((e) {
                  return Expanded(
                    child: RadioListTile<String?>.adaptive(
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        setState(() {
                          this.value = value;
                        });
                      },
                      title: Text(e),
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: kSizeM),
          if (value?.toLowerCase() != "nanti")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormFieldWidget(
                        title: "",
                        hintText: "Masukan Nomial bayar",
                      ),
                    ),
                    SizedBox(width: kSizeS),
                    GradientButton(
                      width: 80,
                      onPressed: () {},
                      child: Icon(CupertinoIcons.photo),
                    ),
                  ],
                ),
                SizedBox(height: kSizeM),
                ImagePreviewWidget(title: "", size: 100),
              ],
            ),
          SizedBox(height: kSizeM),
          Align(
            alignment: Alignment.center,
            child: SwipeButton.expand(
                  onSwipe: () {
                    widget.onSwipe();
                  },
                  activeThumbColor: softLimeColor,
                  activeTrackColor: darkLightColor,
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                  thumb: Icon(Icons.double_arrow_rounded),
                  child: Text(
                    "Geser untuk Proses order ...",
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
