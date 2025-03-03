import '../../../core/core.dart';
import '../../order/pages/payment_details_view_page.dart';

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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final curve = CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      );
      widthAnimation = Tween(
        begin: 0.0,
        end: context.width / 1.7,
      ).animate(curve);
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void onClickDetail(int index) {
    setState(() {
      isDetail = !isDetail;
      activeIndex = index;
    });

    Future.delayed(Duration(milliseconds: 1), () {
      if (isDetail) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(animationController.value);
    return Scaffold(
      backgroundColor: darkLightColor,
      body: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    indicatorWeight: 10,
                    controller: tabController,
                    tabs: List.generate(
                      4,
                      (i) => Container(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Text("Semua"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: List.generate(4, (index) {
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
                                    onClickDetail(index);
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
                  return SizedBox(
                    width: widthAnimation!.value,
                    child: Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      color: whiteColor,
                      child:
                          !isDetail
                              ? Offstage()
                              : Column(
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
                                          onClickDetail(-1);
                                        },
                                        icon: Icon(
                                          CupertinoIcons.clear,
                                          size: kSizeL,
                                        ),
                                      ),
                                    ],
                                  ),
                                  PaymentDetailsViewsPage(
                                    onBack: () {},
                                    viewOnly: true,
                                  ),
                                ],
                              ),
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

class OrderActionWidget extends StatelessWidget {
  const OrderActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonCircleWidget.gradient(
          icon: CupertinoIcons.printer,
          onPressed: () {},
        ),
        SizedBox(width: kSizeS),
        ButtonCircleWidget.gradient(
          icon: CupertinoIcons.pencil,
          onPressed: () {},
        ),
        SizedBox(width: kSizeS),
        ButtonCircleWidget.gradient(
          icon: CupertinoIcons.trash,
          onPressed: () {},
        ),
      ],
    );
  }
}

class OrderPackageWidget extends StatelessWidget {
  const OrderPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 7,
      padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeS),
      decoration: BoxDecoration(
        color: lemonChiffonColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Paket berkah 20k",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Nasi, Ayam bakar, Tahu, Tempe, Box Kardus coklat + alat makan",
            style: context.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
