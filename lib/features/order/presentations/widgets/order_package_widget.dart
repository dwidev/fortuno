import 'package:fortuno/core/core.dart';

class OrderPackageWidget extends StatelessWidget {
  const OrderPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 7,
      padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeS),
      decoration: BoxDecoration(
        color: lemonChiffonColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Paket berkah 20k",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Nasi, Ayam bakar, Tahu, Tempe, Box Kardus coklat + alat makan",
            style: context.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
