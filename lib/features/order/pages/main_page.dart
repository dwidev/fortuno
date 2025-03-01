import '../../../core/core.dart';
import 'order_details_view_page.dart';
import 'payment_details_view_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(top: kDefaultPadding),
              height: double.infinity,
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
                          child: Container(
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
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "Paket Berkah",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
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
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              color: Colors.white,
              child: Stack(
                children: [
                  DefaultTabController(
                    length: 2,
                    child: TabBarView(
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
                          child: PaymentDetailsViewsPage(),
                        ),
                      ],
                    ),
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
                          onPressed: () {},
                          height: kSizeXXL,
                          child: Text(
                            "Proses Order",
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
            ),
          ),
        ],
      ),
    );
  }
}
