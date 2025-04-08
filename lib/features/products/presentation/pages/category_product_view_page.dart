import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../domain/enums/inventory_type.dart';
import '../../domain/usecases/activate_data.dart';

import '../../../../core/core.dart';
import '../../../order/presentations/widgets/loading_product_widget.dart';
import '../../../order/presentations/widgets/product_card_widget.dart';
import '../bloc/product_bloc.dart';
import '../widgets/add_inventory_widget.dart';
import 'add_category_product_page.dart';

class CategoryProductViewPage extends StatelessWidget {
  const CategoryProductViewPage({super.key});

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
              return AddInventoryWidget(
                onTap: () {
                  context.pushNamed(AddCategoryProductPage.path);
                },
              );
            }
            final category = state.categories[index - 1];
            return ProductCardWidget.inventory(
              product: category,
              onTap: () {
                context.pushNamed(AddCategoryProductPage.path);
              },
              onDelete: (id) {
                context.read<ProductsBloc>().add(OnDeleteCategory(id: id));
              },
              onActivate: (value, id) {
                final params = ActivateDataParams(
                  id: id,
                  value: value,
                  type: InventoryType.category,
                );
                context.read<ProductsBloc>().add(OnActivateData(params));
              },
            );
          },
        );
      },
    );
  }
}
