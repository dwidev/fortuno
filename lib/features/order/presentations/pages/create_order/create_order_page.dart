import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../bloc/cart/cart_bloc.dart';
import 'cart/cart_order_page.dart';

import '../../../../../core/core.dart';
import '../../bloc/order/order_bloc.dart';
import '../../widgets/header_create_order_widget.dart';
import '../../widgets/loading_product_widget.dart';
import '../../widgets/order_listener_widget.dart';
import '../../widgets/package_list_widget.dart';
import '../../widgets/product_card_widget.dart';

class CreateOrderPage extends StatefulWidget {
  static const path = '/create-order';

  static const crossMaxItem = 4;

  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  var activeMenu = '';
  var menus = ["Package", "Product"];

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(
      OnInitOrderPageEvent(companyId: "898a70b4-0758-4eda-bf73-b469db14eb50"),
    );
  }

  void changeMenu(String menu) {
    setState(() {
      activeMenu = menu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrderListenerWidget(
      builder: (context, orderBloc, state) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER APP
                  HeaderCreateOrderWidget(),

                  if (state is AtProductPage)
                    Padding(
                      padding: EdgeInsets.only(
                        left: kDefaultPadding,
                        bottom: kSizeS,
                      ),
                      child: Row(
                        children:
                            menus
                                .map(
                                  (e) => TextButton(
                                    onPressed: () => changeMenu(e),
                                    child: Text(
                                      e,
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                e == activeMenu
                                                    ? darkColor
                                                    : lightGrey1,
                                          ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),

                  if (activeMenu == "Package" && state is AtProductPage)
                    /// PACKAGE LIST
                    Expanded(child: PackageListWidget()),

                  if (activeMenu == "Product" || state is! AtProductPage)
                    /// CATEGORY & PRODUCT LIST
                    Expanded(
                      child: BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                          if (state.loading.active) {
                            return LoadingProductWidget();
                          }

                          if (state.categories.isEmpty) {
                            return Offstage();
                          }

                          var itemCount = 0;

                          if (state is AtProductPage) {
                            itemCount = state.products.length;
                          } else {
                            itemCount = state.categories.length;
                          }

                          return MasonryGridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                            crossAxisSpacing: kSizeMS,
                            mainAxisSpacing: kSizeMS,
                            itemCount: itemCount,
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: CreateOrderPage.crossMaxItem,
                                ),
                            itemBuilder: (context, index) {
                              final cp =
                                  state is AtProductPage
                                      ? state.products[index]
                                      : state.categories[index];

                              var quantity = 0;
                              if (state is AtProductPage) {
                                quantity = state.productCountCart[cp.id] ?? 0;
                              }

                              return ProductCardWidget(
                                product: cp,
                                quantity: quantity,
                                onTap: () {
                                  if (state is AtProductPage) {
                                    context.read<CartBloc>().add(
                                      AddProductToCartEvent(
                                        categoryProduct: state.categoryProduct,
                                        product: cp,
                                        quantity: quantity + 1,
                                      ),
                                    );
                                  } else {
                                    changeMenu("Package");
                                    final cp = state.categories[index];
                                    orderBloc.add(
                                      OnClickCategory(categoryProduct: cp),
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: kSizeL),
            Expanded(child: CartOrderPage.init()),
          ],
        );
      },
    );
  }
}
