import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../core/core.dart';
import '../../../../../core/depedency_injection/injection.dart';
import '../../../../products/domain/entities/category.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_processing_bloc.dart';
import '../../bloc/order/order_bloc.dart';
import '../process_order_page.dart';
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
    final cartBloc = context.read<CartBloc>();
    if (cartBloc.state.items.isEmpty) {
      EasyLoading.instance
        ..maskColor = Colors.amber
        ..backgroundColor = Colors.red
        ..toastPosition = EasyLoadingToastPosition.bottom;
      EasyLoading.showToast(
        "Silahkan pilih salah satu produk/package!!!",
        dismissOnTap: true,
        duration: 1.seconds,
      );
      return;
    }

    final cartProcess = context.read<CartProcessingBloc>();
    if (cartProcess.formKey.currentState?.validate() == false) return;

    if (tabController.index == 0) {
      final orderBloc = context.read<OrderBloc>();
      orderBloc.add(OnFinishSelectedProduct(isFinish: true));

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

  void onBack() {
    final orderBloc = context.read<OrderBloc>();
    orderBloc.add(OnFinishSelectedProduct(isFinish: false));

    setState(() {
      tabController.index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) {
        final ok = previous.items != current.items || current.items.isEmpty;
        return ok;
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
                  child: CartCreateOrderViewPage(onBack: onBack),
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
