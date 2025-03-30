import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/core.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/widgets/selected_product_widget.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({
    super.key,
    this.quantity = 0,
    required this.product,
    required this.onTap,
    this.onDelete,
    this.isDisable = false,
    this.isInventory = false,
    this.onNonActive,
    this.width,
    this.height,
    this.isPreview = false,
    this.isPicker = false,
    this.isActive = true,
  });

  factory ProductCardWidget.inventory({
    required Product product,
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) => ProductCardWidget(
    product: product,
    onTap: onTap,
    onDelete: onDelete,
    isDisable: false,
    isActive: product.isActive,
    isInventory: true,
  );

  factory ProductCardWidget.preview({
    required Product product,
    required VoidCallback onTap,
  }) => ProductCardWidget(product: product, onTap: onTap, isPreview: true);

  factory ProductCardWidget.picker({
    required Product product,
    required VoidCallback onTap,
  }) => ProductCardWidget(product: product, onTap: onTap, isPicker: true);

  final double? width;
  final double? height;
  final int quantity;
  final Product product;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool isDisable;
  final bool isActive;
  final bool isInventory;
  final Function(bool value)? onNonActive;
  final bool isPreview;
  final bool isPicker;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  var active = false;

  bool get isDisable => widget.isDisable || !active;

  bool get isImagePreview => widget.isPreview;

  @override
  void initState() {
    active = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          !isDisable
              ? widget.onTap
              : () {
                if (widget.isInventory) return;

                EasyLoading.showToast(
                  "Silahkan kembali kemenu Rincian pesanan",
                );
              },
      child: CustomCard(
        width: widget.width,
        height: widget.height,
        border: widget.isPicker ? Border.all(color: primaryColor) : null,
        padding: anchorAllContent.min(10),
        constraints: BoxConstraints(minHeight: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: isImagePreview ? lightGrey8 : null,
                    borderRadius: BorderRadius.circular(kSizeMS),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kSizeMS),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        isDisable ? Colors.grey : Colors.transparent,
                        isDisable ? BlendMode.saturation : BlendMode.dst,
                      ),
                      child:
                          isImagePreview
                              ? widget.product.imageByte != null
                                  ? Image.memory(
                                    widget.product.imageByte!,
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
                if (widget.isInventory)
                  Positioned(
                    right: kSizeSS,
                    child: Switch.adaptive(
                      value: active,
                      onChanged: (value) {
                        setState(() {
                          active = value;
                        });

                        widget.onNonActive?.call(value);
                      },
                    ),
                  ),

                if (widget.isInventory)
                  Positioned(
                    right: kSizeSS,
                    child: TextBadgeWidget(
                      text: widget.product.category?.name ?? "",
                      color: getValueColor(widget.product.category?.name ?? ""),
                    ),
                  ),

                if (widget.quantity != 0 && !widget.isInventory)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          widget.quantity != 0
                              ? Text(
                                "x${widget.quantity}",
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              )
                              : Icon(
                                CupertinoIcons.add_circled_solid,
                                color: whiteColor,
                              ),
                    ),
                  ),

                if (widget.isPicker)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: CheckListWidget(checked: true),
                  ),
              ],
            ),
            SizedBox(height: kSizeM),
            Container(
              padding: EdgeInsets.only(left: kSizeSS, right: kSizeSS),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.product.name,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (widget.isPreview && widget.product.price == 0)
                          Text(
                            "Harga produk",
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (widget.product.price > 0)
                          Text(
                            widget.product.priceFormated,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.quantity != 0 || widget.isInventory) ...[
                    SizedBox(width: kSizeMS),
                    Container(
                      padding: EdgeInsets.all(kSizeS),
                      decoration: BoxDecoration(
                        color:
                            isDisable && !widget.isInventory
                                ? disabledButtonColor
                                : deleteButtonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(CupertinoIcons.delete, color: whiteColor),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: kSizeS),
          ],
        ),
      ),
    );
  }
}
