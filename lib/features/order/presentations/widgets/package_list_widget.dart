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
    final orderBloc = context.read<OrderBloc>();
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
              onDelete: (id) {
                final cartBloc = context.read<CartBloc>();
                cartBloc.add(RemoveProductFromCart(package: package));
              },
              onChangeContents: (id) {
                orderBloc.add(OnPreparationCustomPackage(package));
              },
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
                  final q = await showChangeTotalDialog(
                    context: context,
                    title: "Masukan jumlah pesan",
                    initial: 0,
                  );

                  if (q == null || q == 0) return;
                  quantity = q;
                  orderBloc.add(OnPreparationCustomPackage(package));
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
