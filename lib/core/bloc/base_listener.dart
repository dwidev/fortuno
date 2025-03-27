part of 'base_bloc.dart';

class BaseListenerWidget<P extends BaseAppBloc, S extends BaseState>
    extends StatelessWidget {
  const BaseListenerWidget({
    super.key,
    this.listenWhen,
    this.listener,
    required this.builder,
  });

  /// if [overrideListener] true its then just run the onListenerFunctions
  bool get overrideListener => false;

  /// if [overrideLoading] true the loading listener do not running
  bool get overrideLoading => false;

  final BlocListenerCondition<BaseState>? listenWhen;
  final Function(BuildContext context, BaseState state)? listener;
  final Function(BuildContext context, P bloc, BaseState state) builder;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<P>();
    final state = context.watch<P>().state;

    return BlocListener<P, BaseState>(
      listenWhen: listenWhen,
      listener: (context, state) {
        // adding overiding listener for some children class
        // and ignore the base listener (or the code below)
        if (overrideListener) {
          onListener(context, state);
          return;
        }

        // listen the loading state
        if (!overrideLoading) handlerLoadingDialog(context, state);

        // listen the error state
        handlerError(context, state);

        // adding some optional listener for children class
        onListener(context, state);
      },
      child: builder(context, bloc, state),
    );
  }

  void onListener(BuildContext context, BaseState state) {
    listener?.call(context, state);
  }

  static void handlerLoadingDialog(BuildContext context, BaseState state) {
    if (state.loading.active) {
      EasyLoading.show(
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.clear,
      );
    }

    if (!state.loading.active) {
      EasyLoading.dismiss();
    }
  }

  static void handlerError(BuildContext context, BaseState state) {
    if (state.error is NotFoundCompanyID) {
      context.read<AuthBloc>().add(OnSignOutEvent());
      return;
    }

    if (state.error != null) {
      showErrorDialog(
        context: context,
        failure: state.error!,
        onOke: () {
          context.pop();
        },
      );
    }
  }
}
