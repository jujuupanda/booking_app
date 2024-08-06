part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class InitialReservation extends ReservationEvent {}

class DeleteReservation extends ReservationEvent {
  final String id;

  const DeleteReservation (this.id);
}

class CreateReservation extends ReservationEvent {
  final String buildingName;
  final String contactId;
  final String contactName;
  final String contactEmail;
  final String contactPhone;
  final String dateStart;
  final String dateEnd;
  final String dateCreated;
  final String information;

  const CreateReservation(
    this.buildingName,
    this.contactId,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.dateStart,
    this.dateEnd,
    this.dateCreated,
    this.information,
  );
}

class GetReservation extends ReservationEvent {}
