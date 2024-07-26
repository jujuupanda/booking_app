import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/building_model.dart';
import '../../repositories/repositories.dart';

part 'reservation_building_event.dart';
part 'reservation_building_state.dart';

class ReservationBuildingBloc extends Bloc<ReservationBuildingEvent, ReservationBuildingState> {
  Repositories repositories;
  ReservationBuildingBloc({required this.repositories}) : super(ReservationBuildingInitial()) {
    on<ReservationBuildingEvent>(_initialBuildingAvail);
    on<GetBuildingAvail>(_getBuildingAvail);

  }

  _initialBuildingAvail(ReservationBuildingEvent event, Emitter<ReservationBuildingState> emit){}
  _getBuildingAvail(GetBuildingAvail event, Emitter<ReservationBuildingState> emit) async {
    emit(ResBuLoading());
    try {
      final buildings =
      await repositories.building.getBuildingAvail(event.dateStart);
      if (repositories.building.statusCode == "200") {
        emit(ResBuGetSuccess(buildings));
      } else {
        emit(ResBuGetFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
