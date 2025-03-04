import 'package:fortuno/core/core.dart';

class DateFormPickerWidget extends StatelessWidget {
  const DateFormPickerWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: kSizeMS),
        InkWell(
          onTap: () {
            showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2050),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSizeMS),
              color: darkLightColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: kSizeMS),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "DD/MM/YYYY",
                enabled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
