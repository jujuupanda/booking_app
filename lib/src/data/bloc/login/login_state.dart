part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  final String error;

  const LoginFailed(this.error);

  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LogoutFailed extends LoginState {
  @override
  List<Object> get props => [];
}

class IsAuthenticated extends LoginState {
  @override
  List<Object> get props => [];
}

class IsAdmin extends LoginState {
  @override
  List<Object> get props => [];
}

class IsUser extends LoginState {
  @override
  List<Object> get props => [];
}

class UnAuthenticated extends LoginState {
  @override
  List<Object> get props => [];
}
