import '../../core.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.title,
    this.controller,
    this.initialValue,
    this.hintText = '',
    this.maxLines = 1,
    this.validator,
    this.optional = false,
    this.enable = true,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
  });

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final String? initialValue;
  final int maxLines;
  final String? Function(String? value)? validator;
  final bool optional;
  final bool enable;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;
  final Function(String value)? onEditingComplete;

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
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            enabled: enable,
            filled: true,
            fillColor: darkLightColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kSizeMS),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: lemonChiffonColor),
            ),
            hintText: hintText.isEmpty ? "Masukan $title" : hintText,
            hintStyle: TextStyle(color: darkColor.withAlpha(100)),
          ),
          style: TextStyle(color: darkColor),
          validator: (value) {
            if (optional) {
              return validator?.call(value);
            }

            if (value != null && value.isEmpty) {
              return '$title wajib di isi!';
            }

            return null;
          },
          onChanged: (value) {
            onChanged?.call(value);
          },
          onEditingComplete: () {
            onEditingComplete?.call(controller?.text ?? '');
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }
}
