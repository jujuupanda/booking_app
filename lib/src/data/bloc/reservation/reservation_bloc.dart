import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/reservation_model.dart';
import '../../repositories/repositories.dart';

part 'reservation_event.dart';

part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  Repositories repositories;

  ReservationBloc({required this.repositories}) : super(ReservationInitial()) {
    on<InitialReservation>(_reservationInitial);
    on<GetReservation>(_getReservation);
  }

  _reservationInitial(
      InitialReservation event, Emitter<ReservationState> emit) {
    emit(ReservationInitial());
  }

  _getReservation(GetReservation event, Emitter<ReservationState> emit) async {
    emit(ReservationLoading());
    try {
      final user = await _getUsername();
      final reservations = await repositories.reservation.getReservation(user);
      if (repositories.reservation.statusCode == "200") {
        emit(ReservationGetSuccess(reservations));
      } else {
        emit(ReservationGetFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  //Get Username
  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }
}
