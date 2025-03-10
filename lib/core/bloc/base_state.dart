// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'base_bloc.dart';

/// BASE STATE
abstract class BaseState extends Equatable {
  final Failure? error;
  final LoadingOpts loading;

  const BaseState({
    this.loading = const LoadingOpts(active: false),
    this.error,
  });

  @override
  List<Object?> get props => [error, loading];

  BaseState copyWith({LoadingOpts? loading, Failure? error});
}

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
