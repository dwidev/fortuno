import '../../../../core/core.dart';
import '../widgets/order_action_widget.dart';
import '../widgets/order_package_widget.dart';
import '../widgets/process_order_dialog.dart';
import 'cart/cart_create_order_view_page.dart';

class ProcessOrderPage extends StatefulWidget {
  static String path = '/process-order';

  const ProcessOrderPage({super.key});

  @override
  State<ProcessOrderPage> createState() => _ProcessOrderPageState();
}

class _ProcessOrderPageState extends State<ProcessOrderPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  var isDetail = false;
  int? activeIndex;
  late AnimationController animationController;
  Animation<double>? widthAnimation;
  double witdhDetail = 0;

  double get maxWidthDetail => context.width / 1.7;

  @override
  void initState() {
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

  void onClickDetail(int index, bool isOpen) {
    setState(() {
      activeIndex = index;
    });

    if (isOpen) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        ["semua", "menunggu (1)", "proses", "selesai", "batal"]
                            .map(
                              (i) => Container(
                                padding: EdgeInsets.all(kDefaultPadding),
                                child: Text(i),
                              ),
                            )
                            .toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: List.generate(5, (index) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(
                                kDefaultPadding,
                              ).copyWith(bottom: 0),
                              child: Material(
                                borderRadius: BorderRadius.circular(
                                  kDefaultRadius,
                                ),
                                color:
                                    isDetail && index == activeIndex
                                        ? lemonChiffonColor
                                        : whiteColor,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                    kDefaultRadius,
                                  ),
                                  onTap: () {
                                    onClickDetail(index, true);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(kDefaultPadding),
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "SMK Adi sanggoro",
                                                  style: context
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                SizedBox(height: kSizeS),
                                                Text(
                                                  "Dikirim : 20 Februari 2025 10:00 WIB",
                                                ),
                                                Text("Total : Rp 200.000"),
                                              ],
                                            ),
                                            SizedBox(width: kSizeXXL),
                                            if (!isDetail) OrderPackageWidget(),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "14:03",
                                              style: context.textTheme.bodyLarge
                                                  ?.copyWith(
                                                    color: darkColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: kSizeS),
                                            if (!isDetail) OrderActionWidget(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
              AnimatedBuilder(
                animation: widthAnimation!,
                builder: (context, _) {
                  final wAnimation = widthAnimation;
                  if (wAnimation == null) {
                    return Offstage();
                  }

                  return SizedBox(
                    height: context.height,
                    width: wAnimation.value,
                    child: Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      color: whiteColor,
                      child:
                          wAnimation.value >= maxWidthDetail
                              ? Stack(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "SMK Adi sanggoro",
                                            style: context.textTheme.titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              onClickDetail(-1, false);
                                            },
                                            icon: Icon(
                                              CupertinoIcons.clear,
                                              size: kSizeL,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CartCreateOrderViewPage(
                                                onBack: () {},
                                                viewOnly: true,
                                              ),
                                              SizedBox(height: kSizeXL),
                                              Row(
                                                children: [
                                                  ImagePreviewWidget(
                                                    title: "Bukti Dp",
                                                  ),
                                                  SizedBox(width: kSizeM),
                                                  ImagePreviewWidget(
                                                    title: "Bukti Pelunasan",
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Row(
                                      children: [
                                        GradientButton(
                                          height: 35,
                                          width: 130,
                                          onPressed: () {
                                            showProcessDialog(
                                              context: context,
                                              onSwipe: () {
                                                context.pop();
                                              },
                                            );
                                          },
                                          child: Text("Proses"),
                                        ),
                                        SizedBox(width: kSizeS),
                                        OrderActionWidget(),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              : Offstage(),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
