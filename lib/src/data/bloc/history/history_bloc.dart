import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/history_model.dart';
import '../../repositories/repositories.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  Repositories repositories;

  HistoryBloc({required this.repositories}) : super(HistoryInitial()) {
    on<InitialHistory>(_initialHistory);
    on<GetHistory>(_getHistory);
    on<CreateHistory>(_createHistory);
  }

  _initialHistory(InitialHistory event, Emitter<HistoryState> emit) {}

  _getHistory(GetHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final user = await _getUsername();
      final histories = await repositories.history.getHistory(user);
      if (repositories.history.statusCode == "200") {
        emit(HistoryGetSuccess(histories));
      } else {
        emit(HistoryGetFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  _createHistory(CreateHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      await repositories.history.createHistory(
        event.buildingName,
        event.dateStart,
        event.dateEnd,
        event.dateCreated,
        event.contactId,
        event.contactName,
        event.information,
        event.status,
      );
      if (repositories.history.statusCode == "200") {
        emit(HistoryCreateSuccess());
        add(GetHistory());
      } else {
        emit(HistoryCreateFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //Get Token or Username
  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }
}
