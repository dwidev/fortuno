import '../../core.dart';
import 'text_form_field_widget.dart';

part 'controller/idr_textediting_controller.dart';

class CurrencyFormFieldWidget extends StatelessWidget {
  const CurrencyFormFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    this.hintText = '',
    this.validator,
    this.enable = true,
    this.onChanged,
    this.onEditingComplete,
  });

  final TextEditingIDRController controller;
  final String title;
  final String hintText;
  final String? Function(double value)? validator;
  final bool enable;
  final Function(String value)? onChanged;
  final Function(double value)? onEditingComplete;

  CurrencyTextInputFormatter get _formatter => controller.formatter;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              enable: enable,
              title: title,
              hintText: hintText,
              keyboardType: TextInputType.number,
              controller: controller,
              inputFormatters: [_formatter],
              validator: (value) {
                final value = _formatter.getUnformattedValue();

                if (value <= 0) {
                  return hintText;
                }

                return validator?.call(value.toDouble());
              },
              onChanged: (value) {
                onChanged?.call(value);
              },
              onEditingComplete: (value) {
                final value = controller.getDoubleValue();
                onEditingComplete?.call(value);
              },
            ),
          ],
        );
      },
    );
  }
}
