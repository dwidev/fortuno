import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/currency_form_field_widget.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../widgets/inventory_form_view_page.dart';
import '../widgets/package_preview_widget.dart';
import '../widgets/pick_product_dialog.dart';
import '../widgets/product_preview_widget.dart';
import '../widgets/selected_product_widget.dart';

class AddPackagePage extends StatefulWidget {
  static const path = '/add-package-page';

  const AddPackagePage({super.key});

  @override
  State<AddPackagePage> createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  var isCategory = false;
  var isActive = true;

  @override
  Widget build(BuildContext context) {
    return InventoryFormWidget(
      title: "Buat Package/Paket baru",
      onSave: () {},
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
                      onChange: (ImagePickerResult image) async {},
                    ),
                    SizedBox(height: kSizeM),
                    TextFormFieldWidget(
                      controller: TextEditingController(),
                      title: "Nama Package/Paket",
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
                            selectedData: [],
                            onChange: (product) {},
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
                    SelectedProductWidget(
                      opts: PickProductDialogOpts(
                        title: "Pilih Produk",
                        selectedData: [],
                        onChange: (product) {},
                        data: [],
                      ),
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
                    PackagePreviewWidget(
                      name: "Nama Package/Paket",
                      price: 0.0,
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
