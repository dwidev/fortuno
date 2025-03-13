import 'package:fortuno/core/widgets/form/text_form_field_widget.dart';

import '../../core.dart';

class TimeFormPickerWidget extends StatelessWidget {
  const TimeFormPickerWidget({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: DateTime.now().hour,
                minute: DateTime.now().minute,
              ),
            );
          },
          child: TextFormFieldWidget(
            controller: controller,
            title: 'Jam',
            hintText: "00:00 WIB",
            enable: false,
          ),
        ),
      ],
    );
  }
}
