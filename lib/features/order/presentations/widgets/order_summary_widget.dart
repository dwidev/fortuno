import 'package:dotted_line/dotted_line.dart';

import '../../../../core/core.dart';
import '../../domain/entities/client_order.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.order,
    required this.items,
    required this.client,
    this.additionalPriceWidget,
  });

  final Order order;
  final List<OrderItem> items;
  final ClientOrder client;
  final Widget? additionalPriceWidget; // for ui ongkir, discount or etc

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: kSizeS),
        Text(
          "Rincian pesanan",
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: items.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = items[index];
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
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            item.contents,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: greyColor,
                              fontSize: 9,
                            ),
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
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: kSizeSS),
        additionalPriceWidget != null ? additionalPriceWidget! : Offstage(),
        SizedBox(height: kSizeM),
        DottedLine(dashColor: lightGrey4),
        SizedBox(height: kSizeM),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sub Total",
              style: context.textTheme.bodySmall?.copyWith(color: lightGrey1),
            ),
            Text(
              items.totalPriceString,
              style: context.textTheme.bodySmall?.copyWith(color: lightGrey1),
            ),
          ],
        ),
        SizedBox(height: kSizeS),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ongkir",
              style: context.textTheme.bodySmall?.copyWith(color: lightGrey1),
            ),
            Text(
              moneyFormatter(order.shippingCost),
              style: context.textTheme.bodySmall?.copyWith(color: lightGrey1),
            ),
          ],
        ),
        SizedBox(height: kSizeS),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Discount",
              style: context.textTheme.bodySmall?.copyWith(color: lightGrey1),
            ),
            Text(
              moneyFormatter(order.discount),
              style: context.textTheme.bodySmall?.copyWith(color: lightGrey1),
            ),
          ],
        ),
        SizedBox(height: kSizeL),
        DottedLine(dashColor: lightGrey4),
        SizedBox(height: kSizeS),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Bayar",
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                  order.totalPriceString,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                )
                .animate(onPlay: (c) => c.repeat())
                .shimmer(
                  color: darkLightColor,
                  duration: Duration(seconds: 3),
                  delay: Duration(seconds: 1),
                ),
          ],
        ),
        SizedBox(height: kSizeS),
        DottedLine(dashColor: lightGrey4),
        SizedBox(height: kSizeML),
        Text(
          "Data Pemesan",
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: kDefaultPadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nama : ",
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  child: Text(
                    client.name,
                    textAlign: TextAlign.right,
                    style: context.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tanggal & jam kirim : ",
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  child: Text(
                    client.sendDateDisplay,
                    textAlign: TextAlign.right,
                    style: context.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Alamat kirim : ",
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      client.addressDisplay,
                      textAlign: TextAlign.right,
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
