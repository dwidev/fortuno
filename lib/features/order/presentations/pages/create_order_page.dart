import 'package:fortuno/features/order/presentations/bloc/cart/cart_bloc.dart';
import 'package:fortuno/features/order/presentations/pages/cart/cart_order_page.dart';

import '../../../../core/core.dart';
import '../bloc/order/order_bloc.dart';
import '../widgets/header_create_order_widget.dart';
import '../widgets/loading_product_widget.dart';
import '../widgets/order_listener_widget.dart';
import '../widgets/package_list_widget.dart';
import '../widgets/product_card_widget.dart';

class CreateOrderPage extends StatefulWidget {
  static const path = '/create-order';

  static const crossMaxItem = 5;

  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  void initState() {
    print("INIT LAGI GA");
    super.initState();
    context.read<OrderBloc>().add(
      OnInitOrderPageEvent(companyId: "898a70b4-0758-4eda-bf73-b469db14eb50"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrderListenerWidget(
      builder: (context, orderBloc, state) {
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER APP
                  HeaderCreateOrderWidget(),

                  /// PACKAGE LIST
                  PackageListWidget(),

                  SizedBox(height: kSizeS),

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

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ).copyWith(top: kSizeS),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: CreateOrderPage.crossMaxItem,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  childAspectRatio: 0.85,
                                ),
                            itemCount: itemCount,
                            // padding: EdgeInsets.all(kDefaultPadding),
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
                                    final cp = state.categories[index];
                                    orderBloc.add(
                                      OnClickCategory(categoryProduct: cp),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 2, child: CartOrderPage.init()),
          ],
        );
      },
    );
  }
}
