// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fortuno/core/core.dart';

import 'order_action_widget.dart';
import 'order_package_widget.dart';

class OrderProcessItemListWidget extends StatelessWidget {
  const OrderProcessItemListWidget({
    super.key,
    required this.index,
    required this.activeIndex,
    required this.onClickDetail,
    required this.isDetail,
  });

  final bool isDetail;
  final int index, activeIndex;
  final Function() onClickDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding).copyWith(bottom: 0),
      child: Material(
        borderRadius: BorderRadius.circular(kDefaultRadius),
        color:
            isDetail && index == activeIndex ? lemonChiffonColor : whiteColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(kDefaultRadius),
          onTap: () {
            onClickDetail();
          },
          child: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SMK Adi sanggoro",
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: kSizeS),
                        Text("Dikirim : 20 Februari 2025 10:00 WIB"),
                        Text("Total : Rp 200.000"),
                      ],
                    ),
                    SizedBox(width: kSizeXXL),
                    if (!isDetail) OrderPackageWidget(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "14:03",
                      style: context.textTheme.bodyLarge?.copyWith(
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
  }
}
