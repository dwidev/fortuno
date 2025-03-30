import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../../domain/entities/category.dart';
import '../bloc/product_bloc.dart';
import '../widgets/inventory_form_view_page.dart';
import '../widgets/product_preview_widget.dart';

class AddCategoryProductPage extends StatefulWidget {
  static const path = '/add-cat-product-page';

  const AddCategoryProductPage({super.key});

  @override
  State<AddCategoryProductPage> createState() => _AddCategoryProductPageState();
}

class _AddCategoryProductPageState extends State<AddCategoryProductPage> {
  late BehaviorSubject<CategoryProduct> productPreviewController;

  final formKey = GlobalKey<FormState>();
  var isActive = true;
  var isCategory = true;
  List<CategoryProduct> selectedCategory = [];
  late TextEditingController nameController;
  XFile? file;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    productPreviewController = BehaviorSubject.seeded(
      CategoryProduct.preview(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    productPreviewController.close();
  }

  void onSaveForm() {
    if (formKey.currentState?.validate() == false) return;

    final category = CategoryProduct(
      id: "", // generate at repository
      name: nameController.text,
      code: "", // generate at model
      price: 0,
      createAt: DateTime.now().toUtc().toString(),
      imageByte: null,
      isActive: isActive,
      haveProduct: true,
    );

    final event = OnAddCategory(category: category);
    context.read<ProductsBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return InventoryFormWidget(
      title: "Buat Kategori baru",
      onSave: onSaveForm,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagePickerWidget(
                  onChange: (ImagePickerResult image) async {
                    file = image.file;
                    final preview = await productPreviewController.stream.first;
                    final n = preview.copyWith(imageByte: image.imageByte);
                    productPreviewController.add(n);
                  },
                ),
                SizedBox(width: kSizeM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormFieldWidget(
                        controller: nameController,
                        title: "Nama Kategori",
                        onChanged: (value) async {
                          final preview =
                              await productPreviewController.stream.first;
                          final n = preview.copyWith(name: value);
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
                      StreamBuilder<CategoryProduct>(
                        stream: productPreviewController.stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return ProductPreviewWidget(
                              product: CategoryProduct.preview(),
                            );
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
      ),
    );
  }
}
