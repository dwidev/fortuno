import '../../../../core/core.dart';
import '../../../../core/widgets/form/currency_form_field_widget.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../widgets/inventory_form_view_page.dart';
import '../widgets/product_preview_widget.dart';
import '../widgets/selected_product_widget.dart';

class AddProductPage extends StatefulWidget {
  static const path = '/add-product-page';

  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  var isCategory = false;
  var isActive = true;

  @override
  Widget build(BuildContext context) {
    return InventoryFormWidget(
      title: "Buat Produk baru",
      onSave: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePickerWidget(),
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
                    TextFormFieldWidget(
                      controller: TextEditingIDRController(),
                      title: "Harga",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kategori",
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: isCategory,
                              onChanged: (value) {
                                setState(() {
                                  isCategory = value ?? false;
                                });
                              },
                            ),
                            Text("Tanpa kategori"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: kSizeMS),
                    SelectedProductWidget(),
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
                    ProductPreviewWidget(name: "Nama Product", price: 0.0),
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
