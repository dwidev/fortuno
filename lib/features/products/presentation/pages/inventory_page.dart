import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fortuno/features/products/presentation/pages/category_product_view_page.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/custom_tab.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../../../order/presentations/widgets/loading_product_widget.dart';
import '../../../order/presentations/widgets/product_card_widget.dart';
import '../bloc/product_bloc.dart';

class InvetoryPage extends StatefulWidget {
  static const path = '/inventory-page';
  const InvetoryPage({super.key});

  @override
  State<InvetoryPage> createState() => _InvetoryPageState();
}

class _InvetoryPageState extends State<InvetoryPage> {
  var activeMenu = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(OnInitInvetoryPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseListenerWidget<ProductsBloc, ProductState>(
        builder: (context, bloc, state) {
          return Column(
            children: [
              /// APP BAR
              Container(
                margin: anchorCustomAppBar.addTopHeightMenubar(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Inventaris",
                            style: context.textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          width: context.width / 3,
                          child: TextFormFieldWidget(
                            title: "",
                            controller: TextEditingController(),
                            hintText:
                                "Cari berdasarkan nama, order, atau lainnya",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kSizeSS),
                    CustomTab(
                      currentIndex: activeMenu,
                      menus: ["Kategori", "Product", "Package"],
                      changeMenu: (index) {
                        setState(() {
                          activeMenu = index;
                        });
                      },
                    ),
                  ],
                ),
              ),

              /// CONTENT
              /// CATEGORY
              if (activeMenu == 0) Expanded(child: CategoryProductViewPage()),
            ],
          );
        },
      ),
    );
  }
}
