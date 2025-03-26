import 'package:dotted_border/dotted_border.dart';
import 'package:fortuno/core/core.dart';

class AddInventoryWidget extends StatelessWidget {
  const AddInventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      color: lightGrey4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Ink(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Tambah", style: context.textTheme.bodyMedium)],
          ),
        ),
      ),
    );
  }
}
