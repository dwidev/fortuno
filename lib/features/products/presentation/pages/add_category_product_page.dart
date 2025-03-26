import 'package:dotted_border/dotted_border.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/form/text_form_field_widget.dart';

class AddCategoryProductPage extends StatefulWidget {
  static const path = '/add-cat-product-page';

  const AddCategoryProductPage({super.key});

  @override
  State<AddCategoryProductPage> createState() => _AddCategoryProductPageState();
}

class _AddCategoryProductPageState extends State<AddCategoryProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Buat category"),
      //   actions: [
      //     ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: successButtonColor,
      //       ),
      //       onPressed: () {
      //         context.pop();
      //       },
      //       child: Text(
      //         "Simpan",
      //         style: context.textTheme.bodySmall?.copyWith(color: whiteColor),
      //       ),
      //     ),
      //   ],
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text('Buat category'),
              backgroundColor:
                  innerBoxIsScrolled ? Colors.white : Colors.transparent,
              pinned: true,
              elevation: 0,
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: successButtonColor,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    "Simpan",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ];
        },
        body: Container(
          margin: anchorAllContent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: kSizeS),
                  width: context.width / 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImagePickerWidget(),
                      SizedBox(width: kSizeM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormFieldWidget(title: "Nama kategori"),
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
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
