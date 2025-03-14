import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/widgets/form/text_form_field_widget.dart';

class DateFormPickerWidget extends StatefulWidget {
  const DateFormPickerWidget({
    super.key,
    required this.title,
    this.onChange,
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
  final Function(DateTime date)? onChange;

  @override
  State<DateFormPickerWidget> createState() => _DateFormPickerWidgetState();
}

class _DateFormPickerWidgetState extends State<DateFormPickerWidget> {
  DateTime? value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
        );

        if (date == null) return;
        // TODO: change format
        widget.controller?.text = date.day.toString();
        widget.onChange?.call(date);
        setState(() => value = date);
      },
      child: TextFormFieldWidget(
        controller: widget.controller,
        title: 'Tanggal kirim',
        hintText: "DD/MM/YYYY",
        enable: false,
      ),
    );
  }
}
