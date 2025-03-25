import '../../../../../../core/constants/images_assets.dart' show noOrderPng;
import '../../../../../../core/core.dart';
import '../../../../../../core/widgets/form/date_form_picker_widget.dart';
import '../../../../../../core/widgets/form/text_form_field_widget.dart';
import '../../../../../../core/widgets/form/time_form_picker_widget.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_processing_bloc.dart';
import '../../../widgets/order_item_widget.dart';

class CartDetailsViewPage extends StatelessWidget {
  const CartDetailsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartProcessingBloc>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: state.items.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return CartOrderItem(item: item);
                },
              );
            },
          ),
          SizedBox(height: kSizeMS * 1.2),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: bloc.formKey,
            child: Column(
              children: [
                SizedBox(height: kSizeMS),
                TextFormFieldWidget(
                  controller: bloc.nameController,
                  title: "Nama pemesan",
                ),
                SizedBox(height: kSizeM),
                Row(
                  children: [
                    Expanded(
                      child: DateFormPickerWidget(
                        controller: bloc.dateController,
                        title: "Tanggal kirim",
                        firstDate: DateTime.now().add(1.days),
                      ),
                    ),
                    SizedBox(width: kSizeMS),
                    Expanded(
                      child: TimeFormPickerWidget(
                        controller: bloc.timeController,
                        title: "Jam kirm",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kSizeM),
                TextFormFieldWidget(
                  controller: bloc.addressController,
                  title: "Alamat",
                  maxLines: 3,
                ),
                SizedBox(height: kSizeM),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: bloc.rtController,
                        title: "Rt",
                        hintText: "Rt (optional)",
                        optional: true,
                      ),
                    ),
                    SizedBox(width: kSizeMS),
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: bloc.rwController,
                        title: "Rw",
                        hintText: "Rw (optional)",
                        optional: true,
                      ),
                    ),
                    SizedBox(width: kSizeMS),
                    Expanded(
                      flex: 3,
                      child: TextFormFieldWidget(
                        controller: bloc.detailAddressController,
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
