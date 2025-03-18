import '../../../../../core/core.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/enums/order_status.dart';
import '../../bloc/order_process/order_process_bloc.dart';
import '../../widgets/order_process_item_list_widget.dart';
import 'detail_process_order_page.dart';

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

  final detailShowDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();

    context.read<OrderProcessBloc>().add(
      OnGetOrders(status: OrderStatus.waiting),
    );

    tabController = TabController(
      length: tabHeader.length,
      vsync: this,
      animationDuration: detailShowDuration,
    );

    animationController = AnimationController(
      vsync: this,
      duration: detailShowDuration,
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
    animationController.dispose();
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

  void onChangeTab(int index) {
    final bloc = context.read<OrderProcessBloc>();
    if (index == 0) {
      bloc.add(OnGetOrders(status: OrderStatus.waiting));
      return;
    }

    if (index == 1) {
      bloc.add(OnGetOrders(status: OrderStatus.process));
      return;
    }

    if (index == 2) {
      bloc.add(OnGetOrders(status: OrderStatus.done));
      return;
    }

    if (index == 3) {
      bloc.add(OnGetOrders(status: OrderStatus.cancel));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseListenerWidget<OrderProcessBloc, OrderProcessState>(
      listener: (context, state) {
        if (isDetail) {
          Future.delayed(
            detailShowDuration,
            () => animationController.reverse(),
          );
        }
      },
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
                        onTap: onChangeTab,
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: List.generate(tabHeader.length, (index) {
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
                                      activeIndex: activeIndex ?? -1,
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
                if (widthAnimation != null && activeIndex != -1)
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
