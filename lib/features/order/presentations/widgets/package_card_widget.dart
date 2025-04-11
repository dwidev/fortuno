import '../../../../core/core.dart';
import '../../../products/domain/entities/inventory.dart';
import '../../../products/domain/entities/package.dart';
import 'image_container_widget.dart';

class PackageCardWidget extends StatelessWidget {
  const PackageCardWidget({
    super.key,
    required this.package,
    required this.quantity,
    required this.disable,
    required this.onTap,
    this.isPreview = false,
  });

  final Package package;
  final int quantity;
  final bool disable;
  final bool isPreview;
  final VoidCallback onTap;

  factory PackageCardWidget.preview({required Package package}) =>
      PackageCardWidget(
        package: package,
        quantity: 0,
        disable: false,
        onTap: () {},
        isPreview: true,
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ProductImageContainer(width: 75, height: 75, data: package),
                    if (quantity != 0)
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "x$quantity",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: kSizeS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.name,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: kSizeS),
                      if ((package.category?.name ?? "").isNotEmpty)
                        TextBadgeWidget(
                          text: package.category?.name ?? "",
                          color: getValueColor(package.category?.name ?? ""),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: kSizeS),
            Text(
              package.contents,
              style: context.textTheme.labelSmall?.copyWith(color: greyColor),
            ),
            SizedBox(height: kSizeS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  package.priceFormated,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (quantity != 0)
                  Container(
                    padding: EdgeInsets.all(kSizeS),
                    decoration: BoxDecoration(
                      color: disable ? disabledButtonColor : deleteButtonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(CupertinoIcons.delete, color: whiteColor),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
