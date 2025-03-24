import 'package:fl_chart/fl_chart.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/features/auth/presentations/bloc/auth_bloc.dart';

class DashboardPage extends StatelessWidget {
  static const path = '/dashboard-page';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultRadius).copyWith(top: kSizeML),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DashboardAppBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: context.height / 2.2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(kDefaultPadding),
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
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Icon(
                                            CupertinoIcons.money_dollar_circle,
                                            size: kSizeM,
                                            color: darkColor,
                                          ),
                                        ),
                                        SizedBox(width: kSizeS),
                                        Text(
                                          "Total Income",
                                          style: context.textTheme.bodySmall
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
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(color: greenColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: kSizeS),
                                Text(
                                  "Rp. 13.534.000",
                                  style: context.textTheme.displayMedium,
                                ),
                                SizedBox(height: kSizeXL),
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (context, bc) {
                                      return PieChart(
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
                                          centerSpaceRadius: bc.maxWidth * 0.2,
                                          sections: showingSections(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: kSizeXL),
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
                                          style: context.textTheme.bodySmall,
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
                                          style: context.textTheme.bodySmall,
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
                              SizedBox(height: kSizeS),
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
                                kDefaultRadius,
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
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: kSizeMS),
                                Expanded(
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kSizeM),
                  SizedBox(
                    height: context.height / 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                kDefaultRadius,
                              ),
                              boxShadow: defaultShadow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order yang sedang diproses",
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: kSizeMS),
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(1),
                                    3: FlexColumnWidth(1),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        tableCell("Pelanggan", isHeader: true),
                                        tableCell("Produk", isHeader: true),
                                        tableCell("Tanggal", isHeader: true),
                                        tableCell("Status", isHeader: true),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: kSizeM),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(2),
                                        2: FlexColumnWidth(1),
                                        3: FlexColumnWidth(1),
                                      },
                                      children: List.generate(3, (index) {
                                        return TableRow(
                                          children: [
                                            tableCell("SMK Globin"),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadiusDirectional.circular(
                                                          kDefaultRadius * 0.5,
                                                        ),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        "https://cdn.prod.website-files.com/6346686a30512816becfbf47/671ed63b8d688b6b1d10a0ec_freepik__retouch__32461.png",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Paket Berkah 25k",
                                                      style: context
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    SizedBox(
                                                      width: context.width / 8,
                                                      child: Text(
                                                        "Nasi, Ayam bakar, Tahu Tempe, Cah kangkung, Buah jeruk, Sambal Lalap",
                                                        style:
                                                            context
                                                                .textTheme
                                                                .bodySmall,
                                                        maxLines: 3,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            tableCell(
                                              formatToDateTime(DateTime.now()),
                                            ),
                                            tableCell("2 Hari lagi"),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: kSizeM),
                        Expanded(child: MostProductWidget()),
                      ],
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

  Widget tableCell(String text, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
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
            radius: 5,
            showTitle: false,
          );
        case 1:
          return PieChartSectionData(
            color: secondaryColor,
            value: 20,
            radius: 5,
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
      padding: EdgeInsets.symmetric(vertical: kSizeML),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Dashboard", style: context.textTheme.titleLarge),
              ),
              Text(formatDate(DateTime.now())),
              SizedBox(width: kSizeMS),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(OnSignOutEvent());
                },
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

class TotalOrderWidget extends StatelessWidget {
  const TotalOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        kDefaultPadding,
      ).copyWith(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(kDefaultRadius),
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
                    style: context.textTheme.bodySmall?.copyWith(
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
                    style: context.textTheme.bodySmall?.copyWith(
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text("100", style: context.textTheme.displayLarge),
          Spacer(),
          // Text(
          //   "lebih banyak 2 pesanan dari pada bulan lalu",
          //   style: context.textTheme.bodySmall?.copyWith(
          //     color: lightGrey2,
          //     fontStyle: FontStyle.italic,
          //   ),
          //   textAlign: TextAlign.end,
          // ),
        ],
      ),
    );
  }
}

class MostProductWidget extends StatelessWidget {
  const MostProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      "Paket Hemat Berkah 16K Ayam Bakar",
      "Paket Hemat Berkah 16K Ayam Goreng",
      "Paket Kue 10K",
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        kDefaultPadding * 2,
      ).copyWith(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(kDefaultRadius),
        boxShadow: defaultShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  CupertinoIcons.heart_fill,
                  size: kSizeM,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: kSizeMS),
              Text(
                "Paling sering dipesan",
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: kSizeM),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: kSizeS),
                    padding: EdgeInsets.all(kSizeS),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                        kDefaultRadius * 0.5,
                      ),
                      color: lightGrey8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(
                              kDefaultRadius * 0.5,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://cdn.prod.website-files.com/6346686a30512816becfbf47/671ed63b8d688b6b1d10a0ec_freepik__retouch__32461.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: kSizeS),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data[index],
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kSizeS * 0.9,
                                  ),
                                ),
                              ),
                              SizedBox(width: kSizeM),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "20x",
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: kSizeS,
                                          color: secondaryColor,
                                        ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "200 pcs",
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: kSizeS,
                                          color: secondaryColor,
                                        ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
