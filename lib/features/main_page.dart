import 'package:fl_chart/fl_chart.dart';
import 'package:fortuno/core/constants/images_assets.dart';
import 'package:fortuno/features/order/presentations/pages/process_order/process_order_page.dart';

import '../core/core.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: NavigationBar(
      //   destinations: [
      //     NavigationDestination(
      //       icon: Icon(CupertinoIcons.square, size: kSizeL),
      //       label: 'Dashboard',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(CupertinoIcons.uiwindow_split_2x1, size: kSizeL),
      //       label: 'Buat pesanan',
      //     ),
      //     NavigationDestination(
      //       icon: Badge(child: Icon(CupertinoIcons.paperplane, size: kSizeL)),
      //       label: 'Pesanan saya',
      //     ),
      //   ],
      //   onDestinationSelected: (index) {
      //     if (index == 2) {
      //       context.go(ProcessOrderPage.path, extra: UniqueKey());
      //     } else {
      //       navigationShell.goBranch(index, initialLocation: true);
      //     }
      //   },
      //   selectedIndex: navigationShell.currentIndex,
      // ),
      // body: navigationShell,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(icon: icon, iconOther: iconOther),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(kDefaultRadius).copyWith(top: kSizeML),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DashboardAppBar(),
                    Container(
                      height: context.height / 2.5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(kDefaultPadding * 2),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(
                                  kDefaultRadius * 1.5,
                                ),
                                boxShadow: defaultShadow,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Icon(
                                              CupertinoIcons
                                                  .money_dollar_circle,
                                              size: kSizeM,
                                              color: darkColor,
                                            ),
                                          ),
                                          SizedBox(width: kSizeS),
                                          Text(
                                            "Total Income",
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.arrow_up_right,
                                            color: greenColor,
                                          ),
                                          Text(
                                            "25%",
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(color: greenColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: kSizeS),
                                  Text(
                                    "Rp. 13.534.000",
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: kSizeML,
                                        ),
                                  ),
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                          pieTouchData: PieTouchData(
                                            touchCallback:
                                                (
                                                  FlTouchEvent event,
                                                  pieTouchResponse,
                                                ) {},
                                          ),
                                          borderData: FlBorderData(show: false),
                                          sectionsSpace: 5,
                                          centerSpaceRadius: 70,
                                          sections: showingSections(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: primaryColor,
                                            radius: 5,
                                          ),
                                          SizedBox(width: kSizeSS),
                                          Text(
                                            "Product",
                                            style: context.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: kSizeM),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: secondaryColor,
                                            radius: 5,
                                          ),
                                          SizedBox(width: kSizeSS),
                                          Text(
                                            "Package",
                                            style: context.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: kSizeM),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: TotalOrderWidget()),
                                SizedBox(height: kSizeM),
                                Expanded(child: TotalOrderWidget()),
                              ],
                            ),
                          ),
                          SizedBox(width: kSizeM),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding * 2,
                              ).copyWith(bottom: kDefaultPadding),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(
                                  kDefaultRadius * 2,
                                ),
                                boxShadow: defaultShadow,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                    ),
                                    child: Text(
                                      "Penjualan mingguan",
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: kSizeMS),
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1.70,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 18,
                                          left: 12,
                                          top: 24,
                                          bottom: 12,
                                        ),
                                        child: LineChart(mainData(context)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: primaryColor,
            value: 10,
            radius: 10,
            showTitle: false,
          );
        case 1:
          return PieChartSectionData(
            color: secondaryColor,
            value: 20,
            radius: 10,
            showTitle: false,
          );
        default:
          throw Error();
      }
    });
  }

  LineChartData mainData(BuildContext context) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: lightGrey5, dashArray: [10, 16]);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Colors.transparent, strokeWidth: 0);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget:
                (value, meta) => Text(
                  "${value.toInt()}",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: lightGrey2,
                  ),
                ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 50,
            getTitlesWidget:
                (value, meta) => Text(
                  "${value.toInt()}",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: lightGrey2,
                  ),
                ),
            reservedSize: 35,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: 250,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 0),
            FlSpot(1, 50),
            FlSpot(2, 30),
            FlSpot(3, 100),
            FlSpot(4, 80),
            FlSpot(5, 30),
            FlSpot(6, 250),
            FlSpot(7, 50),
          ],
          isCurved: true,
          color: secondaryColor,
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  [
                    secondaryColor,
                    lightGrey8,
                  ].map((color) => color.withValues(alpha: 0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: context.padTop),
      padding: EdgeInsets.symmetric(vertical: kSizeML),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Dashboard",
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(formatDate(DateTime.now())),
              SizedBox(width: kSizeMS),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(CupertinoIcons.square_arrow_right, color: darkColor),
                    SizedBox(width: 6),
                    Text(
                      "Keluar",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeSS),
          Row(
            children:
                ["Minggu", "Bulan", "Tahun"]
                    .map(
                      (e) => TextButton(
                        onPressed: () {},
                        child: Text(
                          e,
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: e == "Minggu" ? darkColor : lightGrey1,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.icon, required this.iconOther});

  final List<List<Object>> icon;
  final List<List<Object>> iconOther;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSizeM, vertical: kSizeXL),
      width: 300,
      height: context.height,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: lightGrey6, width: 2)),
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
            return Container(
              margin: EdgeInsets.only(top: kSizeS - 10),
              padding: EdgeInsets.symmetric(
                horizontal: kSizeM,
                vertical: kSizeM,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: index == 0 ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(kDefaultRadius),
              ),
              child: Row(
                children: [
                  Icon(
                    icon[index][0] as IconData,
                    size: kSizeM,
                    color: index == 0 ? darkColor : greyColor,
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
                  if (index == 2)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(kDefaultRadius * 2),
                      ),
                      child: Center(
                        child: Text("2", textAlign: TextAlign.center),
                      ),
                    ),
                ],
              ),
            );
          }),
          SizedBox(height: kSizeL),
          Padding(
            padding: EdgeInsets.only(left: kSizeM),
            child: Text(
              "Lainnya",
              style: context.textTheme.bodyMedium?.copyWith(color: greyColor),
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
          SizedBox(height: kSizeXXL * 1.2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kSizeM),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: kSizeL,
              vertical: kSizeL,
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
              children: [
                CircleAvatar(minRadius: 35, backgroundImage: AssetImage(logo)),
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
    );
  }
}

class TotalOrderWidget extends StatelessWidget {
  const TotalOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        kDefaultPadding * 2,
      ).copyWith(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(kDefaultRadius * 2),
        boxShadow: defaultShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      CupertinoIcons.cart,
                      size: kSizeM,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(width: kSizeMS),
                  Text(
                    "Total Orders",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.arrow_down_right, color: secondaryColor),
                  Text(
                    "2%",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            "100",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: kSizeXL,
            ),
          ),
          Spacer(),
          Text(
            "lebih banyak 2 pesanan dari pada bulan lalu",
            style: context.textTheme.bodySmall?.copyWith(
              color: lightGrey2,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
