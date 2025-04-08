import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/core.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/order/order_bloc.dart';
import 'package_card_widget.dart';

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

            return PackageCardWidget(
              package: package,
              quantity: quantity,
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
              disable: state.finishSelected,
            );
          },
        );
      },
    );
  }
}
