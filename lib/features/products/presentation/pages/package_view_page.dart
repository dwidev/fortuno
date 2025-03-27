import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fortuno/features/order/presentations/widgets/package_card_widget.dart';
import 'package:fortuno/features/order/presentations/widgets/package_list_widget.dart';
import 'package:fortuno/features/products/domain/entities/package.dart';

import '../../../../core/core.dart';
import '../../../order/presentations/widgets/loading_product_widget.dart';
import '../../../order/presentations/widgets/product_card_widget.dart';
import '../bloc/product_bloc.dart';
import '../widgets/add_inventory_widget.dart';
import 'add_product_page.dart';

class PackageViewPage extends StatefulWidget {
  const PackageViewPage({super.key});

  @override
  State<PackageViewPage> createState() => _PackageViewPageState();
}

class _PackageViewPageState extends State<PackageViewPage> {
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
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return AddInventoryWidget(
                onTap: () {
                  context.push(AddProductPage.path);
                },
              );
            }
            final category = state.products[index - 1];

            return PackageCardWidget(
              package: Package.dummy(),
              quantity: 0,
              disable: false,
              onTap: () {},
            );
          },
        );
      },
    );
  }
}
