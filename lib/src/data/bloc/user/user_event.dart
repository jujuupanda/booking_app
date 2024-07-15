part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class InitialUser extends UserEvent {}

class GetUser extends UserEvent {}
