import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';

class PaymentDetailsViewsPage extends StatelessWidget {
  const PaymentDetailsViewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ButtonCircleWidget(
                icon: CupertinoIcons.back,
                buttonSize: kSizeXL,
                onPressed: () {},
                iconColor: darkColor,
              ),
              Text(
                "Rincian Pembayaran",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: mustardYellow,
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            "Rincian pesanan",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: mustardYellow,
            ),
          ),
          ...List.generate(
            3,
            (index) => Padding(
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
            ),
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
                "Rp 2.000.000",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeS),
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
          if (!context.isKeyboardOpen) SizedBox(height: kSizeXXL * 2),
        ],
      ),
    );
  }
}
