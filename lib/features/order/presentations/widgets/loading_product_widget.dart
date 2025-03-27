// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/core.dart';
import '../pages/create_order/create_order_page.dart';

class LoadingProductWidget extends StatelessWidget {
  final int? crossAxisCount;
  const LoadingProductWidget({super.key, this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? CreateOrderPage.crossMaxItem,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.8,
      ),
      itemCount: 9,
      padding: EdgeInsets.all(kDefaultPadding),
      itemBuilder: (context, index) {
        return Container(
              decoration: BoxDecoration(
                color: shimmerBaseColor,
                borderRadius: BorderRadius.circular(kDefaultRadius - 2),
              ),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(
              duration: 1500.ms,
              angle: 0,
              delay: 500.ms,
              color: shimmerHighlightColor,
            );
      },
    );
  }
}
