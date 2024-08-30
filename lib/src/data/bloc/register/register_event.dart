part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

final class InitialRegisterEvent extends RegisterEvent {

}

class Register extends RegisterEvent {
  final String agency;
  final String username;
  final String password;
  final String fullName;
  final String role;

  const Register(
      this.agency,
      this.username,
      this.password,
      this.fullName,
      this.role,
      );
}

class GetAllUser extends RegisterEvent {}

class EditUser extends RegisterEvent {}

class DeleteUser extends RegisterEvent {
  final String id;

  const DeleteUser(this.id);
}
