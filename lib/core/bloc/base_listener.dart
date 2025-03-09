part of 'base_bloc.dart';

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
        if (state is IsLoading && state.opts.active) {
          context.loading();
        }

        if (state is IsLoading && !state.opts.active) {
          if (state.opts.isDialogOrPage) {
            context.popUntil(state.opts.numLayers);
          }
        }

        if (state is OnError) {
          // TODO (fahmi): handle on error UI
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
