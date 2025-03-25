import '../core.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.value,
    required this.menus,
    required this.changeMenu,
  });

  final String value;
  final List<String> menus;
  final Function(String menu) changeMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          menus
              .map(
                (e) => TextButton(
                  onPressed: () => changeMenu(e),
                  child: Text(
                    e,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: e == value ? darkColor : lightGrey1,
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}
