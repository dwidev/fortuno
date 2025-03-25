import 'package:fortuno/core/core.dart';

class CartDetailsViewPageHeader extends StatelessWidget {
  const CartDetailsViewPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: anchorCustomAppBar.min(0, left: anchorAllContent.left),
      child: Text(
        "Rincian pesanan",
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
