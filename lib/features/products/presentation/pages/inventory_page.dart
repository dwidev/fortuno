import '../../../../core/core.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';
import '../bloc/product_bloc.dart';
import 'category_product_view_page.dart';
import 'package_view_page.dart';
import 'product_view_page.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Inventaris"),
        actions: [
          SizedBox(
            width: context.width / 4,
            child: TextFormFieldWidget(
              title: "",
              controller: TextEditingController(),
              hintText: "Cari berdasarkan nama, order, atau lainnya",
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kBottomNavigationBarHeight),
          child: CustomTab(
            currentIndex: activeMenu,
            menus: ["Kategori", "Product", "Package"],
            changeMenu: (index) {
              setState(() {
                activeMenu = index;
              });
            },
          ),
        ),
      ),
      body: BaseListenerWidget<ProductsBloc, ProductState>(
        builder: (context, bloc, state) {
          return Container(
            margin: anchorTopContent,
            child: Column(
              children: [
                /// CONTENT
                /// CATEGORY
                if (activeMenu == 0) Expanded(child: CategoryProductViewPage()),

                /// PRODUCT
                if (activeMenu == 1) Expanded(child: ProductViewPage()),

                /// PACKAGE
                if (activeMenu == 2) Expanded(child: PackageViewPage()),
              ],
            ),
          );
        },
      ),
    );
  }
}
