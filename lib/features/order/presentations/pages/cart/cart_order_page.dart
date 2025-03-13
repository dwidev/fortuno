import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/features/order/presentations/bloc/cart/cart_bloc.dart';
import 'package:fortuno/features/order/presentations/bloc/order/order_bloc.dart';
import 'package:fortuno/features/products/domain/entities/category.dart';

import '../../../../../core/core.dart';
import '../process_order_page.dart';
import 'cart_create_order_view_page.dart';
import 'cart_details_views_page.dart';

class CartOrderPage extends StatefulWidget {
  final CategoryProduct? categoryProduct;

  const CartOrderPage({super.key, this.categoryProduct});

  @override
  State<CartOrderPage> createState() => _CartOrderPageState();
}

class _CartOrderPageState extends State<CartOrderPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) {
        return previous.items != current.items;
      },
      listener: (context, state) {
        if (state is AddedToCart && state.newItem != null) {
          final id = state.newItem!.id;
          final quantity = state.newItem!.quantity;
          context.read<OrderBloc>().add(OnAddQuantity(id, quantity));
        }
      },
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
                  child: CartDetailsViewPage(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding * 2,
                    horizontal: kDefaultPadding,
                  ),
                  child: CartCreateOrderViewPage(
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
    );
  }
}
