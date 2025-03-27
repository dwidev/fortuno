import 'package:dotted_border/dotted_border.dart';
import '../../../../core/core.dart';
import 'pick_product_dialog.dart';

class SelectedProductWidget extends StatelessWidget {
  const SelectedProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (index) {
          if (index == 5) {
            return DottedBorder(
              borderType: BorderType.RRect,
              padding: EdgeInsets.all(5),
              radius: Radius.circular(kDefaultRadius * 0.5),
              color: greyColor,
              child: GestureDetector(
                onTap: () {
                  final opts = PickProductDialogOpts(title: "Pilih Product");
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

          return Container(
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultRadius * 0.5),
              color: lightGrey7,
              border:
                  index == 1
                      ? Border.all(color: primaryColor, width: 0.7)
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
                      child: CheckListWidget(checked: index == 1),
                    ),
                  ],
                ),
                SizedBox(height: kSizeS),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kSizeS),
                  child: Text(
                    "Nasi Box",
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
          );
        }),
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
        color: checked ? primaryColor : lightGrey3,
      ),
      child: checked ? Icon(Icons.check, color: Colors.white, size: 16) : null,
    );
  }
}
