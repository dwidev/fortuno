import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/core.dart';
import '../../../products/domain/entities/inventory.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/widgets/selected_product_widget.dart';
import 'delete_product_dialog.dart';
import 'image_container_widget.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({
    super.key,
    this.quantity = 0,
    required this.product,
    required this.onTap,
    this.onDelete,
    this.isDisable = false,
    this.isInventory = false,
    this.onActivate,
    this.width,
    this.height,
    this.isPreview = false,
    this.isPicker = false,
    this.isActive = true,
    this.isPicked = false,
  });

  factory ProductCardWidget.inventory({
    required Product product,
    required VoidCallback onTap,
    required Function(String id) onDelete,
    required Function(bool value, String id)? onActivate,
  }) => ProductCardWidget(
    product: product,
    onTap: onTap,
    onDelete: onDelete,
    onActivate: onActivate,
    isDisable: false,
    isActive: product.isActive,
    isInventory: true,
  );

  factory ProductCardWidget.preview({
    required Product product,
    required VoidCallback onTap,
  }) => ProductCardWidget(
    product: product,
    onTap: onTap,
    isPreview: true,
    isActive: true,
  );

  factory ProductCardWidget.picker({
    required Product product,
    required VoidCallback onTap,
    required bool isPicked,
  }) => ProductCardWidget(
    product: product,
    onTap: onTap,
    isPicked: isPicked,
    isPicker: true,
  );

  final double? width;
  final double? height;
  final int quantity;
  final Product product;
  final VoidCallback onTap;
  final Function(String id)? onDelete;
  final bool isDisable;
  final bool isActive;
  final bool isInventory;
  final Function(bool value, String id)? onActivate;
  final bool isPreview;
  final bool isPicker;
  final bool isPicked;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  var active = false;

  bool get isDisable => widget.isDisable || !active;

  String get catName => widget.product.category?.name ?? "";

  @override
  void initState() {
    active = widget.isActive;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductCardWidget oldWidget) {
    if (widget.product.isActive) {
      setState(() {
        active = true;
      });
    }

    if (!widget.product.isActive) {
      setState(() {
        active = false;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  void onDelete() {
    showDeleteProductDialog(
      context: context,
      onDelete: () {
        widget.onDelete?.call(widget.product.id);
      },
    );
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
        border:
            widget.isPicker && widget.isPicked
                ? Border.all(color: successButtonColor)
                : null,
        padding: anchorAllContent.min(10),
        constraints: BoxConstraints(minHeight: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ProductImageContainer(
                  width: double.infinity,
                  height: 130,
                  isDisable: widget.isDisable,
                  data: widget.product,
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

                        widget.onActivate?.call(value, widget.product.id);
                      },
                    ),
                  ),

                if (widget.isInventory && catName.isNotEmpty)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 100),
                        child: TextBadgeWidget(
                          text: catName,
                          color: getValueColor(catName),
                          opactiy: 0.8,
                        ),
                      ),
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
                    child: CheckListWidget(checked: widget.isPicked),
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
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
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
