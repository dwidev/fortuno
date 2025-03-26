import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/core.dart';
import '../../../order/presentations/widgets/loading_product_widget.dart';
import '../../../order/presentations/widgets/product_card_widget.dart';
import '../bloc/product_bloc.dart';
import '../widgets/add_inventory_widget.dart';

class CategoryProductViewPage extends StatefulWidget {
  const CategoryProductViewPage({super.key});

  @override
  State<CategoryProductViewPage> createState() =>
      _CategoryProductViewPageState();
}

class _CategoryProductViewPageState extends State<CategoryProductViewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductState>(
      builder: (context, state) {
        if (state.loading.active) {
          return LoadingProductWidget(crossAxisCount: 5);
        }

        if (state.categories.isEmpty) {
          return Offstage();
        }

        return MasonryGridView.builder(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          crossAxisSpacing: kSizeMS,
          mainAxisSpacing: kSizeMS,
          itemCount: state.categories.length + 1,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return AddInventoryWidget();
            }
            final category = state.categories[index - 1];
            return ProductCardWidget(
              product: category,
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
