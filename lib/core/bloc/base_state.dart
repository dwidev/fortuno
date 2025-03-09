part of 'base_bloc.dart';

/// BASE STATE
abstract class BaseState extends Equatable {}

class LoadingOpts extends Equatable {
  final bool active;
  final int numLayers;
  final bool isDialogOrPage;

  const LoadingOpts({
    required this.active,
    this.numLayers = 1,
    this.isDialogOrPage = true,
  }) : assert(
         numLayers >= 1 || isDialogOrPage == true,
         'num layers cannot be lower than 1',
       );

  @override
  List<Object?> get props => [active, numLayers, isDialogOrPage];

  LoadingOpts copyWith({bool? active, int? numLayers, bool? isDialogOrPage}) {
    return LoadingOpts(
      active: active ?? this.active,
      numLayers: numLayers ?? this.numLayers,
      isDialogOrPage: isDialogOrPage ?? this.isDialogOrPage,
    );
  }
}

class IsLoading extends BaseState {
  final LoadingOpts opts;

  IsLoading({this.opts = const LoadingOpts(active: true)});

  @override
  List<Object?> get props => [opts];
}

class OnError extends BaseState {
  final Failure error;

  OnError({required this.error});

  @override
  List<Object?> get props => [error];
}
