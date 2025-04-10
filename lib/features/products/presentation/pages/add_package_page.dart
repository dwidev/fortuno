import 'dart:typed_data';

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

  Future<void> onSaveForm() async {
    if (formKey.currentState?.validate() == false) return;

    if (selectedCategory.isEmpty) {
      EasyLoading.showToast("Silahkan pilih Kategori");
      return;
    }

    if (selectedProduct.isEmpty && selectedCategory.length < 4) {
      EasyLoading.showToast("Silahkan pilih minimal 4 Produk");
      return;
    }

    Uint8List? image;

    if (file != null) {
      image = await file!.readAsBytes();
    }

    final package = Package.create(
      name: nameController.text,
      price: priceController.getDoubleValue(),
      isActive: isActive,
      category: selectedCategory.first,
      items: selectedProduct,
      imageByte: image,
    );

    final event = OnAddPackage(package: package);
    context.read<ProductsBloc>().add(event);
  }

  Future<void> onChangeProduct(Product product) async {
    final idx = selectedProduct.indexWhere((e) => e.id == product.id);
    if (idx == -1) {
      selectedProduct = [...selectedProduct, product];
    } else {
      selectedProduct.removeAt(idx);
    }

    final preview = await previewController.stream.first;
    final n = preview.copyWith(items: selectedProduct);
    previewController.add(n);

    setState(() {
      selectedProduct = selectedProduct;
    });
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
                              type: PickProductType.multiple,
                              title: "Pilih Produk",
                              selectedData: selectedProduct,
                              onChange: onChangeProduct,
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
