part of 'building_bloc.dart';

abstract class BuildingEvent extends Equatable {
  const BuildingEvent();

  @override
  List<Object> get props => [];
}

class InitialBuilding extends BuildingEvent {}

class GetBuilding extends BuildingEvent {}

class AddBuilding extends BuildingEvent {
  final String name;
  final String description;
  final String facility;
  final int capacity;
  final String rule;
  final String image;

  const AddBuilding(
    this.name,
    this.description,
    this.facility,
    this.capacity,
    this.rule,
    this.image,
  );
}

class EditBuilding extends BuildingEvent {}

class DeleteBuilding extends BuildingEvent {}
