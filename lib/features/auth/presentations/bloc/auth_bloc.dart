// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import 'package:fortuno/core/failures/failure.dart';
import 'package:fortuno/features/auth/domain/usecases/check_authorize.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/signin_with_google.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends BaseAppBloc<AuthEvent, AuthState> {
  final SignWithGoogle signWithGoogle;
  final SignOut signOut;
  final CheckAuthorize checkAuthorize;

  AuthBloc({
    required this.signWithGoogle,
    required this.signOut,
    required this.checkAuthorize,
  }) : super(AuthInitial()) {
    on<OnSignWithGoogleEvent>(_onSignWithEmail);
    on<OnSignOutEvent>(_onSignOut);
    on<OnCheckAuthorize>(_onCheckAuthorize);
  }

  Future<void> _onSignWithEmail(
    OnSignWithGoogleEvent event,
    Emitter emit,
  ) async {
    final response = await runUsecase(() => signWithGoogle(null), emit);

    response.fold(
      (err) {
        error(emit, err);
      },
      (right) {
        emit(AuthSucces(isLoggin: right));
      },
    );
  }

  Future<void> _onSignOut(OnSignOutEvent event, Emitter emit) async {
    final response = await runUsecase(() => signOut(null), emit);

    response.fold(
      (err) {
        error(emit, err);
      },
      (right) {
        emit(LoggedOut());
      },
    );
  }

  Future<void> _onCheckAuthorize(OnCheckAuthorize event, Emitter emit) async {
    final response = await checkAuthorize(null);

    response.fold(
      (err) {
        emit(LoggedOut());
      },
      (right) {
        if (right) {
          emit(AuthSucces(isLoggin: right));
        } else {
          emit(LoggedOut());
        }
      },
    );
  }
}
