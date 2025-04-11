import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/core.dart';
import '../../../../../core/widgets/form/text_form_field_widget.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/enums/order_status.dart';
import '../../bloc/order_process/order_process_bloc.dart';
import '../../widgets/process_order_card_widget.dart';
import 'detail_process_order_page.dart';

class ProcessOrderPage extends StatefulWidget {
  static String path = '/process-order';

  const ProcessOrderPage({super.key});

  @override
  State<ProcessOrderPage> createState() => _ProcessOrderPageState();
}

class _ProcessOrderPageState extends State<ProcessOrderPage>
    with TickerProviderStateMixin {
  var activeMenu = 0;
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

  double get maxWidthDetail => context.width / 3.5;

  final detailShowDuration = 200.ms;

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
        if (wAnimation.value > 200) {
          isDetail = true;
        } else {
          isDetail = false;
        }
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final curve = CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
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

  void closeDetail() => onClickDetail(null, -1, false);

  void onChangeTab(int index) {
    setState(() {
      activeMenu = index;
    });

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
        if (isDetail && tabController.indexIsChanging && state.loading.active) {
          Future.delayed(
            detailShowDuration,
            () => animationController.reverse(),
          );
        }
      },
      builder: (context, bloc, state) {
        final total = (state as OrderProcessState).orders.length;
        return Scaffold(
          body: Column(
            children: [
              /// APP BAR
              Container(
                margin: anchorCustomAppBar.addTopHeightMenubar(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Orders",
                            style: context.textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          width: context.width / 3,
                          child: TextFormFieldWidget(
                            title: "",
                            controller: TextEditingController(),
                            hintText:
                                "Cari berdasarkan nama, order, atau lainnya",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kSizeSS),
                    CustomTab(
                      currentIndex: activeMenu,
                      menus: ["Menunggu", "Proses", "Selesai", "Batal"],
                      changeMenu: (index) {
                        onChangeTab(index);
                      },
                    ),
                  ],
                ),
              ),

              /// ORDER CONTENT
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: BlocBuilder<OrderProcessBloc, OrderProcessState>(
                        builder: (context, state) {
                          return MasonryGridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                            crossAxisSpacing: kSizeMS,
                            itemCount: total,
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isDetail ? 2 : 3,
                                ),
                            itemBuilder: (context, index) {
                              final order = state.orders[index];
                              return ProcessOrderCardWidget(
                                onTap: (order) {
                                  onClickDetail(order, index, true);
                                },
                                onClickInvoice: (order) {
                                  context.read<OrderProcessBloc>().add(
                                    ShowInvoiceOrder(order: order),
                                  );
                                },
                                isClick: isDetail && activeIndex == index,
                                order: order,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: 300.ms,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: switch (isDetail && activeIndex != -1) {
                        true => DetailProcessOrderPage(
                          widthAnimation: widthAnimation,
                          maxWidthDetail: maxWidthDetail,
                          onClosePage: closeDetail,
                        ),
                        _ => Offstage(),
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
