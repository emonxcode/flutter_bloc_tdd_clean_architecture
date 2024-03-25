import 'package:bloc_clean_architecture_tdd_solid/features/authentication/domain/usecases/user.signup.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final response = await _userSignUp(UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ));

      response.fold(
        (l) {
          print("failed ${l.message}");
          emit(AuthFailure(message: l.message));
        },
        (r) {
          print("success");
          emit(AuthSuccess(uid: r));
        },
      );
    });
  }
}
