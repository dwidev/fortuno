import '../../core.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.title,
    this.initialValue,
    this.hintText = '',
    this.maxLines = 1,
  });

  final String title;
  final String hintText;
  final String? initialValue;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        if (title.isNotEmpty) SizedBox(height: kSizeMS),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kSizeMS),
            color: darkLightColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: kSizeMS),
          child: TextFormField(
            initialValue: initialValue,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText.isEmpty ? "Masukan $title" : hintText,
            ),
          ),
        ),
      ],
    );
  }
}
