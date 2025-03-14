import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/features/order/domain/entities/order_item.dart';

import '../../../../../core/core.dart';
import '../../bloc/cart/cart_bloc.dart';

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
              );
            },
          ),
          SizedBox(height: kSizeM),
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
          SizedBox(height: kSizeS),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSizeMS),
                    color: sunKissedYellowColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: kSizeMS),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Ongkir: Rp.xxxxx"),
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
              Text(
                    "Rp 2.030.000",
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
                  Text("Fahmi syahputra", style: context.textTheme.bodyMedium),
                  SizedBox(height: kDefaultPadding),
                  Text(
                    "02 Februari 2025 10:00 WIB",
                    style: context.textTheme.bodyMedium,
                  ),
                  SizedBox(height: kDefaultPadding),
                  SizedBox(
                    width: 200,
                    child: Text(
                      "Gang Mesjid Al barokah Ciputih gugah sari rt 02 rw 03 Dramaga Bogor (Belakang Gadai yang ada rolling door)",
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
  }
}

class DetailOrderItemWidget extends StatelessWidget {
  const DetailOrderItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "Paket Berkah 20K",
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: darkOliveGreen,
                  ),
                ),
                Text(
                  "Nasi, Ayam bakar, Tahu, Tempe",
                  style: context.textTheme.bodySmall,
                ),
                Text(
                  "Box Kardus + alat makan",
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Rp 20.000 x 200 pax",
                style: context.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 10,
                ),
              ),
              Text(
                "Rp 200.000",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
