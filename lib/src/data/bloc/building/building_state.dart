part of 'building_bloc.dart';

abstract class BuildingState extends Equatable {
  const BuildingState();
}

class BuildingInitial extends BuildingState {
  @override
  List<Object> get props => [];
}

class BuildingLoading extends BuildingState {
  @override
  List<Object> get props => [];
}

class BuildingGetSuccess extends BuildingState {
  final List<BuildingModel> buildings;

  const BuildingGetSuccess(this.buildings);

  @override
  List<Object> get props => [buildings];
}

class BuildingGetFailed extends BuildingState {
  @override
  List<Object> get props => [];
}

class BuildingAddSuccess extends BuildingState {
  @override
  List<Object> get props => [];
}

class BuildingAddFailed extends BuildingState {
  @override
  List<Object> get props => [];
}
