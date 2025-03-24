import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../bloc/order/order_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/cart/cart_bloc.dart';

class PackageListWidget extends StatelessWidget {
  const PackageListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is! AtProductPage) {
          return Offstage();
        }

        final packages = state.packages;
        return MasonryGridView.builder(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          crossAxisSpacing: kSizeMS,
          mainAxisSpacing: kSizeMS,
          itemCount: packages.length,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            final package = packages[index];
            final quantity = state.productCountCart[package.id] ?? 0;

            return GestureDetector(
              onTap: () {
                if (state.finishSelected) {
                  EasyLoading.showToast(
                    "Silahkan kembali kemenu Rincian pesanan",
                  );
                  return;
                }

                context.read<CartBloc>().add(
                  AddProductToCartEvent(
                    categoryProduct: state.categoryProduct,
                    package: package,
                    quantity: quantity + 1,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: state.finishSelected ? darkLightColor : whiteColor,
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                  boxShadow: defaultShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                color: darkLightColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  "https://www.lalamove.com/hubfs/catering%20lunch%20box%20%284%29.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (quantity != 0)
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "x$quantity",
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: kSizeS),
                        Expanded(
                          child: Text(
                            package.name,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kSizeS),
                    Text(
                      package.contents,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: greyColor,
                      ),
                    ),
                    SizedBox(height: kSizeS),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          package.priceFormated,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (quantity != 0)
                          Container(
                            padding: EdgeInsets.all(kSizeS),
                            decoration: BoxDecoration(
                              color: deleteButtonColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              CupertinoIcons.delete,
                              color: whiteColor,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
