import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/currency_form_field_widget.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/inventory_form_view_page.dart';
import '../widgets/package_preview_widget.dart';
import '../widgets/pick_product_dialog.dart';
import '../widgets/selected_product_widget.dart';

class AddPackagePage extends StatefulWidget {
  static const path = '/add-package-page';

  const AddPackagePage({super.key});

  @override
  State<AddPackagePage> createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  late BehaviorSubject<Package> previewController;

  final formKey = GlobalKey<FormState>();
  var isActive = true;

  List<CategoryProduct> selectedCategory = [];
  List<Product> selectedProduct = [];

  late TextEditingController nameController;
  late TextEditingIDRController priceController;
  XFile? file;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingIDRController();
    previewController = BehaviorSubject.seeded(Package.preview());
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    previewController.close();
  }

  void onSaveForm() {
    if (formKey.currentState?.validate() == false) return;

    if (selectedCategory.isEmpty) {
      EasyLoading.showToast("Silahkan pilih Kategori");
      return;
    }

    // final product = Product(
    //   id: "", // generate at repository
    //   name: nameController.text,
    //   code: "", // generate at model
    //   price: priceController.getDoubleValue(),
    //   createAt: DateTime.now().toUtc().toString(),
    //   isActive: isActive,
    //   category: category,
    // );

    // final event = OnAddProduct(
    //   product: product,
    //   category: category,
    //   productImage: file,
    // );
    // context.read<ProductsBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return InventoryFormWidget(
      title: "Buat Package/Paket baru",
      onSave: onSaveForm,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImagePickerWidget(
                        onChange: (ImagePickerResult image) async {
                          file = image.file;
                          final preview = await previewController.stream.first;
                          final n = preview.copyWith(
                            imageByte: image.imageByte,
                          );
                          previewController.add(n);
                        },
                      ),
                      SizedBox(height: kSizeM),
                      TextFormFieldWidget(
                        controller: nameController,
                        title: "Nama Produk",
                        onChanged: (value) async {
                          final preview = await previewController.stream.first;
                          final n = preview.copyWith(name: value);
                          previewController.add(n);
                        },
                      ),
                      SizedBox(height: kSizeM),
                      CurrencyFormFieldWidget(
                        controller: priceController,
                        title: "Harga",
                        hintText: "Masukan",
                        onChanged: (value) async {
                          final preview = await previewController.stream.first;
                          final n = preview.copyWith(
                            price: priceController.getDoubleValue(),
                          );
                          previewController.add(n);
                        },
                      ),
                      SizedBox(height: kSizeM),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Aktivkan Package/Paket? ",
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
                      Text(
                        "Kategori",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: kSizeM),
                      BlocBuilder<ProductsBloc, ProductState>(
                        builder: (context, state) {
                          return SelectedProductWidget(
                            opts: PickProductDialogOpts(
                              title: "Pilih Kategori",
                              data: state.categories,
                              selectedData: selectedCategory,
                              onChange: (category) async {
                                final cat = category as CategoryProduct;
                                final preview =
                                    await previewController.stream.first;
                                final n = preview.copyWith(category: cat);
                                previewController.add(n);
                                setState(() {
                                  selectedCategory = [cat];
                                });
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: kSizeM),
                      Text(
                        "Produk",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: kSizeM),
                      BlocBuilder<ProductsBloc, ProductState>(
                        builder: (context, state) {
                          return SelectedProductWidget(
                            opts: PickProductDialogOpts(
                              title: "Pilih Produk",
                              selectedData: selectedProduct,
                              onChange: (product) async {
                                final preview =
                                    await previewController.stream.first;
                                final products = [...selectedProduct, product];
                                final n = preview.copyWith(items: products);
                                previewController.add(n);
                                setState(() {
                                  selectedProduct = products;
                                });
                              },
                              data: state.products,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
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
                      StreamBuilder(
                        stream: previewController.stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return PackagePreviewWidget(
                              package: Package.preview(),
                            );
                          }

                          final preview = snapshot.data;
                          return PackagePreviewWidget(package: preview!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
