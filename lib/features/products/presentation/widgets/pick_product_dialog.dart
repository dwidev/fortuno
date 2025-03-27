import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/core.dart';
import '../../../order/presentations/widgets/product_card_widget.dart';
import '../../domain/entities/product.dart';

class PickProductDialogOpts {
  final String title;

  PickProductDialogOpts({required this.title});
}

Future<T?> showPickProductDialog<T>({
  required BuildContext context,
  required PickProductDialogOpts opts,
}) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(child: _PickProductDialog(opts));
    },
  );
}

class _PickProductDialog extends StatefulWidget {
  const _PickProductDialog(this.opts);
  final PickProductDialogOpts opts;

  @override
  State<_PickProductDialog> createState() => _PickProductDialogState();
}

class _PickProductDialogState extends State<_PickProductDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 1.5,
      // height: context.height / 3,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.opts.title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(CupertinoIcons.clear, size: kSizeM),
                  ),
                ],
              ),
              SizedBox(height: kSizeM),
              Expanded(
                child: MasonryGridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  crossAxisSpacing: kSizeMS,
                  mainAxisSpacing: kSizeMS,
                  itemCount: 25,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCardWidget.picker(
                      product: Product.dummy(),
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: kSizeM,
            child: GradientButton(
              width: 100,
              onPressed: () {},
              child: Text("Pilih"),
            ),
          ),
        ],
      ),
    );
  }
}
