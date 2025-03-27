import '../../../../core/core.dart';
import '../bloc/order/order_bloc.dart';

class HeaderCreateOrderWidget extends StatelessWidget {
  const HeaderCreateOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final orderBloc = context.read<OrderBloc>();
    return Container(
      margin: anchorCustomAppBar.addTopHeightMenubar(context),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is AtProductPage) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonCircleWidget.gradient(
                  buttonSize: kSizeL * 1.3,
                  icon: CupertinoIcons.back,
                  onPressed: () {
                    orderBloc.add(OnBackToCategory());
                  },
                ),
                SizedBox(width: kSizeML),
                Text(
                  state.categoryProduct.name,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }

          return Text(
            "RM Barokah Catering", // TODO: implement company data
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}
