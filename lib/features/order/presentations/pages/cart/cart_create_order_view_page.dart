import 'package:fortuno/features/order/presentations/pages/process_order_page.dart';

import '../../../../../core/core.dart';
import '../../../../../core/widgets/form/text_form_field_widget.dart';
import '../../../domain/entities/order_item.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_processing_bloc.dart';

class CartCreateOrderViewPage extends StatelessWidget {
  const CartCreateOrderViewPage({
    super.key,
    required this.onBack,
    this.viewOnly = false,
  });

  final bool viewOnly;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final totalPriceOrder = context.select<CartBloc, String>(
      (value) => value.state.items.totalPriceString,
    );
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
              if (!viewOnly)
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
              if (!viewOnly) ...[SizedBox(height: kSizeS), Divider()],
              SizedBox(height: kSizeS),
              Text(
                "Rincian pesanan",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: mustardYellow,
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: kSizeMS),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: darkOliveGreen,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      item.contents,
                                      style: context.textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${item.priceString} ${item.quantityTitle}",
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  item.totalPriceString,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: kSizeSS),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    totalPriceOrder,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: kSizeM),
              if (!viewOnly)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ongkir",
                          style: context.textTheme.titleMedium?.copyWith(
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
                        controller: bloc.shippingCostController,
                        keyboardType: TextInputType.number,
                        hintText: "Ongkir: Rp.xxxxx",
                        onEditingComplete: (value) {
                          bloc.add(OnChangeShippingConstEvent(cost: value));
                        },
                      ),
                    ),
                  ],
                ),
              SizedBox(height: kSizeL),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Bayar",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BlocBuilder<CartProcessingBloc, CartProcessingState>(
                    builder: (context, state) {
                      return Text(
                            state.order.totalPriceString,
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: darkOliveGreen,
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .shimmer(
                            color: darkLightColor,
                            duration: Duration(seconds: 3),
                            delay: Duration(seconds: 1),
                          );
                    },
                  ),
                ],
              ),
              SizedBox(height: kDefaultPadding),
              Divider(),
              SizedBox(height: kSizeS),
              Text(
                "Data Pemesan",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: mustardYellow,
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama : ",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      Text(
                        "Tanggal & jam kirim : ",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      Text(
                        "Alamat kirim : ",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        bloc.client.name,
                        style: context.textTheme.bodyMedium,
                      ),
                      SizedBox(height: kDefaultPadding),
                      Text(
                        "${formatDate(bloc.client.sendDate, pattern: 'EEE, dd MMM yyyy HH:mm')} WIB",
                        style: context.textTheme.bodyMedium,
                      ),
                      SizedBox(height: kDefaultPadding),
                      SizedBox(
                        width: 200,
                        child: Text(
                          bloc.client.addressDisplay,
                          textAlign: TextAlign.right,
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (!context.isKeyboardOpen && !viewOnly)
                SizedBox(height: kSizeXXL * 2),
            ],
          ),
        );
      },
    );
  }
}
