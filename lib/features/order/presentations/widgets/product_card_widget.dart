import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/order/order_bloc.dart';
import '../../../products/domain/entities/category.dart';

import '../../../../core/core.dart';
import '../../../products/domain/entities/product.dart';

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
      onTap: !isFinish ? onTap : null,
      child: Card(
        color: darkLightColor,
        child: LayoutBuilder(
          builder: (context, ct) {
            return Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      width: ct.maxWidth,
                      height: ct.maxHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kDefaultRadius - 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kDefaultRadius - 2),
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.dst, // Menurunkan saturasi warna
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
                              color:
                                  quantity != 0 ? whiteColor : darkOliveGreen,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(kSizeS * 0.3),
                          width: constraints.maxWidth / 1.2,
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
                      );
                    },
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(kDefaultRadius - 2),
                //     color: darkColor.withAlpha(150),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
