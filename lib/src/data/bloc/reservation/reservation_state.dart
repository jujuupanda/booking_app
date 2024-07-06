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

class ReservationSuccess extends ReservationState {
  final List<ReservationModel> reservations;

  const ReservationSuccess(this.reservations);
  @override
  List<Object> get props => [];
}

class ReservationFailed extends ReservationState {
  @override
  List<Object> get props => [];
}
