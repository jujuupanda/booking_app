part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class InitialUser extends UserEvent {}

class GetUser extends UserEvent {}

class EditSingleUser extends UserEvent {
  final String id;
  final String agency;
  final String username;
  final String password;
  final String fullName;
  final String email;
  final String phone;
  final String image;

  const EditSingleUser(
      this.id,
      this.agency,
      this.username,
      this.password,
      this.fullName,
      this.email,
      this.phone,
      this.image,
      );
}

