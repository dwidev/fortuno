import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/core.dart';
import '../../../order/presentations/widgets/loading_product_widget.dart';
import '../../../order/presentations/widgets/package_card_widget.dart';
import '../bloc/product_bloc.dart';
import '../widgets/add_inventory_widget.dart';
import 'add_package_page.dart';

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

        if (state.packages.isEmpty) {
          return Offstage();
        }

        return MasonryGridView.builder(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          crossAxisSpacing: kSizeMS,
          mainAxisSpacing: kSizeMS,
          itemCount: state.packages.length + 1,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return AddInventoryWidget(
                onTap: () {
                  context.pushNamed(AddPackagePage.path);
                },
              );
            }

            final package = state.packages[index - 1];

            return PackageCardWidget(
              package: package,
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
