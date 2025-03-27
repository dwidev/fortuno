// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';

import '../../../../core/core.dart';
import 'pick_product_dialog.dart';

class SelectedProductWidget extends StatelessWidget {
  final PickProductDialogOpts opts;

  const SelectedProductWidget({super.key, required this.opts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          opts.data.length > 5 ? opts.data.length + 1 : opts.data.length,
          (index) {
            if (index == 5) {
              return DottedBorder(
                borderType: BorderType.RRect,
                padding: EdgeInsets.all(5),
                radius: Radius.circular(kDefaultRadius * 0.5),
                color: greyColor,
                child: GestureDetector(
                  onTap: () {
                    showPickProductDialog(context: context, opts: opts);
                  },
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 90),
                    padding: EdgeInsets.symmetric(
                      horizontal: kSizeMS,
                      vertical: kSizeM,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kDefaultRadius * 0.5),
                      color: lightGrey7,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            CupertinoIcons.cube_box_fill,
                            size: kSizeM,
                            color: greyColor,
                          ),
                          SizedBox(height: kSizeSS),
                          Text(
                            "Lihat Semua",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            final product = opts.data[index];

            return GestureDetector(
              onTap: () {
                opts.onChange?.call(product);
              },
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultRadius * 0.5),
                  color: lightGrey7,
                  border:
                      opts.selectedData.contains(product)
                          ? Border.all(color: successButtonColor)
                          : null,
                ),
                margin: EdgeInsets.only(right: kSizeS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              kDefaultRadius * 0.5,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://cms.disway.id//uploads/0a89f2c48130e61ec0621d8bdd2d6b74.jpeg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: CheckListWidget(
                            checked: opts.selectedData.contains(product),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kSizeS),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kSizeS),
                      child: Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: kSizeS),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CheckListWidget extends StatelessWidget {
  const CheckListWidget({super.key, required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: checked ? successButtonColor : lightGrey3,
      ),
      child: checked ? Icon(Icons.check, color: Colors.white, size: 16) : null,
    );
  }
}
