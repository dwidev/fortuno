// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fortuno/features/order/presentations/pages/process_order/process_order_page.dart';
import 'package:fortuno/features/order/presentations/widgets/order_summary_widget.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/widgets/form/text_form_field_widget.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_processing_bloc.dart';

class CartCreateOrderViewPage extends StatelessWidget {
  const CartCreateOrderViewPage({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    final cartProcess = context.read<CartProcessingBloc>();

    return BaseListenerWidget<CartProcessingBloc, CartProcessingState>(
      listener: (context, state) async {
        if (state is CartDoneCreateOrder) {
          await showSuccessDialog(
            context: context,
            desc: "Pesanan berhasil dibuat",
            onOke: () {
              context.pop();
              context.go(ProcessOrderPage.path);
              cartBloc.add(ResetCart());
              cartProcess.add(ResetProcessingOrder());
            },
          );
        }
      },
      builder: (context, bloc, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ButtonCircleWidget.gradient(
                    icon: CupertinoIcons.back,
                    buttonSize: kSizeXL,
                    onPressed: onBack,
                    iconColor: darkColor,
                  ),
                  SizedBox(width: kSizeM),
                  Text(
                    "Rincian Pembayaran",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: mustardYellow,
                    ),
                  ),
                ],
              ),
              SizedBox(height: kSizeS),
              Divider(),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return OrderSummaryWidget(
                    order: cartProcess.state.order,
                    items: state.items,
                    client: bloc.client,
                    additionalPriceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ongkir",
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                "*Cek aplikasi grab/gojek lalu input manual nilai ongkir",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.redAccent,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: context.width * 0.1,
                          padding: EdgeInsets.symmetric(
                            horizontal: kSizeMS,
                          ).copyWith(right: 0),
                          child: TextFormFieldWidget(
                            title: "",
                            controller: cartProcess.shippingCostController,
                            keyboardType: TextInputType.number,
                            hintText: "Ongkir: Rp.xxxxx",
                            onEditingComplete: (value) {
                              bloc.add(OnChangeShippingConstEvent(cost: value));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (!context.isKeyboardOpen) SizedBox(height: kSizeXXL * 2),
            ],
          ),
        );
      },
    );
  }
}
