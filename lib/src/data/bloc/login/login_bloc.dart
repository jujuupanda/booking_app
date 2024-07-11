import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/repositories.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Repositories repositories;

  LoginBloc({required this.repositories}) : super(LoginInitial()) {
    on<InitialLogin>(_initialLogin);
    on<OnLogin>(_loginEvent);
    on<OnLogout>(_logoutEvent);
  }

  _initialLogin(InitialLogin event, Emitter<LoginState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString("token");
    if (userToken != null) {
      emit(IsAuthenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  _loginEvent(OnLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await repositories.login.login(event.username, event.password);
      if (repositories.login.token != "") {
        await _saveUserToken(
          repositories.login.token,
          repositories.login.role,
          repositories.login.user,
        );
        emit(LoginSuccess());
      } else {
        emit(LoginFailed(repositories.login.error));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  _logoutEvent(OnLogout event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await _removeUserToken();
    emit(LogoutSuccess());
  }

  ///Function for save token after success login
  _saveUserToken(String token, String role, String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    await prefs.setString("role", role);
    await prefs.setString("user", user);
  }

  ///Function for remove token user
  _removeUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
