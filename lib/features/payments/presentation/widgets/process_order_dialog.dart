// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:fortuno/features/order/domain/enums/order_status.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/currency_form_field_widget.dart';
import '../../../order/domain/entities/order.dart';
import '../../../order/domain/enums/payment_option.dart';

class ProcessOrderDialogResult {
  final PaymentOption option;
  final bool paylatter;
  final double amount;

  ProcessOrderDialogResult({
    required this.option,
    required this.paylatter,
    required this.amount,
  });
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
  late TextEditingIDRController controller;
  final formKey = GlobalKey<FormState>();
  bool paylatter = false;

  final optionProcess = [PaymentOption.cash, PaymentOption.transfer];
  PaymentOption value = PaymentOption.cash;

  bool get isPaylatter =>
      value.isCash && widget.order.orderStatus == OrderStatus.waiting;

  @override
  void initState() {
    controller = TextEditingIDRController(initialValue: widget.order.pay);
    super.initState();
  }

  void onSwipe() {
    if (!paylatter && formKey.currentState?.validate() == false) {
      return;
    }

    context.pop(); // pop this dialog

    final amount = controller.getDoubleValue();
    final result = ProcessOrderDialogResult(
      option: value,
      paylatter: paylatter,
      amount: paylatter == false ? amount : 0.0,
    );

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          if (value.isTransfer) {
                            paylatter = false;
                          }
                        });
                      },
                      title: Text(e.title),
                    ),
                  );
                }).toList(),
          ),
          if (!paylatter) SizedBox(height: kSizeM),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!paylatter) ...[
                Form(
                  key: formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CurrencyFormFieldWidget(
                          controller: controller,
                          title: "",
                          hintText: "Masukan Nomial bayar",
                          validator: (value) {
                            final data = value;

                            if (widget.order.orderStatus.iswaiting) {
                              if (data < widget.order.pay) {
                                return "Kurang dari nilai DP 30% (${moneyFormatter(widget.order.pay)})";
                              }
                            }

                            if (widget.order.orderStatus.isprocess) {
                              if (data < widget.order.remainingPayment) {
                                return "Kurang dari sisa pembayaran ${moneyFormatter(widget.order.remainingPayment)}";
                              }
                            }

                            if (data > widget.order.totalPrice) {
                              return "Tidak boleh melebihi total bayar ${moneyFormatter(widget.order.totalPrice)}";
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: kSizeS),
                      if (value == PaymentOption.transfer)
                        GradientButton(
                          width: 80,
                          onPressed: () {},
                          child: Icon(CupertinoIcons.photo),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: kSizeM),
              ],
              if (isPaylatter) ...[
                Row(
                  children: [
                    Switch.adaptive(
                      value: paylatter,
                      onChanged: (value) {
                        setState(() {
                          paylatter = !paylatter;
                        });
                      },
                    ),
                    Text("Bayar nanti", style: context.textTheme.bodySmall),
                  ],
                ),
                SizedBox(height: kSizeM),
              ],
              // ImagePreviewWidget(title: "", size: 100),
              // SizedBox(height: kSizeM),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SwipeButton.expand(
                  onSwipe: onSwipe,
                  activeThumbColor: primaryColor,
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
          SizedBox(height: kSizeM),
          if (widget.order.orderStatus.iswaiting)
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Minimal down payment adalah 30%",
                style: context.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: warningButtonColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
