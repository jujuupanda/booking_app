part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class InitialHistory extends HistoryEvent {}

class GetHistory extends HistoryEvent {}

class CreateHistory extends HistoryEvent {
  final String buildingName;
  final String dateStart;
  final String dateEnd;
  final String dateCreated;
  final String contactId;
  final String contactName;
  final String information;
  final String status;

  const CreateHistory(
    this.buildingName,
    this.dateStart,
    this.dateEnd,
    this.dateCreated,
    this.contactId,
    this.contactName,
    this.information,
    this.status,
  );
}
