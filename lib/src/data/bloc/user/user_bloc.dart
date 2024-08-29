import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reservation_app/src/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/repositories.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  Repositories repositories;

  UserBloc({required this.repositories}) : super(UserInitial()) {
    on<InitialUser>(_initialUser);
    on<GetUser>(_getUser);
    on<GetAllUser>(_getAllUser);
  }

  _initialUser(InitialUser event, Emitter<UserState> emit) {
    emit(UserInitial());
  }

  _getUser(GetUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final username = await _getUsername();
      final user = await repositories.user.getUser(username);
      if (repositories.user.statusCode == "200") {
        emit(UserGetSuccess(user));
      } else {
        emit(UserGetFailed());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  _getAllUser(GetAllUser event, Emitter<UserState> emit) {
    emit(UserGetAllSuccess());
  }

  /// Get Token or Username
  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }
}
