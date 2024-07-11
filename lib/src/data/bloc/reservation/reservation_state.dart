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
