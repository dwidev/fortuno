import '../../../../../../core/core.dart';
import '../../../../../../core/widgets/form/currency_form_field_widget.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_processing_bloc.dart';
import '../../../widgets/order_summary_widget.dart';
import '../../process_order/process_order_page.dart';

class CartCreateOrderViewPage extends StatelessWidget {
  const CartCreateOrderViewPage({super.key});

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
        return Container(
          padding: EdgeInsets.only(right: kSizeM),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                style: context.textTheme.bodySmall?.copyWith(
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
                            child: CurrencyFormFieldWidget(
                              title: "",
                              controller: cartProcess.shippingCostController,
                              hintText: "Ongkir: Rp.xxxxx",
                              onChanged: (value) {
                                bloc.add(OnChangeShippingConstEvent());
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
          ),
        );
      },
    );
  }
}
