import '../../../../core/core.dart';
import '../../../products/domain/entities/inventory.dart';
import '../../../products/domain/entities/package.dart';
import 'product_image_container_widget.dart';

class PackageCardWidget extends StatefulWidget {
  const PackageCardWidget({
    super.key,
    required this.package,
    required this.quantity,
    required this.disable,
    required this.onTap,
    this.isPreview = false,
    this.isInventory = false,
    this.onActivate,
  });

  final Package package;
  final int quantity;
  final bool disable;
  final bool isPreview;
  final bool isInventory;
  final VoidCallback onTap;
  final Function(bool value, String id)? onActivate;

  factory PackageCardWidget.preview({required Package package}) =>
      PackageCardWidget(
        package: package,
        quantity: 0,
        disable: false,
        onTap: () {},
        isPreview: true,
      );

  factory PackageCardWidget.inventory({required Package package}) =>
      PackageCardWidget(
        package: package,
        quantity: 0,
        disable: false,
        onTap: () {},
        isInventory: true,
      );

  @override
  State<PackageCardWidget> createState() => _PackageCardWidgetState();
}

class _PackageCardWidgetState extends State<PackageCardWidget> {
  var active = false;
  @override
  void didUpdateWidget(covariant PackageCardWidget oldWidget) {
    if (widget.package.isActive) {
      setState(() {
        active = true;
      });
    }

    if (!widget.package.isActive) {
      setState(() {
        active = false;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                    ProductImageContainer(
                      width: 75,
                      height: 75,
                      data: widget.package,
                    ),
                    if (widget.quantity != 0)
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "x${widget.quantity}",
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
                        widget.package.name,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: kSizeS),
                      Row(
                        children: [
                          if ((widget.package.category?.name ?? "").isNotEmpty)
                            TextBadgeWidget(
                              text: widget.package.category?.name ?? "",
                              color: getValueColor(
                                widget.package.category?.name ?? "",
                              ),
                            ),
                          SizedBox(width: kSizeS),
                          TextBadgeWidget(
                            text: widget.package.type.name,
                            color: getValueColor(widget.package.type.name),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: kSizeS),
            if (widget.package.contents.isNotEmpty) ...[
              Text(
                widget.package.contents,
                style: context.textTheme.labelSmall?.copyWith(color: greyColor),
              ),
              SizedBox(height: kSizeS),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.package.priceFormated,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.isInventory)
                  Switch.adaptive(
                    value: active,
                    onChanged: (value) {
                      setState(() {
                        active = value;
                      });

                      widget.onActivate?.call(value, widget.package.id);
                    },
                  ),
                if (widget.quantity != 0)
                  Container(
                    padding: EdgeInsets.all(kSizeS),
                    decoration: BoxDecoration(
                      color:
                          widget.disable
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
