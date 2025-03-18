// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../../domain/entities/order.dart';
import '../../domain/enums/payment_option.dart';

class ProcessOrderDialogResult {
  final PaymentOption option;

  ProcessOrderDialogResult({required this.option});
}

Future<T?> showProcessDialog<T>({
  required BuildContext context,
  required Order order,
  required Function(ProcessOrderDialogResult result) onSwipe,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: ProcessOrderViewPage(onSwipe: onSwipe, order: order),
      );
    },
  );
}

class ProcessOrderViewPage extends StatefulWidget {
  final Order order;
  final Function(ProcessOrderDialogResult result) onSwipe;

  const ProcessOrderViewPage({
    super.key,
    required this.order,
    required this.onSwipe,
  });

  @override
  State<ProcessOrderViewPage> createState() => _ProcessOrderViewPageState();
}

class _ProcessOrderViewPageState extends State<ProcessOrderViewPage> {
  late TextEditingController controller;
  final formKey = GlobalKey<FormState>();

  final optionProcess = [PaymentOption.cash, PaymentOption.transfer];
  PaymentOption value = PaymentOption.cash;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  void onSwipe() {
    if (value == PaymentOption.transfer &&
        formKey.currentState?.validate() == false) {
      return;
    }

    context.pop(); // pop this dialog

    final result = ProcessOrderDialogResult(option: value);
    widget.onSwipe(result);
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Proses pesanan ${widget.order.client.name}",
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
                    child: RadioListTile<PaymentOption>.adaptive(
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          this.value = value;
                        });
                      },
                      title: Text(e.title),
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: kSizeM),
          if (value == PaymentOption.transfer)
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: controller,
                          title: "",
                          hintText: "Masukan Nomial bayar",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Masukan nilai bayar";
                            }

                            return null;
                          },
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
                  Text(
                    "*Masukan nilai yang ingin dibayarkan & bukti transfer",
                    style: context.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: kSizeM),
                  // ImagePreviewWidget(title: "", size: 100),
                  // SizedBox(height: kSizeM),
                ],
              ),
            ),
          Align(
            alignment: Alignment.center,
            child: SwipeButton.expand(
                  onSwipe: onSwipe,
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
