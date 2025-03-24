import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/core.dart';
import '../../../products/domain/entities/category.dart';
import '../../../products/domain/entities/product.dart';
import '../bloc/order/order_bloc.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
    this.quantity = 0,
    required this.onTap,
  });

  final int quantity;
  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isFinish = context.select<OrderBloc, bool>((value) {
      return value.state.finishSelected;
    });

    return GestureDetector(
      onTap:
          !isFinish
              ? onTap
              : () {
                EasyLoading.showToast(
                  "Silahkan kembali kemenu Rincian pesanan",
                );
              },
      child: Container(
        constraints: BoxConstraints(minHeight: 100),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(kDefaultRadius),
          boxShadow: defaultShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(kSizeS),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSizeMS),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kSizeMS),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        isFinish ? Colors.grey : Colors.transparent,
                        isFinish
                            ? BlendMode.saturation
                            : BlendMode.dst, // Menurunkan saturasi warna
                      ),
                      child: Image.network(
                        "https://cms.disway.id//uploads/0a89f2c48130e61ec0621d8bdd2d6b74.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (((product is CategoryProduct) &&
                        !(product as CategoryProduct).haveProduct) ||
                    product.price > 0 ||
                    quantity != 0)
                  Positioned(
                    top: kSizeS * 0.5,
                    right: kSizeS * 0.5,
                    child: Container(
                      padding: EdgeInsets.all(kSizeS * 0.5),
                      decoration: BoxDecoration(
                        color: quantity != 0 ? darkOliveGreen : whiteColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        quantity != 0 ? "x$quantity" : product.displayPrice,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: quantity != 0 ? whiteColor : darkOliveGreen,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(kSizeS * 0.3),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: darkOliveGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(kDefaultRadius - 2),
            //     color: darkColor.withAlpha(150),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
