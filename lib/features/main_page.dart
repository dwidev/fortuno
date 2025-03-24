// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fortuno/features/order/presentations/pages/process_order/process_order_page.dart';

import '../core/constants/images_assets.dart';
import '../core/core.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(navigationShell: navigationShell),
            Expanded(child: navigationShell),
          ],
        ),
      ),
    );
  }
}

class SideMenu extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const SideMenu({super.key, required this.navigationShell});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var activeIndex = 0;

  final icon = [
    [CupertinoIcons.chart_bar_alt_fill, "Dashboard"],
    [CupertinoIcons.bag_fill, "Buat Order"],
    [CupertinoIcons.cart_fill, "Orders"],
    [CupertinoIcons.money_dollar_circle_fill, "Payment"],
    [CupertinoIcons.cube_box_fill, "Inventaris"],
  ];

  final iconOther = [
    [CupertinoIcons.bell_circle_fill, "Notifikasi"],
    [CupertinoIcons.settings_solid, "Pengaturan"],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 5.5,
      height: context.height,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: lightGrey6, width: 2)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: kSizeMS,
                vertical: kSizeXL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kSizeXL),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: lightGrey6,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          CupertinoIcons.bag,
                          size: kSizeM,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(width: kSizeS),
                      Text(
                        "FortunoPOS",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kSizeL),
                  ...List.generate(icon.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        if (activeIndex == index) return;

                        if (index == 2) {
                          context.go(ProcessOrderPage.path, extra: UniqueKey());
                        } else {
                          widget.navigationShell.goBranch(
                            index,
                            initialLocation: true,
                          );
                        }

                        setState(() {
                          activeIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: kSizeS - 10),
                        padding: EdgeInsets.symmetric(
                          horizontal: kSizeM,
                          vertical: kSizeM,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              index == activeIndex
                                  ? primaryColor
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(kDefaultRadius),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              icon[index][0] as IconData,
                              size: kSizeM,
                              color:
                                  index == activeIndex ? darkColor : greyColor,
                            ),
                            SizedBox(width: kSizeS),
                            Expanded(
                              child: Text(
                                icon[index][1] as String,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (index == 2 && index != activeIndex)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(
                                    kDefaultRadius * 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text("2", textAlign: TextAlign.center),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: kSizeL),
                  Padding(
                    padding: EdgeInsets.only(left: kSizeM),
                    child: Text(
                      "Lainnya",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: greyColor,
                      ),
                    ),
                  ),
                  ...List.generate(iconOther.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(top: kSizeS - 10),
                      padding: EdgeInsets.symmetric(
                        horizontal: kSizeM,
                        vertical: kSizeM,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(kDefaultRadius),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            iconOther[index][0] as IconData,
                            size: kSizeM,
                            color: greyColor,
                          ),
                          SizedBox(width: kSizeS),
                          Text(
                            iconOther[index][1] as String,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: kSizeM,
                horizontal: kSizeM,
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: kSizeS,
                vertical: kSizeS,
              ).copyWith(top: 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [whiteColor, darkLightColor],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(kSizeM),
                boxShadow: defaultShadow,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    minRadius: 35,
                    backgroundImage: AssetImage(logo),
                  ),
                  SizedBox(height: kSizeM),
                  Text(
                    "RM Barokah Catering",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: kSizeMS),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Fahmi dwi",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: greyColor,
                        ),
                      ),
                      SizedBox(width: kSizeMS),
                      CircleAvatar(backgroundColor: greenColor, minRadius: 5),
                    ],
                  ),
                  SizedBox(height: kSizeMS),
                  ElevatedButton(onPressed: () {}, child: Text("Open Profile")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
