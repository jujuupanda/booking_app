part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class InitialReservation extends ReservationEvent {}

class CreateReservation extends ReservationEvent {}

class GetReservation extends ReservationEvent {
  final String contactId;

  const GetReservation(this.contactId);
}
