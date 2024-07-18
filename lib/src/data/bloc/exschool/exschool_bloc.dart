import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/exschool_model.dart';
import '../../repositories/repositories.dart';

part 'exschool_event.dart';

part 'exschool_state.dart';

class ExschoolBloc extends Bloc<ExschoolEvent, ExschoolState> {
  Repositories repositories;

  ExschoolBloc({required this.repositories}) : super(ExschoolInitial()) {
    on<InitialExschool>(_initialExschool);
    on<GetExschool>(_getExschool);
  }

  _initialExschool(InitialExschool event, Emitter<ExschoolState> emit) {}

  _getExschool(GetExschool event, Emitter<ExschoolState> emit) async {
    emit(ExschoolLoading());
    try {
      final exschools = await repositories.exschool.getExschool();
      if (repositories.exschool.statusCode == "200") {
        emit(ExschoolGetSuccess(exschools));
      } else {
        emit(ExschoolGetFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
