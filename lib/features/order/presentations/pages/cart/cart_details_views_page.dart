// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/images_assets.dart' show noOrderPng;
import '../../../../../core/core.dart';
import '../../../../../core/widgets/form/date_form_picker_widget.dart';
import '../../../../../core/widgets/form/text_form_field_widget.dart';
import '../../../../../core/widgets/form/time_form_picker_widget.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../widgets/order_item_widget.dart';

class CartDetailsViewPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const CartDetailsViewPage({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: kSizeS),
            child: Text(
              "Rincian pesanan",
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: mustardYellow,
              ),
            ),
          ),
          SizedBox(height: kSizeMS),
          Divider(),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) {
                return SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(noOrderPng, width: 100),
                      Text(
                        "Belum ada produk yang dipilih",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: darkColor.withAlpha(100),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.items.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return CartOrderItemWidget(item: item);
                },
              );
            },
          ),
          SizedBox(height: kSizeMS * 1.5),
          Text(
            "Data Pemesan",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: mustardYellow,
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: kSizeMS),
                Divider(),
                SizedBox(height: kSizeMS),
                TextFormFieldWidget(title: "Nama pemesan"),
                SizedBox(height: kSizeM),
                Row(
                  children: [
                    Expanded(
                      child: DateFormPickerWidget(title: "Tanggal kirim"),
                    ),
                    SizedBox(width: kSizeMS),
                    Expanded(child: TimeFormPickerWidget(title: "Jam kirm")),
                  ],
                ),
                SizedBox(height: kSizeM),
                TextFormFieldWidget(title: "Alamat", maxLines: 3),
                SizedBox(height: kSizeM),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormFieldWidget(
                        title: "Rw",
                        hintText: "Rw (optional)",
                        optional: true,
                      ),
                    ),
                    SizedBox(width: kSizeMS),
                    Expanded(
                      child: TextFormFieldWidget(
                        title: "Rt",
                        hintText: "Rt (optional)",
                        optional: true,
                      ),
                    ),
                    SizedBox(width: kSizeMS),
                    Expanded(
                      flex: 3,
                      child: TextFormFieldWidget(
                        title: "Detail lokasi",
                        hintText: "contoh : dekat warung samping masjid",
                      ),
                    ),
                  ],
                ),
                if (!context.isKeyboardOpen) SizedBox(height: kSizeXXL * 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
