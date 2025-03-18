import '../../../../core/core.dart';
import '../../domain/entities/order.dart';

class OrderPackageWidget extends StatelessWidget {
  final Order order;

  const OrderPackageWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    if (order.items.firstOrNull?.package != null) {
      return Container(
        width: context.width / 4,
        padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeS),
        decoration: BoxDecoration(
          color: lemonChiffonColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.items.firstOrNull?.package?.name ?? "",
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              order.items.firstOrNull?.package?.contents ?? "",
              style: context.textTheme.labelSmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    }

    return Offstage();
  }
}
