part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserGetSuccess extends UserState {
  final UserModel user;

  const UserGetSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserGetFailed extends UserState {
  @override
  List<Object> get props => [];
}
class EditSingleUserSuccess extends UserState {
  @override
  List<Object> get props => [];
}
