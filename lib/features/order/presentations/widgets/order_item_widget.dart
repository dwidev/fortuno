// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/features/order/domain/entities/order_item.dart';
import 'package:fortuno/features/order/presentations/bloc/cart/cart_bloc.dart';

import '../../../../core/core.dart';

class CartOrderItem extends StatelessWidget {
  const CartOrderItem({super.key, required this.item});

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSizeMS),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: kSizeXXL * 1.1,
                  width: kSizeXXL * 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://asset.kompas.com/crops/WTuA1Jn_cJEFlr9UgBhA-72n8yI=/3x0:700x465/1200x800/data/photo/2020/12/30/5fec5602f116e.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: darkOliveGreen,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          item.contents,
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IncrementCartWidget(item: item),
        ],
      ),
    );
  }
}

class IncrementCartWidget extends StatelessWidget {
  const IncrementCartWidget({super.key, required this.item});

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    return Row(
      children: [
        ButtonCircleWidget.gradient(
          icon: Icons.remove,
          onPressed: () {
            final q = item.quantity - 1;
            if (q == 0) {
              bloc.add(
                RemoveProductFromCart(
                  categoryProduct: item.category,
                  package: item.package,
                  product: item.product,
                ),
              );
              return;
            }

            bloc.add(
              AddProductToCartEvent(
                categoryProduct: item.category,
                package: item.package,
                product: item.product,
                quantity: q,
              ),
            );
          },
          buttonSize: kSizeM,
        ),
        SizedBox(width: kSizeSS),
        InkWell(
          onTap: () async {
            final newQuantity = await showChangeTotalDialog<int>(
              context: context,
              initial: item.quantity,
            );
            bloc.add(
              AddProductToCartEvent(
                categoryProduct: item.category,
                package: item.package,
                product: item.product,
                quantity: newQuantity ?? item.quantity,
              ),
            );
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: darkColor.withAlpha(100),
                    width: 0.8,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  item.quantity.toString(),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: kSizeS,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: kSizeSS),
        ButtonCircleWidget.gradient(
          icon: Icons.add,
          onPressed: () {
            bloc.add(
              AddProductToCartEvent(
                categoryProduct: item.category,
                package: item.package,
                product: item.product,
                quantity: item.quantity + 1,
              ),
            );
          },
          buttonSize: kSizeM,
        ),
        SizedBox(width: kSizeS),
      ],
    );
  }
}
