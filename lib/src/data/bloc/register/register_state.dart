part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
}

final class RegisterInitialState extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterFailed extends RegisterState {
  final String error;

  const RegisterFailed(this.error);

  @override
  List<Object> get props => [error];
}

class GetAllUserSuccess extends RegisterState {
  final List<UserModel> listUser;

  const GetAllUserSuccess(this.listUser);

  @override
  List<Object> get props => [listUser];
}

class DeleteSuccess extends RegisterState {
  @override
  List<Object> get props => [];
}