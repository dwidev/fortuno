import '../../../core/core.dart';
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
          Text(
            "Nama pemesan",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: kSizeMS),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSizeMS),
              color: sunKissedYellowColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: kSizeMS),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Masukan nama pemesan"),
            ),
          ),
          SizedBox(height: kSizeM),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggal kirim",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: kSizeMS),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kSizeMS),
                          color: sunKissedYellowColor,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: kSizeMS),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "DD/MM/YYYY",
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kSizeMS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jam kirim",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: kSizeMS),
                    InkWell(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kSizeMS),
                          color: sunKissedYellowColor,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: kSizeMS),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "00:00 WIB",
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeM),
          Text(
            "Alamat",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: kSizeMS),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSizeMS),
              color: sunKissedYellowColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: kSizeMS),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Masukan alamat pemesan"),
              maxLines: 3,
            ),
          ),
          SizedBox(height: kSizeM),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "RT",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: kSizeMS),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kSizeMS),
                        color: sunKissedYellowColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: kSizeMS),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Rt (optional)"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kSizeMS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "RW",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: kSizeMS),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kSizeMS),
                        color: sunKissedYellowColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: kSizeMS),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Rw (optional)"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kSizeMS),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail lokasi",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: kSizeMS),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kSizeMS),
                        color: sunKissedYellowColor,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: kSizeMS),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Detail lokasi (contoh : dekat warung)",
                        ),
                      ),
                    ),
                  ],
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
