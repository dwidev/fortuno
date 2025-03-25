part of '../page/dashboard_page.dart';

class TotalOrderWidget extends StatelessWidget {
  const TotalOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
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
