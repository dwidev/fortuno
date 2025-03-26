import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fortuno/core/widgets/form/currency_form_field_widget.dart';
import 'package:fortuno/features/order/presentations/widgets/product_card_widget.dart';
import 'package:fortuno/features/products/domain/entities/product.dart';
import 'package:fortuno/features/products/presentation/widgets/inventory_form_view_page.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';

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
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: kSizeM),
                    MasonryGridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                      ),
                      crossAxisSpacing: kSizeMS,
                      mainAxisSpacing: kSizeMS,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemBuilder: (context, index) {
                        return ProductCardWidget(
                          product: Product(
                            id: "id",
                            name: "name",
                            code: "code",
                            price: 300000,
                            createAt: DateTime.now().toString(),
                          ),
                          onTap: () {},
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Text("data"),
            ],
          ),
        ],
      ),
    );
  }
}
