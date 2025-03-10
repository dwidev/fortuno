part of 'base_bloc.dart';

class BaseListenerWidget<P extends BaseAppBloc, B extends BaseState>
    extends StatelessWidget {
  const BaseListenerWidget({
    super.key,
    required this.listener,
    required this.builder,
  });

  /// if [overrideListener] its then just run the onListenerFunctions
  bool get overrideListener => false;

  final Function(BuildContext context, BaseState state)? listener;
  final Function(BuildContext context, P state) builder;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<P>();

    return BlocListener<P, BaseState>(
      listener: (context, state) {
        if (overrideListener) {
          onListener(context, state);
          return;
        }

        if (state.loading.active) {
          context.loading();
        }

        if (!state.loading.active) {
          if (state.loading.isDialogOrPage) {
            context.popUntil(state.loading.numLayers);
          }
        }

        handlerError(state);

        onListener(context, state);
      },
      child: builder(context, provider),
    );
  }

  void onListener(BuildContext context, BaseState state) {
    listener?.call(context, state);
  }

  static void handlerError(BaseState state) {
    if (state.error != null) {
      debugPrint("${state.error}");
      // TODO (fahmi): handle on error UI
    }
  }
}
