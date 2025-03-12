import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/failures/failure.dart';

import '../usecases/base_usecase.dart';

part 'base_event.dart';
part 'base_listener.dart';
part 'base_state.dart';

/// Base bloc
abstract class BaseAppBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseAppBloc(super.initialState);

  void loading(Emitter emit, LoadingOpts loadingOpts) {
    final newState = state.copyWith(loading: loadingOpts);
    emit(newState);
  }

  void error(Emitter emit, Failure error) {
    final newState = state.copyWith(error: error);
    emit(newState);
  }

  /// Function for execute single usecase the process wrap the loding
  Future<ReturnFailure<T>> runUsecase<T>(
    Future<ReturnFailure<T>> Function() execute,
    Emitter emit, {
    LoadingOpts loadingOpts = const LoadingOpts(active: true),
  }) async {
    loading(emit, loadingOpts);

    final res = await execute();

    final hideOpts = loadingOpts.copyWith(active: false);
    loading(emit, hideOpts);

    return res;
  }

  /// Function for execute multiple usecase the process wrap the loding
  Future<List<ReturnFailure<T>>> runUsecases<T>(
    List<Future<ReturnFailure<T>> Function()> executes,
    Emitter emit, {
    asyncFunc = true,
    LoadingOpts loadingOpts = const LoadingOpts(active: true),
  }) async {
    loading(emit, loadingOpts);

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

    final hideOpts = loadingOpts.copyWith(active: false);
    loading(emit, hideOpts);

    return res;
  }
}
