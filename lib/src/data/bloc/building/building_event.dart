part of 'building_bloc.dart';

abstract class BuildingEvent extends Equatable {
  const BuildingEvent();

  @override
  List<Object> get props => [];
}

class InitialBuilding extends BuildingEvent {}

class GetBuilding extends BuildingEvent {}

class AddBuilding extends BuildingEvent {}

class EditBuilding extends BuildingEvent {}

class DeleteBuilding extends BuildingEvent {}
