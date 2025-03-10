import '../../../core/core.dart';
import '../../../core/widgets/form/date_form_picker_widget.dart';
import '../../../core/widgets/form/text_form_field_widget.dart';
import '../../../core/widgets/form/time_form_picker_widget.dart';
import '../widgets/order_item_widget.dart';

class OrderDetailsViewPage extends StatelessWidget {
  const OrderDetailsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rincian pesanan",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: mustardYellow,
            ),
          ),
          SizedBox(height: kSizeMS),
          Divider(),
          ...List.generate(3, (index) => OrderItemWidget()),
          SizedBox(height: kSizeMS * 1.5),
          Text(
            "Data Pemesan",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: mustardYellow,
            ),
          ),
          SizedBox(height: kSizeMS),
          Divider(),
          SizedBox(height: kSizeMS),
          TextFormFieldWidget(title: "Nama pemesan"),
          SizedBox(height: kSizeM),
          Row(
            children: [
              Expanded(child: DateFormPickerWidget(title: "Tanggal kirim")),
              SizedBox(width: kSizeMS),
              Expanded(child: TimeFormPickerWidget(title: "Jam kirm")),
            ],
          ),
          SizedBox(height: kSizeM),
          TextFormFieldWidget(title: "Alamat", maxLines: 3),
          SizedBox(height: kSizeM),
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  title: "Rw",
                  hintText: "Rw (optional)",
                ),
              ),
              SizedBox(width: kSizeMS),
              Expanded(
                child: TextFormFieldWidget(
                  title: "Rt",
                  hintText: "Rt (optional)",
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
    );
  }
}
