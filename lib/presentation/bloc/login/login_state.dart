part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginEntity login;

  const LoginSuccess(this.login);

  @override
  List<Object> get props => [login];
}

final class LoginFailure extends LoginState {
  final ErrorEntity error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
