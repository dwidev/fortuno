import 'package:fortuno/core/core.dart';

class OrderActionWidget extends StatelessWidget {
  const OrderActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonCircleWidget.gradient(
          icon: CupertinoIcons.printer,
          onPressed: () {},
        ),
        SizedBox(width: kSizeS),
        ButtonCircleWidget.gradient(
          gradiendBackgroundColor: [darkColor, Colors.blueAccent],
          icon: CupertinoIcons.pencil,
          onPressed: () {},
        ),
        SizedBox(width: kSizeS),
        ButtonCircleWidget.gradient(
          gradiendBackgroundColor: [darkColor, Colors.redAccent],
          icon: CupertinoIcons.trash,
          onPressed: () {},
        ),
      ],
    );
  }
}
