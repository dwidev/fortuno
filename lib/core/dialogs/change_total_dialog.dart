import 'package:fortuno/core/widgets/form/text_form_field_widget.dart';

import '../core.dart';

Future<T?> showChangeTotalDialog<T>({
  required BuildContext context,
  required int initial,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: context.width / 3,
          // height: context.height / 3,
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ubah total",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(initial);
                    },
                    icon: Icon(CupertinoIcons.clear, size: kSizeM),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: kSizeM),
              TextFormFieldWidget(
                title: "Total",
                initialValue: initial.toString(),
              ),
              SizedBox(height: kSizeM),
              Align(
                alignment: Alignment.centerRight,
                child: GradientButton(
                  width: 100,
                  onPressed: () {
                    Navigator.of(context).pop(initial);
                  },
                  child: Text("Simpan", style: context.textTheme.bodySmall),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
