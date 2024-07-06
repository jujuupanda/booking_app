import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/repositories.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Repositories repositories;

  LoginBloc({required this.repositories}) : super(LoginInitial()) {
    on<InitialLogin>(_initialLogin);
    on<OnLogin>(_loginEvent);
  }

  _initialLogin(InitialLogin event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }

  _loginEvent(OnLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await repositories.login.login(event.username, event.password);
      if (repositories.login.token != "") {
        emit(LoginSuccess());
      } else {
        emit(LoginFailed(repositories.login.error));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
