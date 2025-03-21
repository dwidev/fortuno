import 'package:fortuno/core/widgets/form/text_form_field_widget.dart';

import '../core.dart';

Future<T?> showChangeTotalDialog<T>({
  required BuildContext context,
  required int initial,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(child: _TotalDialogPage(inital: initial));
    },
  );
}

class _TotalDialogPage extends StatefulWidget {
  const _TotalDialogPage({required this.inital});

  final int inital;

  @override
  State<_TotalDialogPage> createState() => _TotalDialogPageState();
}

class _TotalDialogPageState extends State<_TotalDialogPage> {
  late TextEditingController controller;
  late GlobalKey<FormState> key;

  int get resultValue => int.tryParse(controller.text) ?? widget.inital;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.inital.toString());
    key = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
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
                    Navigator.of(context).pop(widget.inital);
                  },
                  icon: Icon(CupertinoIcons.clear, size: kSizeM),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: kSizeM),
                    TextFormFieldWidget(
                      controller: controller,
                      title: "Total",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Nilai tidak boleh kosong";
                        }

                        if ((int.tryParse(value) ?? 0) < 0) {
                          return "Nilai kurang dari 0";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: kSizeM),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GradientButton(
                        width: 100,
                        onPressed: () {
                          if (key.currentState?.validate() == false) return;

                          Navigator.of(context).pop(resultValue);
                        },
                        child: Text(
                          "Simpan",
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
