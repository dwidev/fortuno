import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/features/order/presentations/widgets/product_card_widget.dart';
import 'package:fortuno/features/products/domain/entities/product.dart';

class ProductPreviewWidget extends StatelessWidget {
  const ProductPreviewWidget({super.key, this.name = '', this.price = 0.0});

  final String name;
  final double price;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
      crossAxisSpacing: kSizeMS,
      mainAxisSpacing: kSizeMS,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return ProductCardWidget.preview(
            product: Product(
              id: "",
              name: name,
              code: "",
              price: price,
              createAt: DateTime.now().toString(),
            ),
            onTap: () {},
          );
        }

        return CustomCard(
          padding: anchorAllContent.min(10),
          backgroundColor: lightGrey7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                  color: lightGrey6,
                ),
              ),
              SizedBox(height: kSizeM),
              Padding(
                padding:
                    [
                      anchorLeftContent.min(0, left: kSizeS),
                      anchorBottomContent.min(0, bottom: kSizeS),
                    ].merge,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 15,
                      decoration: BoxDecoration(
                        color: lightGrey6,
                        borderRadius: BorderRadius.circular(kSizeS),
                      ),
                    ),
                    SizedBox(height: kSizeS),
                    Container(
                      width: 100,
                      height: 15,
                      decoration: BoxDecoration(
                        color: lightGrey6,
                        borderRadius: BorderRadius.circular(kSizeS),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
