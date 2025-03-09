import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortuno/core/failures/failure.dart';

/// BASE STATE
abstract class BaseState extends Equatable {}

class IsLoading extends BaseState {
  @override
  List<Object?> get props => [];
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
}
