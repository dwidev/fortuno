import '../core.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.currentIndex,
    required this.menus,
    required this.changeMenu,
  });

  final List<String> menus;
  final int currentIndex;
  final Function(int index) changeMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          menus
              .asMap()
              .map(
                (index, data) => MapEntry(
                  index,
                  TextButton(
                    onPressed: () => changeMenu(index),
                    child: Text(
                      data,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: index == currentIndex ? darkColor : lightGrey1,
                      ),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
    );
  }
}
