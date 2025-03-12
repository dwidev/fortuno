import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/order_bloc.dart';

class HeaderCreateOrderWidget extends StatelessWidget {
  const HeaderCreateOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final orderBloc = context.read<OrderBloc>();
    return Container(
      padding: EdgeInsets.all(
        kDefaultPadding,
      ).copyWith(top: kDefaultPadding * 2, bottom: 10),
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
            "RM Barokah Catering",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}
