import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/features/order/presentations/bloc/order_bloc.dart';
import 'package:fortuno/features/order/presentations/pages/process_order_page.dart';

import '../../../products/domain/entities/category.dart';
import '../widgets/order_listener_widget.dart';
import 'order_details_view_page.dart';
import 'payment_details_view_page.dart';

class CreateOrderPage extends StatefulWidget {
  static const path = '/create-order';

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
    context.read<OrderBloc>().add(OnInitOrderPageEvent());
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
      builder: (context, orderBloc) {
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
                    Container(
                      padding: EdgeInsets.all(
                        kDefaultPadding,
                      ).copyWith(top: kDefaultPadding * 2),
                      child: Text(
                        "RM Barokah Catering",
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                          if (state.categories.isEmpty) {
                            return Offstage();
                          }

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                            itemCount: state.categories.length,
                            padding: EdgeInsets.all(kDefaultPadding),
                            itemBuilder: (context, index) {
                              final product = state.categories[index];
                              return ProductWidget(product: product);
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

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://cms.disway.id//uploads/0a89f2c48130e61ec0621d8bdd2d6b74.jpeg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: kSizeS * 0.5,
                  right: kSizeS * 0.5,
                  child: Container(
                    padding: EdgeInsets.all(kSizeS * 0.5),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      product.price.toString(),
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: darkOliveGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  product.name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: darkOliveGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
