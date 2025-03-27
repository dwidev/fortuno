import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/core.dart';
import '../../../order/presentations/widgets/package_card_widget.dart';
import '../../domain/entities/package.dart';

class PackagePreviewWidget extends StatelessWidget {
  const PackagePreviewWidget({super.key, this.name = '', this.price = 0.0});

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
          return PackageCardWidget(
            onTap: () {},
            package: Package.dummy(),
            quantity: 0,
            disable: false,
          );
        }

        return CustomCard(
          padding: anchorAllContent.min(10),
          backgroundColor: lightGrey7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: lightGrey6,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    SizedBox(width: kSizeS),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 20,
                          decoration: BoxDecoration(
                            color: lightGrey6,
                            borderRadius: BorderRadius.circular(kSizeS),
                          ),
                        ),
                        SizedBox(height: kSizeS),
                        Container(
                          width: 60,
                          height: 15,
                          decoration: BoxDecoration(
                            color: lightGrey6,
                            borderRadius: BorderRadius.circular(kSizeS),
                          ),
                        ),
                      ],
                    ),
                  ],
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
