import '../../core.dart';

class TimeFormPickerWidget extends StatelessWidget {
  const TimeFormPickerWidget({super.key, required this.title});

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
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: DateTime.now().hour,
                minute: DateTime.now().minute,
              ),
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
                hintText: "00:00 WIB",
                enabled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
