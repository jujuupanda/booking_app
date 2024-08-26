part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class InitialReservation extends ReservationEvent {}

class DeleteReservation extends ReservationEvent {
  final String id;

  const DeleteReservation(this.id);
}

class AcceptReservation extends ReservationEvent {
  final String id;

  const AcceptReservation(this.id);
}

class GetReservationCheck extends ReservationEvent {
  final String dateStart;
  final String dateEnd;

  const GetReservationCheck(this.dateStart, this.dateEnd);
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
  final String agency;

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
    this.agency,
  );
}

class GetReservationForUser extends ReservationEvent {}

class GetReservationForAdmin extends ReservationEvent {}
