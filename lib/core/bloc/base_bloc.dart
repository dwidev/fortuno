import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortuno/core/failures/failure.dart';

import '../usecases/base_usecase.dart';

/// BASE STATE
abstract class BaseState extends Equatable {}

class IsLoading extends BaseState {
  @override
  List<Object?> get props => [];
}

class HideLoading extends BaseState {
  final int numLayers;

  HideLoading({this.numLayers = 1})
    : assert(numLayers >= 1, 'num layers cannot be lower than 1');

  @override
  List<Object?> get props => [numLayers];
}

class OnError extends BaseState {
  final Failure error;

  OnError({required this.error});

  @override
  List<Object?> get props => [error];
}

/// Base event
abstract class BaseEvent extends Equatable {}

/// Base bloc
abstract class BaseAppBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, BaseState> {
  BaseAppBloc(S super.initialState);

  /// Function for execute single usecase the process wrap the loding
  Future<ReturnFailure<T>> runUsecase<T>(
    Future<ReturnFailure<T>> Function() execute,
    Emitter emit, {
    int backTo = 1,
  }) async {
    emit(IsLoading());

    final res = await execute();

    emit(HideLoading(numLayers: backTo));

    return res;
  }

  /// Function for execute multiple usecase the process wrap the loding
  Future<List<ReturnFailure<T>>> runUsecases<T>(
    List<Future<ReturnFailure<T>> Function()> executes,
    Emitter emit, {
    asyncFunc = false,
    int backTo = 1,
  }) async {
    emit(IsLoading());

    List<ReturnFailure<T>> res = [];

    if (asyncFunc) {
      res = await Future.wait(executes.map((run) => run()));
    } else {
      for (var run in executes) {
        final r = await run();
        res.add(r);
      }
    }

    emit(HideLoading(numLayers: backTo));

    return res.toList();
  }
}
