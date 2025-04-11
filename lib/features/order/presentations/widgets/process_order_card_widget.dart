import 'package:dotted_line/dotted_line.dart';

import '../../../../core/core.dart';
import '../../domain/entities/order.dart';

class ProcessOrderCardWidget extends StatelessWidget {
  const ProcessOrderCardWidget({
    super.key,
    required this.onTap,
    required this.onClickInvoice,
    required this.isClick,
    required this.order,
  });

  final Function(Order order) onTap;
  final Function(Order order) onClickInvoice;
  final bool isClick;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(order),
      child: CustomCard(
        margin: anchorBottomContent,
        border: isClick ? Border.all(color: primaryColor, width: 1) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.client.name.toUpperCase(),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Order #${order.id.replaceAll("-", "").substring(1, 10).toUpperCase()}",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: kSizeM),
                TextBadgeWidget(
                  text: order.orderStatus.name,
                  color: order.orderStatus.color,
                ),
              ],
            ),
            SizedBox(height: kSizeM),
            Text(order.createdAtDisplay),
            SizedBox(height: kSizeS),
            DottedLine(dashColor: lightGrey4),
            SizedBox(height: kSizeS),
            Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Produk",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Quantity",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Total",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ...List.generate(order.items.length, (index) {
                  final item = order.items[index];
                  return TableRow(
                    children: [
                      Container(
                        margin: anchorRightContent,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          item.title,
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                      Container(
                        margin: anchorRightContent,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          item.quantity.toString(),
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          item.totalPriceString,
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            SizedBox(height: kSizeS),
            DottedLine(dashColor: lightGrey4),
            SizedBox(height: kSizeS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ongkos kirim",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: greyColor,
                  ),
                ),
                Text(
                  order.shippingCostString,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: greyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: kSizeS),
            DottedLine(dashColor: lightGrey4),
            SizedBox(height: kSizeS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.totalPriceString,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: kSizeM),
            Row(
              children: [
                Expanded(
                  flex: order.orderStatus.isprocess ? 2 : 4,
                  child: GradientButton(
                    onPressed: () => onClickInvoice(order),
                    isGradient: true,
                    child: Text("Invoice"),
                  ),
                ),
                SizedBox(width: kSizeSS),
                if (order.orderStatus.iswaiting) ...[
                  Expanded(
                    child: GradientButton(
                      onPressed: () {},
                      child: Icon(CupertinoIcons.ellipsis),
                    ),
                  ),
                ],
                // if (order.orderStatus.isprocess) ...[
                //   Expanded(
                //     child: GradientButton(
                //       onPressed: () {},
                //       backgroundColor:
                //           successButtonColor,
                //       child: Text("Done"),
                //     ),
                //   ),
                // ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
