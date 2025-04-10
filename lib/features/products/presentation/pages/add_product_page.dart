import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/currency_form_field_widget.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../../domain/entities/category.dart';
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
  late BehaviorSubject<Product> productPreviewController;

  final formKey = GlobalKey<FormState>();
  var isActive = true;
  var isCategory = true;
  List<CategoryProduct> selectedCategory = [];
  late TextEditingController nameController;
  late TextEditingIDRController priceController;
  XFile? file;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingIDRController();
    productPreviewController = BehaviorSubject.seeded(Product.preview());
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    productPreviewController.close();
  }

  void onSaveForm() {
    if (formKey.currentState?.validate() == false) return;

    if (isCategory && selectedCategory.isEmpty) {
      EasyLoading.showToast("Silahkan pilih / Tanpa Kategori");
      return;
    }

    CategoryProduct? category;

    if (isCategory) {
      category = selectedCategory.first;
    }

    final product = Product(
      id: "", // generate at repository
      name: nameController.text,
      code: "", // generate at model
      price: priceController.getDoubleValue(),
      createAt: DateTime.now().toUtc().toString(),
      isActive: isActive,
      category: category,
    );

    final event = OnAddProduct(
      product: product,
      category: category,
      productImage: file,
    );
    context.read<ProductsBloc>().add(event);
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
                      ImagePickerWidget(
                        onChange: (ImagePickerResult image) async {
                          file = image.file;
                          final preview =
                              await productPreviewController.stream.first;
                          final n = preview.copyWith(
                            imageByte: image.imageByte,
                          );
                          productPreviewController.add(n);
                        },
                      ),
                      SizedBox(height: kSizeM),
                      TextFormFieldWidget(
                        controller: nameController,
                        title: "Nama Produk",
                        onChanged: (value) async {
                          final preview =
                              await productPreviewController.stream.first;
                          final n = preview.copyWith(name: value);
                          productPreviewController.add(n);
                        },
                      ),
                      SizedBox(height: kSizeM),
                      CurrencyFormFieldWidget(
                        controller: priceController,
                        title: "Harga",
                        hintText: "Masukan",
                        onChanged: (value) async {
                          final preview =
                              await productPreviewController.stream.first;
                          final n = preview.copyWith(
                            price: priceController.getDoubleValue(),
                          );
                          productPreviewController.add(n);
                        },
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
                                    selectedCategory = [
                                      product as CategoryProduct,
                                    ];
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
                    StreamBuilder<Product>(
                      stream: productPreviewController.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return ProductPreviewWidget(product: Product.dummy());
                        }

                        final preview = snapshot.data;
                        return ProductPreviewWidget(product: preview!);
                      },
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
