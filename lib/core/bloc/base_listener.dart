import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../core.dart';
import 'base_bloc.dart';

class BaseListenerWidget<P extends BaseAppBloc, B extends BaseState>
    extends StatelessWidget {
  const BaseListenerWidget({
    super.key,
    required this.listener,
    required this.builder,
  });

  final Function(BuildContext context, BaseState state)? listener;
  final Function(BuildContext context, P state) builder;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<P>();

    return BlocListener<P, BaseState>(
      listener: (context, state) {
        if (state is IsLoading) {
          context.loading();
        }

        if (state is HideLoading) {
          context.popUntil(state.numLayers);
        }

        if (state is OnError) {
          print("ON ERROR $e");
        }

        onListener(context, state);
      },
      child: builder(context, provider),
    );
  }

  void onListener(BuildContext context, BaseState state) {
    listener?.call(context, state);
  }
}
