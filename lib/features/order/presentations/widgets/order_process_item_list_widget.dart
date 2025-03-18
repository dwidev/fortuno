// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fortuno/core/core.dart';
import 'package:fortuno/features/order/domain/entities/order.dart';

import 'order_action_widget.dart';
import 'order_package_widget.dart';

class OrderProcessItemListWidget extends StatelessWidget {
  const OrderProcessItemListWidget({
    super.key,
    required this.order,
    required this.isDetail,
    required this.activeIndex,
    required this.onClickDetail,
    required this.index,
  });

  final bool isDetail;
  final int index, activeIndex;
  final Order order;
  final Function(Order order) onClickDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding).copyWith(bottom: 0),
      child: Material(
        borderRadius: BorderRadius.circular(kDefaultRadius),
        color:
            isDetail && index == activeIndex ? lemonChiffonColor : whiteColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(kDefaultRadius),
          onTap: () {
            onClickDetail(order);
          },
          child: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.client.name,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: kSizeS),
                        Text(
                          "Dikirim : ${order.client.sendDateDisplay}",
                          style: context.textTheme.bodySmall,
                        ),
                        Text(
                          "Total : ${order.totalPriceString}",
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(width: kSizeXXL),
                    if (!isDetail) OrderPackageWidget(order: order),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [if (!isDetail) OrderActionWidget()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
