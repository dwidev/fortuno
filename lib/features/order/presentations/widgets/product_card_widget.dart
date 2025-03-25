import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/core.dart';
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
      child: CustomCard(
        padding: anchorAllContent.min(10),
        constraints: BoxConstraints(minHeight: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSizeMS),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kSizeMS),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        isFinish ? Colors.grey : Colors.transparent,
                        isFinish ? BlendMode.saturation : BlendMode.dst,
                      ),
                      child: Image.network(
                        "https://cms.disway.id//uploads/0a89f2c48130e61ec0621d8bdd2d6b74.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (quantity != 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          quantity != 0
                              ? Text(
                                "x$quantity",
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              )
                              : Icon(
                                CupertinoIcons.add_circled_solid,
                                color: whiteColor,
                              ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: kSizeM),
            Container(
              padding: EdgeInsets.only(left: kSizeSS, right: kSizeSS),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          product.name,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product.price > 0)
                          Text(
                            product.priceFormated,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (quantity != 0) ...[
                    SizedBox(width: kSizeMS),
                    Container(
                      padding: EdgeInsets.all(kSizeS),
                      decoration: BoxDecoration(
                        color:
                            isFinish ? disabledButtonColor : deleteButtonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(CupertinoIcons.delete, color: whiteColor),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: kSizeS),
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
