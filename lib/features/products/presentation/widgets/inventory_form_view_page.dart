import '../../../../core/core.dart';
import '../bloc/product_bloc.dart';

class InventoryFormWidget extends StatelessWidget {
  const InventoryFormWidget({
    super.key,
    required this.title,
    required this.onSave,
    required this.child,
    this.onDelete,
  });

  final String title;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseListenerWidget<ProductsBloc, ProductState>(
      listener: (context, state) async {
        if (state is OnSavedForm) {
          context.pop(); // back page from add page
        }
      },
      builder: (context, bloc, state) {
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
                    if (onDelete != null)
                      GradientButton(
                        noShadow: true,
                        backgroundColor: deleteButtonColor,
                        child: Icon(CupertinoIcons.delete, color: Colors.white),
                        onPressed: () => onDelete?.call(),
                      ),
                    SizedBox(width: kSizeM),
                    GradientButton(
                      noShadow: true,
                      width: 190,
                      backgroundColor: successButtonColor,
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
      },
    );
  }
}
