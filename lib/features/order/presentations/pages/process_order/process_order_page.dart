import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/core.dart';
import '../../../../../core/widgets/form/text_form_field_widget.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/enums/order_status.dart';
import '../../bloc/order_process/order_process_bloc.dart';
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
                        Container(
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
                              return GestureDetector(
                                onTap: () {
                                  onClickDetail(order, index, true);
                                },
                                child: CustomCard(
                                  margin: anchorBottomContent,
                                  border:
                                      isDetail && activeIndex == index
                                          ? Border.all(
                                            color: primaryColor,
                                            width: 1,
                                          )
                                          : null,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    kSizeMS,
                                                  ),
                                              child: Image.network(
                                                "https://cms.disway.id//uploads/0a89f2c48130e61ec0621d8bdd2d6b74.jpeg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: kSizeMS),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  order.client.name,
                                                  style: context
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                Text(
                                                  "Order #${order.id.replaceAll("-", "").substring(1, 10).toUpperCase()}",
                                                  style: context
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: greyColor,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: kSizeM),
                                          TextBadgeWidget(
                                            text: order.orderStatus.name,
                                            color: order.orderStatus.color,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: kSizeM),
                                      Text(order.createdAtDisplay),
                                      SizedBox(height: kSizeS),
                                      DottedLine(dashColor: lightGrey4),
                                      SizedBox(height: kSizeS),
                                      Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(2),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(1),
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                ),
                                                child: Text(
                                                  "Produk",
                                                  style: context
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                ),
                                                child: Text(
                                                  "Quantity",
                                                  style: context
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                ),
                                                child: Text(
                                                  "Total",
                                                  style: context
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ...List.generate(order.items.length, (
                                            index,
                                          ) {
                                            final item = order.items[index];
                                            return TableRow(
                                              children: [
                                                Container(
                                                  margin: anchorRightContent,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                  ),
                                                  child: Text(
                                                    item.title,
                                                    style:
                                                        context
                                                            .textTheme
                                                            .labelSmall,
                                                  ),
                                                ),
                                                Container(
                                                  margin: anchorRightContent,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                  ),
                                                  child: Text(
                                                    item.quantity.toString(),
                                                    style:
                                                        context
                                                            .textTheme
                                                            .labelSmall,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                  ),
                                                  child: Text(
                                                    item.totalPriceString,
                                                    style:
                                                        context
                                                            .textTheme
                                                            .labelSmall,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
                                      SizedBox(height: kSizeS),
                                      DottedLine(dashColor: lightGrey4),
                                      SizedBox(height: kSizeS),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Ongkos kirim",
                                            style: context.textTheme.labelSmall
                                                ?.copyWith(color: greyColor),
                                          ),
                                          Text(
                                            order.shippingCostString,
                                            style: context.textTheme.labelSmall
                                                ?.copyWith(color: greyColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: kSizeS),
                                      DottedLine(dashColor: lightGrey4),
                                      SizedBox(height: kSizeS),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            order.totalPriceString,
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: kSizeM),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex:
                                                order.orderStatus.isprocess
                                                    ? 2
                                                    : 4,
                                            child: GradientButton(
                                              onPressed: () {
                                                context
                                                    .read<OrderProcessBloc>()
                                                    .add(
                                                      ShowInvoiceOrder(
                                                        order: order,
                                                      ),
                                                    );
                                              },
                                              isGradient: true,
                                              child: Text("Invoice"),
                                            ),
                                          ),
                                          SizedBox(width: kSizeSS),
                                          if (order.orderStatus.iswaiting) ...[
                                            Expanded(
                                              child: GradientButton(
                                                onPressed: () {},
                                                child: Icon(
                                                  CupertinoIcons.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                          // if (order.orderStatus.isprocess) ...[
                                          //   Expanded(
                                          //     child: GradientButton(
                                          //       onPressed: () {},
                                          //       backgroundColor:
                                          //           successButtonColor,
                                          //       child: Text("Done"),
                                          //     ),
                                          //   ),
                                          // ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
