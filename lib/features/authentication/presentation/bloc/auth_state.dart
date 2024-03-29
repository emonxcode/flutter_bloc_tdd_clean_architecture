part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User uid;

  const AuthSuccess({required this.uid});
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}