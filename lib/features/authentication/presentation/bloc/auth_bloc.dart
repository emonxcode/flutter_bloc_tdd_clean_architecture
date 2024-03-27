import 'package:bloc_clean_architecture_tdd_solid/features/authentication/domain/usecases/user.login.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/domain/usecases/user.signup.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.entity.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(UserSignUpParams(
      email: event.email,
      password: event.password,
      name: event.name,
    ));

    response.fold(
      (l) {
        emit(AuthFailure(message: l.message));
      },
      (r) {
        emit(AuthSuccess(uid: r));
      },
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (l) {
        emit(AuthFailure(message: l.message));
      },
      (r) {
        emit(AuthSuccess(uid: r));
      },
    );
  }
}
