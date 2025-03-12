import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/order_bloc.dart';
import '../widgets/header_create_order_widget.dart';
import '../widgets/loading_product_widget.dart';
import '../widgets/order_listener_widget.dart';
import '../widgets/product_card_widget.dart';
import 'order_details_view_page.dart';
import 'payment_details_view_page.dart';
import 'process_order_page.dart';

class CreateOrderPage extends StatefulWidget {
  static const path = '/create-order';

  static const crossMaxItem = 5;

  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    context.read<OrderBloc>().add(
      OnInitOrderPageEvent(companyId: "898a70b4-0758-4eda-bf73-b469db14eb50"),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void onTapOder() {
    if (tabController.index == 0) {
      setState(() {
        tabController.index += 1;
      });
      return;
    }

    showSuccessDialog(
      context: context,
      desc: "Pesanan berhasil dibuat",
      onOke: () {
        context.pop();
        context.go(ProcessOrderPage.path);
        tabController.index = 0;
      },
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
                    HeaderCreateOrderWidget(),
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
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: kDefaultPadding * 2,
                            horizontal: kDefaultPadding,
                          ),
                          child: OrderDetailsViewPage(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: kDefaultPadding * 2,
                            horizontal: kDefaultPadding,
                          ),
                          child: PaymentDetailsViewsPage(
                            onBack: () {
                              setState(() {
                                tabController.index = 0;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    if (!context.isKeyboardOpen)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: kSizeML,
                            horizontal: kSizeML,
                          ),
                          child: GradientButton(
                            onPressed: onTapOder,
                            height: kSizeXXL,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              child: Text(
                                tabController.index == 0
                                    ? "Proses Order"
                                    : "Buat Order",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: darkColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
