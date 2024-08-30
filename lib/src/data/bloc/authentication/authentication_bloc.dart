import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/repositories.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  Repositories repositories;

  AuthenticationBloc({required this.repositories}) : super(LoginInitial()) {
    on<InitialLogin>(_initialLogin);
    on<OnLogin>(_loginEvent);
    on<OnLogout>(_logoutEvent);
  }

  _initialLogin(InitialLogin event, Emitter<AuthenticationState> emit) async {
    final token = await _getToken();
    final role = await _getRole();
    if (token != null) {
      if (role == "1") {
        emit(IsAdmin());
      } else if (role == "2") {
        emit(IsUser());
      } else {
        emit(UnAuthenticated());
      }
    } else {
      emit(UnAuthenticated());
    }
  }

  _loginEvent(OnLogin event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoading());
    try {
      await repositories.authentication.login(event.username, event.password);
      if (repositories.authentication.token != "") {
        await _saveUserToken(
          repositories.authentication.token,
          repositories.authentication.role,
          repositories.authentication.user,
          repositories.authentication.agency,
        );
        final role = await _getRole();
        if (role == "1") {
          emit(IsAdmin());
        } else {
          emit(IsUser());
        }
      } else {
        emit(LoginFailed(repositories.authentication.error));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  _logoutEvent(OnLogout event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoading());
    Future.delayed(const Duration(seconds: 1), () async {
      await _removeUserToken();
    });
    emit(LogoutSuccess());
  }

  ///Function for save token after success login
  _saveUserToken(String token, String role, String user, String agency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    await prefs.setString("role", role);
    await prefs.setString("user", user);
    await prefs.setString("agency", agency);
  }

  ///Get Role
  _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  ///Get Token
  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  ///Function for remove token user
  _removeUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
