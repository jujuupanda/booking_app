part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitialLogin extends LoginEvent {}

class OnLogin extends LoginEvent {
  final String username;
  final String password;

  const OnLogin(this.username, this.password);
}

class OnLogout extends LoginEvent {}
