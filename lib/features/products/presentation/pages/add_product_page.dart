import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/currency_form_field_widget.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/inventory_form_view_page.dart';
import '../widgets/pick_product_dialog.dart';
import '../widgets/product_preview_widget.dart';
import '../widgets/selected_product_widget.dart';

class AddProductPage extends StatefulWidget {
  static const path = '/add-product-page';

  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final formKey = GlobalKey<FormState>();
  var isActive = true;
  var isCategory = true;
  List<Product> selectedCategory = [];
  late TextEditingController nameController;
  late TextEditingIDRController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingIDRController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  void onSaveForm() {
    if (formKey.currentState?.validate() == false) return;

    if (isCategory && selectedCategory.isEmpty) {
      EasyLoading.showToast("Silahkan pilih category");
    }

    final product = Product(
      id: '',
      name: nameController.text,
      code: "",
      price: priceController.getDoubleValue(),
      createAt: DateTime.now().toUtc().toString(),
    );
    context.read<ProductsBloc>().add(OnAddProduct(product));
  }

  @override
  Widget build(BuildContext context) {
    return InventoryFormWidget(
      title: "Buat Produk baru",
      onSave: onSaveForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImagePickerWidget(),
                      SizedBox(height: kSizeM),
                      TextFormFieldWidget(
                        controller: nameController,
                        title: "Nama Produk",
                      ),
                      SizedBox(height: kSizeM),
                      CurrencyFormFieldWidget(
                        controller: priceController,
                        title: "Harga",
                        hintText: "Masukan",
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
                                value: !isCategory,
                                onChanged: (value) {
                                  setState(() {
                                    isCategory = !isCategory;
                                  });
                                },
                              ),
                              Text("Tanpa kategori"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: kSizeM),
                      if (isCategory)
                        BlocBuilder<ProductsBloc, ProductState>(
                          builder: (context, state) {
                            return SelectedProductWidget(
                              opts: PickProductDialogOpts(
                                title: "Pilih Kategori",
                                data: state.categories,
                                selectedData: selectedCategory,
                                onChange: (product) {
                                  setState(() {
                                    selectedCategory = [product];
                                  });
                                },
                              ),
                            );
                          },
                        ),
                    ],
                  ),
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
                    ProductPreviewWidget(
                      name: nameController.text,
                      price: priceController.getDoubleValue(),
                    ),
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
