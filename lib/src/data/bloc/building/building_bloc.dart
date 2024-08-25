import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/building_model.dart';
import '../../repositories/repositories.dart';

part 'building_event.dart';

part 'building_state.dart';

class BuildingBloc extends Bloc<BuildingEvent, BuildingState> {
  Repositories repositories;

  BuildingBloc({required this.repositories}) : super(BuildingInitial()) {
    on<InitialBuilding>(_initialBuilding);
    on<GetBuilding>(_getBuilding);
    on<GetBuildingByAgency>(_getBuildingByAgency);
    on<AddBuilding>(_addBuilding);
    on<DeleteBuilding>(_deleteBuilding);
    on<UpdateBuilding>(_updateBuilding);
    on<ChangeStatusBuilding>(_changeStatusBuilding);
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

  ///Get building berdasarkan instansi (sekolah)
  _getBuildingByAgency(
      GetBuildingByAgency event, Emitter<BuildingState> emit) async {
    emit(BuildingLoading());
    try {
      final agency = await _getAgency();
      final buildings = await repositories.building.getBuildingByAgency(agency);

      if (repositories.building.statusCode == "200") {
        emit(BuildingGetSuccess(buildings));
      } else {
        emit(BuildingGetFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // _getReservationCheck(
  //     GetReservationCheck event, Emitter<BuildingState> emit) async {
  //   emit(BuildingLoading());
  //   try {
  //     final agency = await _getAgency();
  //     final avail = await repositories.reservation
  //         .getReservationAvail(event.dateStart, event.dateEnd, agency);
  //     print(avail);
  //     if (repositories.building.statusCode == "200") {
  //       print("success");
  //     } else {
  //       print("failed");
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  ///Add building
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
        event.agency,
      );

      if (repositories.building.statusCode == "200") {
        emit(BuildingAddSuccess());
        add(GetBuildingByAgency());
      }
      {
        emit(BuildingAddFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Update/edit building
  _updateBuilding(UpdateBuilding event, Emitter<BuildingState> emit) async {
    emit(BuildingLoading());
    try {
      await repositories.building.updateBuilding(
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

  ///Mengubah status dan used until building
  _changeStatusBuilding(
      ChangeStatusBuilding event, Emitter<BuildingState> emit) async {
    emit(BuildingLoading());
    try {
      await repositories.building.changeStatusBuilding(
        event.name,
        event.dateEnd,
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

  ///Get Agency
  _getAgency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("agency");
  }
}
