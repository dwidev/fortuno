import 'package:fortuno/core/core.dart';

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

    showSuccessDialog(context: context, desc: "");
  }

  @override
  Widget build(BuildContext context) {
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
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: 5,
                    padding: EdgeInsets.all(kDefaultPadding),
                    itemBuilder: (context, index) {
                      return Card(
                        color: primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        kDefaultRadius,
                                      ),
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
                                        "20K",
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: deepGoldenYellow,
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
                                    "Paket Berkah",
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                      color: whiteColor,
                      child: GradientButton(
                        noShadow: true,
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
  }
}
