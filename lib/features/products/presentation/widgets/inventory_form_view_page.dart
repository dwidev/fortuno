import '../../../../core/core.dart';

class InventoryFormWidget extends StatelessWidget {
  const InventoryFormWidget({
    super.key,
    required this.title,
    required this.onSave,
    required this.child,
  });

  final String title;
  final VoidCallback onSave;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(title),
              backgroundColor:
                  innerBoxIsScrolled ? Colors.white : Colors.transparent,
              pinned: true,
              elevation: 0,
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: successButtonColor,
                  ),
                  onPressed: onSave,
                  child: Text(
                    "Simpan",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ];
        },
        body: Container(
          height: context.height,
          margin: anchorAllContent,
          child: SingleChildScrollView(child: child),
        ),
      ),
    );
  }
}
