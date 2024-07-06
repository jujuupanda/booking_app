import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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

  _getReservation(GetReservation event, Emitter<ReservationState> emit) {
    emit(ReservationLoading());
    try {
      final reservations =
          repositories.reservation.getReservation(event.contactId);
      emit(ReservationSuccess(reservations));
    } catch (e) {
      throw Exception(e);
    }
  }
}
