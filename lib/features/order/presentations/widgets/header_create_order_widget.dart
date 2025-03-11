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
      ).copyWith(top: kDefaultPadding * 2, bottom: 0),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is AtProductPage) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonCircleWidget.gradient(
                  buttonSize: kSizeL,
                  icon: CupertinoIcons.back,
                  onPressed: () {
                    orderBloc.add(OnBackToCategory());
                  },
                ),
                SizedBox(width: kSizeM),
                Text(
                  state.categoryProduct.name,
                  style: context.textTheme.titleLarge,
                ),
              ],
            );
          }

          return Text(
            "RM Barokah Catering",
            style: context.textTheme.titleLarge,
          );
        },
      ),
    );
  }
}
