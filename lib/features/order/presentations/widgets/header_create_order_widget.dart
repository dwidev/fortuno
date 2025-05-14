import '../../../../core/core.dart';
import '../bloc/order/order_bloc.dart';

class HeaderCreateOrderWidget extends StatelessWidget {
  const HeaderCreateOrderWidget({
    super.key,
    required this.onSaveCustomePackage,
  });

  final VoidCallback onSaveCustomePackage;

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
                if (state is! OnSelectingCustomPackage) ...[
                  ButtonCircleWidget.gradient(
                    buttonSize: kSizeL * 1.3,
                    icon: CupertinoIcons.back,
                    onPressed: () {
                      orderBloc.add(OnBackToCategory());
                    },
                  ),
                  SizedBox(width: kSizeML),
                ],
                if (state is OnSelectingCustomPackage) ...[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Silahkan pilih product untuk ",
                                  style: context.textTheme.bodyLarge,
                                ),
                                TextSpan(
                                  text: state.selectedPackage.name,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onSaveCustomePackage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: successButtonColor,
                          ),
                          child: Text(
                            "Simpan",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Text(
                    state.categoryProduct.name,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
