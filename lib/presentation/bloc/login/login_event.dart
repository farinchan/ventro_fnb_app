part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginRequested extends LoginEvent {
  final String login;
  final String password;

  const LoginRequested({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}
