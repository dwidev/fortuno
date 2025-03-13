import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/widgets/form/text_form_field_widget.dart';

class DateFormPickerWidget extends StatelessWidget {
  const DateFormPickerWidget({
    super.key,
    required this.title,
    this.validator,
    this.optional = false,
    this.controller,
    this.hintText = "",
    this.initialValue,
  });

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final String? initialValue;
  final String? Function(String? value)? validator;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
        );
      },
      child: TextFormFieldWidget(
        controller: controller,
        title: 'Tanggal kirim',
        hintText: "DD/MM/YYYY",
        enable: false,
      ),
    );
  }
}
