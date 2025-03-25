import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fortuno/features/order/presentations/pages/create_order/cart/cart_create_order_view_page_header.dart';
import 'package:fortuno/features/order/presentations/pages/create_order/cart/cart_details_view_page_header.dart';
import 'package:fortuno/features/order/presentations/widgets/process_cart_order_dialog.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/depedency_injection/injection.dart';
import '../../../../../products/domain/entities/category.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_processing_bloc.dart';
import '../../../bloc/order/order_bloc.dart';
import 'cart_create_order_view_page.dart';
import 'cart_details_views_page.dart';

class CartOrderPage extends StatefulWidget {
  final CategoryProduct? categoryProduct;

  const CartOrderPage({super.key, this.categoryProduct});

  static init({Key? key, CategoryProduct? categoryProduct}) {
    return BlocProvider(
      create: (context) => getIt<CartProcessingBloc>(),
      child: CartOrderPage(key: key, categoryProduct: categoryProduct),
    );
  }

  @override
  State<CartOrderPage> createState() => _CartOrderPageState();
}

class _CartOrderPageState extends State<CartOrderPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  final tabDuration = 300.ms;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: tabDuration,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void onTapOder() {
    final cartBloc = context.read<CartBloc>();
    if (cartBloc.state.items.isEmpty) {
      EasyLoading.showToast(
        "Silahkan pilih salah satu produk/package!!!",
        dismissOnTap: true,
        duration: 1.seconds,
      );
      return;
    }

    final cartProcess = context.read<CartProcessingBloc>();
    // if (cartProcess.formKey.currentState?.validate() == false) return;

    if (tabController.index == 0) {
      final orderBloc = context.read<OrderBloc>();
      orderBloc.add(OnFinishSelectedProduct(isFinish: true));
      cartProcess.add(OnAddOrderItemsEvent(items: cartBloc.state.items));

      setState(() {
        tabController.index += 1;
      });
      return;
    }

    showProcessCartDialog(
      context: context,
      onSwipe: () async {
        context.pop();
        cartProcess.add(OnCreateOrder(order: cartProcess.state.order));
      },
    );
  }

  void onBack() {
    final orderBloc = context.read<OrderBloc>();
    orderBloc.add(OnFinishSelectedProduct(isFinish: false));

    setState(() {
      tabController.index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseListenerWidget<CartBloc, CartState>(
      listenWhen: (previous, current) {
        if (previous is CartState && current is CartState) {
          final ok = (previous).items != current.items || current.items.isEmpty;
          return ok;
        }

        return previous != current;
      },
      listener: (context, state) {
        if (state is AddedToCart && state.newItem != null) {
          final id = state.newItem!.id;
          final quantity = state.newItem!.quantity;
          context.read<OrderBloc>().add(OnAddQuantity(id, quantity));
        }

        if (state is CartInitial) {
          log("RESET ORDER");
          tabController.animateTo(0);
          final orderBloc = context.read<OrderBloc>();
          orderBloc.add(ResetOrder());
        }
      },
      builder: (context, bloc, state) {
        return SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    duration: tabDuration * 1.5,
                    child:
                        tabController.index == 0
                            ? CartDetailsViewPageHeader()
                            : CartCreateOrderViewPageHeader(onBack: onBack),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CartDetailsViewPage(),
                        CartCreateOrderViewPage(),
                      ],
                    ),
                  ),
                ],
              ),
              if (!context.isKeyboardOpen)
                Positioned(
                  bottom: kSizeM,
                  right: kSizeM,
                  left: 0,
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
            ],
          ),
        );
      },
    );
  }
}
