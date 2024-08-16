part of 'reservation_bloc.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();
}

class ReservationInitial extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationLoading extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationGetSuccess extends ReservationState {
  final List<ReservationModel> reservations;

  const ReservationGetSuccess(this.reservations);

  @override
  List<Object> get props => [];
}

class ReservationGetFailed extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationCreateSuccess extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationCreateFailed extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationDeleteSuccess extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationDeleteFailed extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationAcceptSuccess extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationAcceptFailed extends ReservationState {
  @override
  List<Object> get props => [];
}
