import '../../../../core/core.dart';
import '../../../products/domain/entities/package.dart';

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

  bool get finishSelected => disable;

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
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: darkLightColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            finishSelected ? Colors.grey : Colors.transparent,
                            finishSelected
                                ? BlendMode.saturation
                                : BlendMode.dst,
                          ),
                          child:
                              isPreview
                                  ? package.imageByte != null
                                      ? Image.memory(
                                        package.imageByte!,
                                        fit: BoxFit.cover,
                                      )
                                      : Offstage()
                                  : Image.network(
                                    "https://cms.disway.id//uploads/0a89f2c48130e61ec0621d8bdd2d6b74.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                    ),
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
                      color:
                          finishSelected
                              ? disabledButtonColor
                              : deleteButtonColor,
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
