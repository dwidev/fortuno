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
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: mustardYellow,
          ),
        ),

        ListView.builder(
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
                          style: context.textTheme.bodyMedium?.copyWith(
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
        ),
        SizedBox(height: kSizeSS),
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
              items.totalPriceString,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: kSizeM),
        additionalPriceWidget != null ? additionalPriceWidget! : Offstage(),
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
            Text(
                  order.totalPriceString,
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
                Text(client.name, style: context.textTheme.bodyMedium),
                SizedBox(height: kDefaultPadding),
                Text(
                  "${formatDate(client.sendDate, pattern: 'EEE, dd MMM yyyy HH:mm')} WIB",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  width: 200,
                  child: Text(
                    client.addressDisplay,
                    textAlign: TextAlign.right,
                    style: context.textTheme.bodyMedium,
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
