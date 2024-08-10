import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/building_model.dart';
import '../../repositories/repositories.dart';

part 'building_event.dart';

part 'building_state.dart';

class BuildingBloc extends Bloc<BuildingEvent, BuildingState> {
  Repositories repositories;

  BuildingBloc({required this.repositories}) : super(BuildingInitial()) {
    on<InitialBuilding>(_initialBuilding);
    on<GetBuilding>(_getBuilding);
    on<AddBuilding>(_addBuilding);
    on<DeleteBuilding>(_deleteBuilding);
    on<UpdateBuilding>(_updateBuilding);
  }

  _initialBuilding(InitialBuilding event, Emitter<BuildingState> emit) {
    emit(BuildingInitial());
  }

  _getBuilding(GetBuilding event, Emitter<BuildingState> emit) async {
    emit(BuildingLoading());
    try {
      final buildings = await repositories.building.getBuilding();
      if (repositories.building.statusCode == "200") {
        emit(BuildingGetSuccess(buildings));
      } else {
        emit(BuildingGetFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  _addBuilding(AddBuilding event, Emitter<BuildingState> emit) async {
    emit(BuildingLoading());
    try {
      await repositories.building.addBuilding(
        event.name,
        event.description,
        event.facility,
        event.capacity,
        event.rule,
        event.image,
      );

      if (repositories.building.statusCode == "200") {
        emit(BuildingAddSuccess());
        add(GetBuilding());
      }
      {
        emit(BuildingAddFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  _updateBuilding(UpdateBuilding event, Emitter<BuildingState> emit) async {
    emit(BuildingLoading());
    try {
      await repositories.building.editBuilding(
        event.id,
        event.name,
        event.description,
        event.facility,
        event.capacity,
        event.rule,
        event.image,
      );

      if (repositories.building.statusCode == "200") {
        emit(BuildingUpdateSuccess());
        add(GetBuilding());
      }
      {
        emit(BuildingUpdateFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  _deleteBuilding(DeleteBuilding event, Emitter<BuildingState> emit) async {
    emit(BuildingLoading());
    try {
      await repositories.building.deleteBuilding(event.id);
      if (repositories.building.statusCode == "200") {
        emit(BuildingDeleteSuccess());
        add(GetBuilding());
      } else {
        emit(BuildingDeleteFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
