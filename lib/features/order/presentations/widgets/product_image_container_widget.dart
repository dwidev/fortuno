// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/core.dart';
import '../../../products/domain/entities/inventory.dart';

class ProductImageContainer extends StatelessWidget {
  final bool isDisable;
  final Inventory data;

  final double? width;
  final double? height;
  final Color? backgroundColor;

  const ProductImageContainer({
    super.key,
    this.isDisable = false,
    required this.data,
    this.width,
    this.height,
    this.backgroundColor = lightGrey8,
  });

  String get initial {
    final list = data.name.split(" ");
    final inital =
        list.map((e) {
          if (e.isNotEmpty) {
            return e[0].toUpperCase();
          }

          return "";
        }).join();
    return inital.length > 3 ? inital.substring(0, 3) : inital;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kSizeMS),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kSizeMS),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            isDisable ? Colors.grey : Colors.transparent,
            isDisable ? BlendMode.saturation : BlendMode.dst,
          ),
          child:
              data.image.exist
                  ? data.image.ispreview
                      ? Image.memory(data.image.byte!, fit: BoxFit.cover)
                      : Image.network(data.image.link, fit: BoxFit.cover)
                  : Center(
                    child: Padding(
                      padding: EdgeInsets.all(kSizeMS),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          !data.isDefaultName ? initial : "",
                          style: context.textTheme.displayLarge?.copyWith(
                            color: lightGrey4,
                          ),
                        ),
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
