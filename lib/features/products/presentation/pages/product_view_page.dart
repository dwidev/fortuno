import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/core.dart';
import '../../../order/presentations/widgets/loading_product_widget.dart';
import '../../../order/presentations/widgets/product_card_widget.dart';
import '../bloc/product_bloc.dart';
import '../widgets/add_inventory_widget.dart';
import 'add_product_page.dart';

class ProductViewPage extends StatefulWidget {
  const ProductViewPage({super.key});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductState>(
      builder: (context, state) {
        if (state.loading.active) {
          return LoadingProductWidget(crossAxisCount: 5);
        }

        if (state.products.isEmpty) {
          return Offstage();
        }

        return MasonryGridView.builder(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          crossAxisSpacing: kSizeMS,
          mainAxisSpacing: kSizeMS,
          itemCount: state.products.length + 1,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
          ),
          itemBuilder: (_, index) {
            if (index == 0) {
              return AddInventoryWidget(
                onTap: () {
                  context.pushNamed(AddProductPage.path);
                },
              );
            }

            final product = state.products[index - 1];
            return ProductCardWidget(
              product: product,
              quantity: 0,
              onTap: () {},
              isInventory: true,
            );
          },
        );
      },
    );
  }
}
