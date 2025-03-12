// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/features/order/presentations/pages/cart/order_cart_page.dart';

import 'package:fortuno/features/products/domain/entities/package.dart';

import '../../../../core/core.dart';
import '../bloc/order_bloc.dart';
import '../widgets/header_create_order_widget.dart';
import '../widgets/loading_product_widget.dart';
import '../widgets/order_listener_widget.dart';
import '../widgets/package_list_widget.dart';
import '../widgets/product_card_widget.dart';
import 'cart/order_details_view_page.dart';
import 'cart/payment_details_view_page.dart';
import 'process_order_page.dart';

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
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: kSizeM,
                  horizontal: kSizeML,
                ),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER APP
                    HeaderCreateOrderWidget(),

                    /// PACKAGE LIST
                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        if (state is AtProductPage) {
                          return PackageListWidget(packages: state.packages);
                        }

                        return Offstage();
                      },
                    ),

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

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: CreateOrderPage.crossMaxItem,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.8,
                                ),
                            itemCount: itemCount,
                            padding: EdgeInsets.all(kDefaultPadding),
                            itemBuilder: (context, index) {
                              final cp =
                                  state is AtProductPage
                                      ? state.products[index]
                                      : state.categories[index];
                              return ProductCardWidget(
                                product: cp,
                                onTap: () {
                                  if (state is AtProductPage) {
                                  } else {
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
            ),
            Expanded(flex: 2, child: CartOrderPage()),
          ],
        );
      },
    );
  }
}
