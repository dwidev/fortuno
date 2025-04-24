import 'package:dotted_line/dotted_line.dart';

import '../../../../core/core.dart';
import '../../domain/entities/order.dart';

class ProcessOrderCardWidget extends StatefulWidget {
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
  State<ProcessOrderCardWidget> createState() => _ProcessOrderCardWidgetState();
}

class _ProcessOrderCardWidgetState extends State<ProcessOrderCardWidget> {
  var isHilight = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final diff = now.difference(widget.order.updatedAt).inSeconds;

    if (diff < 5) {
      isHilight = true;

      Future.delayed(Duration(seconds: 5 - diff), () {
        if (mounted) {
          setState(() {
            isHilight = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.order),
      child: CustomCard(
        duration: 2.seconds,
        backgroundColor: isHilight ? azureMist : whiteColor,
        margin: anchorBottomContent,
        border:
            widget.isClick ? Border.all(color: primaryColor, width: 1) : null,
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
                        widget.order.client.name.toUpperCase(),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Order #${widget.order.id.replaceAll("-", "").substring(1, 10).toUpperCase()}",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: kSizeM),
                TextBadgeWidget(
                  text: widget.order.orderStatus.name,
                  color: widget.order.orderStatus.color,
                ),
              ],
            ),
            SizedBox(height: kSizeM),
            Text(widget.order.createdAtDisplay),
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
                ...List.generate(widget.order.items.length, (index) {
                  final item = widget.order.items[index];
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
                  widget.order.shippingCostString,
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
                  widget.order.totalPriceString,
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
                  flex: widget.order.orderStatus.isprocess ? 2 : 4,
                  child: GradientButton(
                    onPressed: () => widget.onClickInvoice(widget.order),
                    isGradient: true,
                    child: Text("Invoice"),
                  ),
                ),
                SizedBox(width: kSizeSS),
                if (widget.order.orderStatus.iswaiting) ...[
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
