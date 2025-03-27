import 'package:flutter/services.dart';

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
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final String? initialValue;
  final int maxLines;
  final String? Function(String value)? validator;
  final bool optional;
  final bool enable;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;
  final Function(String value)? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        if (title.isNotEmpty) SizedBox(height: kSizeMS),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          initialValue: initialValue,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            enabled: enable,
            hintText: hintText.isEmpty ? "Masukan $title" : hintText,
            hintStyle: context.textTheme.bodySmall?.copyWith(color: lightGrey2),
          ),
          style: context.textTheme.bodySmall,
          validator: (value) {
            if (optional) return null;

            if (value != null && value.isEmpty) {
              return '$title wajib di isi!';
            }

            return validator?.call(value!);
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
