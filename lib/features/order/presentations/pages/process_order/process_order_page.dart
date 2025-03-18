import 'dart:math';

import '../../../domain/entities/order.dart';
import '../../bloc/order_process/order_process_bloc.dart';
import 'detail_process_order_page.dart';

import '../../../../../core/core.dart';
import '../../../domain/enums/order_status.dart';
import '../../widgets/order_process_item_list_widget.dart';

class ProcessOrderPage extends StatefulWidget {
  static String path = '/process-order';

  const ProcessOrderPage({super.key});

  @override
  State<ProcessOrderPage> createState() => _ProcessOrderPageState();
}

class _ProcessOrderPageState extends State<ProcessOrderPage>
    with TickerProviderStateMixin {
  final tabHeader = [
    OrderStatus.waiting,
    OrderStatus.process,
    OrderStatus.done,
    OrderStatus.cancel,
  ];

  late TabController tabController;
  var isDetail = false;
  int? activeIndex;
  late AnimationController animationController;
  Animation<double>? widthAnimation;
  double witdhDetail = 0;

  double get maxWidthDetail => context.width / 1.7;

  @override
  void initState() {
    context.read<OrderProcessBloc>().add(OnGetOrders());
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
      final wAnimation = widthAnimation;
      if (wAnimation == null) return;

      setState(() {
        if (wAnimation.value > 500) {
          isDetail = true;
        } else {
          isDetail = false;
        }
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final curve = CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      );
      widthAnimation = Tween(begin: 0.0, end: maxWidthDetail).animate(curve);
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void onClickDetail(Order? order, int index, bool isOpen) {
    setState(() {
      activeIndex = index;
    });

    if (isOpen && order != null) {
      context.read<OrderProcessBloc>().add(GoToOrderDetails(order: order));
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseListenerWidget<OrderProcessBloc, OrderProcessState>(
      builder: (context, bloc, state) {
        final total = (state as OrderProcessState).orders.length;
        return Scaffold(
          backgroundColor: darkLightColor,
          body: Padding(
            padding: EdgeInsets.only(top: context.padTop),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TabBar(
                        indicatorWeight: 10,
                        controller: tabController,
                        isScrollable: true,
                        tabs:
                            tabHeader
                                .map(
                                  (i) => Container(
                                    padding: EdgeInsets.all(kDefaultPadding),
                                    child: Text(i.tabValue(total.toString())),
                                  ),
                                )
                                .toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: List.generate(5, (index) {
                            return BlocBuilder<
                              OrderProcessBloc,
                              OrderProcessState
                            >(
                              builder: (context, state) {
                                return ListView.builder(
                                  itemCount: state.orders.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return OrderProcessItemListWidget(
                                      order: state.orders[index],
                                      index: index,
                                      activeIndex: activeIndex ?? 0,
                                      isDetail: isDetail,
                                      onClickDetail: (order) {
                                        onClickDetail(order, index, true);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widthAnimation != null)
                  DetailProcessOrderPage(
                    widthAnimation: widthAnimation,
                    maxWidthDetail: maxWidthDetail,
                    onClosePage: () {
                      onClickDetail(null, -1, false);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
