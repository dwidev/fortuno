import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fortuno/core/dialogs/error_dialog.dart';
import '../core.dart';
import '../failures/failure.dart';

import '../usecases/base_usecase.dart';

part 'base_event.dart';
part 'base_listener.dart';
part 'base_state.dart';

/// Base bloc
abstract class BaseAppBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseAppBloc(super.initialState);

  void loading(Emitter emit) {
    if (state.loading.active) return;
    final newState = state.copyWith(
      loading: state.loading.copyWith(active: true),
      error: () => null,
    );
    emit(newState);
  }

  void hideLoading(Emitter emit) {
    if (!state.loading.active) return;
    final newState = state.copyWith(
      loading: state.loading.copyWith(active: false),
      error: () => null,
    );
    emit(newState);
  }

  void error(Emitter emit, Failure error) {
    final newState = state.copyWith(error: () => error);
    emit(newState);
  }

  /// Function for execute single usecase the process wrap the loding
  Future<ReturnFailure<T>> runUsecase<T>(
    Future<ReturnFailure<T>> Function() execute,
    Emitter emit,
  ) async {
    loading(emit);

    final res = await execute();

    hideLoading(emit);

    return res;
  }

  /// Function for execute multiple usecase the process wrap the loding
  Future<List<ReturnFailure<T>>> runUsecases<T>(
    List<Future<ReturnFailure<T>> Function()> executes,
    Emitter emit, {
    asyncFunc = true,
  }) async {
    loading(emit);

    List<ReturnFailure<T>> res = [];

    if (asyncFunc) {
      // asyncronus process
      res = await Future.wait(executes.map((fn) => fn()));
    } else {
      // sequential process
      for (final fn in executes) {
        final r = await fn();
        res.add(r);
      }
    }

    hideLoading(emit);

    return res;
  }
}
