import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/history_model.dart';
import '../../repositories/repositories.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  Repositories repositories;

  HistoryBloc({required this.repositories}) : super(HistoryInitial()) {
    on<InitialHistory>(_initialHistory);
    on<GetHistoryUser>(_getHistory);
    on<GetAllHistoryAdmin>(_getAllHistoryAdmin);
    on<CreateHistory>(_createHistory);
  }

  _initialHistory(InitialHistory event, Emitter<HistoryState> emit) {}

  _getHistory(GetHistoryUser event, Emitter<HistoryState> emit) async {
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
      final agency = await _getAgency();
      await repositories.history.createHistory(
        event.buildingName,
        event.dateStart,
        event.dateEnd,
        event.dateCreated,
        DateTime.now().toString(),
        event.contactId,
        event.contactName,
        event.information,
        event.status,
        agency,
        event.image,
      );
      if (repositories.history.statusCode == "200") {
        emit(HistoryCreateSuccess());
        add(GetHistoryUser());
      } else {
        emit(HistoryCreateFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  _getAllHistoryAdmin(
      GetAllHistoryAdmin event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final agency = await _getAgency();
      final histories = await repositories.history.getHistoryByAgency(agency);
      if (repositories.history.statusCode == "200") {
        emit(HistoryGetSuccess(histories));
      } else {
        emit(HistoryGetFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Get Token or Username
  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  ///Get Agency
  _getAgency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("agency");
  }
}
