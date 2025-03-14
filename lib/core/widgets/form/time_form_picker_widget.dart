import 'package:fortuno/core/widgets/form/text_form_field_widget.dart';

import '../../core.dart';

class TimeFormPickerWidget extends StatefulWidget {
  const TimeFormPickerWidget({
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
  final Function(TimeOfDay date)? onChange;

  @override
  State<TimeFormPickerWidget> createState() => _TimeFormPickerWidgetState();
}

class _TimeFormPickerWidgetState extends State<TimeFormPickerWidget> {
  TimeOfDay? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  value ??
                  TimeOfDay(
                    hour: DateTime.now().hour,
                    minute: DateTime.now().minute,
                  ),
            );

            if (time == null) return;
            String formattedTime =
                "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

            widget.controller?.text = formattedTime;
            widget.onChange?.call(time);
            setState(() {
              value = time;
            });
          },
          child: TextFormFieldWidget(
            controller: widget.controller,
            title: 'Jam',
            hintText: "00:00 WIB",
            enable: false,
          ),
        ),
      ],
    );
  }
}
