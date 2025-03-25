// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fortuno/core/core.dart';

class CartCreateOrderViewPageHeader extends StatelessWidget {
  const CartCreateOrderViewPageHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: anchorCustomAppBar.min(0, left: anchorAllContent.left),
      child: Row(
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
            ),
          ),
        ],
      ),
    );
  }
}
