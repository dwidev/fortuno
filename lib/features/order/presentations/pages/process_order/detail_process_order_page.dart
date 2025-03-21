import 'package:fortuno/features/order/domain/enums/order_status.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/order.dart';
import '../../bloc/order_process/order_process_bloc.dart';
import '../../widgets/order_action_widget.dart';
import '../../widgets/order_summary_widget.dart';
import '../../../../payments/presentation/widgets/process_order_dialog.dart';

class DetailProcessOrderPage extends StatefulWidget {
  final Animation<double>? widthAnimation;
  final double? maxWidthDetail;
  final VoidCallback onClosePage;

  const DetailProcessOrderPage({
    super.key,
    this.widthAnimation,
    this.maxWidthDetail,
    required this.onClosePage,
  });

  @override
  State<DetailProcessOrderPage> createState() => _DetailProcessOrderPageState();
}

class _DetailProcessOrderPageState extends State<DetailProcessOrderPage> {
  void onTap(Order order) {
    final bloc = context.read<OrderProcessBloc>();

    showProcessDialog(
      order: order,
      context: context,
      onSwipe: (result) {
        widget.onClosePage();
        bloc.add(
          OnUpdateStatusOrder(
            orderID: order.id,
            invoiceId: order.invoice.id,
            newStatus: order.orderStatus.moveStatus,
            result: result,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.widthAnimation!,
      builder: (context, _) {
        final wAnimation = widget.widthAnimation;
        if (wAnimation == null) {
          return Offstage();
        }

        return SizedBox(
          height: context.height,
          width: wAnimation.value,
          child: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            color: whiteColor,
            child:
                wAnimation.value >= (widget.maxWidthDetail ?? 0)
                    ? BlocBuilder<OrderProcessBloc, OrderProcessState>(
                      builder: (context, state) {
                        final order = state.order;
                        final client = state.order.client;
                        final orderItems = state.order.items;
                        return Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      client.name,
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    IconButton(
                                      onPressed: widget.onClosePage,
                                      icon: Icon(
                                        CupertinoIcons.clear,
                                        size: kSizeL,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OrderSummaryWidget(
                                          order: order,
                                          items: orderItems,
                                          client: client,
                                        ),
                                        SizedBox(height: kSizeXL),
                                        Row(
                                          children: [
                                            ImagePreviewWidget(
                                              title: "Bukti Dp",
                                            ),
                                            SizedBox(width: kSizeM),
                                            ImagePreviewWidget(
                                              title: "Bukti Pelunasan",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Row(
                                children: [
                                  if (order.orderStatus ==
                                          OrderStatus.waiting ||
                                      order.orderStatus == OrderStatus.process)
                                    GradientButton(
                                      height: 35,
                                      width: 130,
                                      onPressed: () => onTap(order),
                                      child: Text(
                                        order.orderStatus.valueAction,
                                      ),
                                    ),
                                  SizedBox(width: kSizeS),
                                  OrderActionWidget(order: order),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )
                    : Offstage(),
          ),
        );
      },
    );
  }
}
