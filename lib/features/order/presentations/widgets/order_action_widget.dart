import '../../../../core/core.dart';
import '../../../payments/invoice.dart';
import '../../domain/entities/order.dart';
import '../../domain/enums/order_status.dart';

class OrderActionWidget extends StatelessWidget {
  final Order order;

  const OrderActionWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonCircleWidget.gradient(
          buttonSize: 35,
          icon: CupertinoIcons.printer,
          onPressed: () {
            InvoiceService.showPdf(order);
          },
        ),
        if (order.orderStatus == OrderStatus.waiting) ...[
          SizedBox(width: kSizeS),
          ButtonCircleWidget.gradient(
            buttonSize: 35,
            gradiendBackgroundColor: [darkColor, Colors.blueAccent],
            icon: CupertinoIcons.pencil,
            onPressed: () {},
          ),
          SizedBox(width: kSizeS),
          ButtonCircleWidget.gradient(
            buttonSize: 35,
            gradiendBackgroundColor: [darkColor, Colors.redAccent],
            icon: CupertinoIcons.trash,
            onPressed: () {},
          ),
        ],
      ],
    );
  }
}
