part of 'base_bloc.dart';

class BaseListenerWidget<P extends BaseAppBloc, B extends BaseState>
    extends StatelessWidget {
  const BaseListenerWidget({
    super.key,
    required this.listener,
    required this.builder,
  });

  /// if [overrideListener] true its then just run the onListenerFunctions
  bool get overrideListener => false;

  /// if [overrideLoading] true the loading listener do not running
  bool get overrideLoading => false;

  final Function(BuildContext context, BaseState state)? listener;
  final Function(BuildContext context, P state) builder;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<P>();

    return BlocListener<P, BaseState>(
      listener: (context, state) {
        // adding overiding listener for some class parent
        // and ignore the base listener (or the code below)
        if (overrideListener) {
          onListener(context, state);
          return;
        }

        // listen the loading state
        if (!overrideLoading) handlerLoadingDialog(state, context);

        // listen the error state
        handlerError(state);

        // adding some optional listener for some class parent
        onListener(context, state);
      },
      child: builder(context, provider),
    );
  }

  void onListener(BuildContext context, BaseState state) {
    listener?.call(context, state);
  }

  static void handlerLoadingDialog(BaseState state, BuildContext context) {
    if (state.loading.active) {
      context.loading();
    }

    if (!state.loading.active) {
      if (state.loading.isDialogOrPage) {
        context.popUntil(state.loading.numLayers);
      }
    }
  }

  static void handlerError(BaseState state) {
    if (state.error != null) {
      debugPrint("${state.error}");
      // TODO (fahmi): handle on error UI
    }
  }
}
