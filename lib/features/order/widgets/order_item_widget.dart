import '../../../core/core.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSizeMS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: kSizeXXL * 1.1,
            width: kSizeXXL * 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  "https://asset.kompas.com/crops/WTuA1Jn_cJEFlr9UgBhA-72n8yI=/3x0:700x465/1200x800/data/photo/2020/12/30/5fec5602f116e.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
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
          Row(
            children: [
              ButtonCircleWidget.gradient(
                icon: Icons.remove,
                onPressed: () {},
                buttonSize: kSizeM,
              ),
              SizedBox(width: kSizeMS),
              Column(
                children: [
                  Text(
                    "200",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Pax", style: context.textTheme.bodySmall),
                ],
              ),
              SizedBox(width: kSizeMS),
              ButtonCircleWidget.gradient(
                icon: Icons.add,
                onPressed: () {},
                buttonSize: kSizeM,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
