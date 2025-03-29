import 'package:fortuno/features/products/domain/entities/product.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../widgets/inventory_form_view_page.dart';
import '../widgets/product_preview_widget.dart';

class AddCategoryProductPage extends StatefulWidget {
  static const path = '/add-cat-product-page';

  const AddCategoryProductPage({super.key});

  @override
  State<AddCategoryProductPage> createState() => _AddCategoryProductPageState();
}

class _AddCategoryProductPageState extends State<AddCategoryProductPage> {
  var isCategory = false;
  var isActive = true;

  @override
  Widget build(BuildContext context) {
    return InventoryFormWidget(
      title: "Buat Kategori baru",
      onSave: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePickerWidget(onChange: (ImagePickerResult image) async {}),
              SizedBox(width: kSizeM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldWidget(
                      controller: TextEditingController(),
                      title: "Nama Produk",
                    ),
                    SizedBox(height: kSizeM),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Aktivkan product? ",
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch.adaptive(
                          value: isActive,
                          onChanged: (value) {
                            setState(() {
                              isActive = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: anchorLeftContent,
                      child: Text(
                        "Preview",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: kSizeM),
                    ProductPreviewWidget(product: Product.preview()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
