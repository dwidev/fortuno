import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fortuno/features/products/domain/enums/package_type.dart';

import '../../../../core/core.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/order/order_bloc.dart';
import 'package_card_widget.dart';

class PackageListWidget extends StatelessWidget {
  const PackageListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
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
            var quantity = state.productCountCart[package.id] ?? 0;

            return PackageCardWidget(
              package: package,
              quantity: quantity,
              onTap: () async {
                if (state.finishSelected) {
                  EasyLoading.showToast(
                    "Silahkan kembali kemenu Rincian pesanan",
                  );
                  return;
                }
                var custome = false;
                if (package.type == PackageType.custom && quantity == 0) {
                  custome = true;
                  quantity = await showChangeTotalDialog(
                    context: context,
                    initial: 1,
                  );
                }

                bloc.add(
                  AddProductToCartEvent(
                    categoryProduct: state.categoryProduct,
                    package: package,
                    quantity: custome ? quantity : quantity + 1,
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
