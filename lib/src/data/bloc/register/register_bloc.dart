import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';
import '../../repositories/repositories.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  Repositories repositories;

  RegisterBloc({required this.repositories}) : super(RegisterInitialState()) {
    on<InitialRegisterEvent>(_initialRegister);
    on<Register>(_register);
    on<GetAllUser>(_getAllUser);
    on<DeleteUser>(_deleteUser);
    on<EditUser>(_editUser);
  }

  _initialRegister(InitialRegisterEvent event, Emitter<RegisterState> emit) {
    emit(RegisterInitialState());
  }

  /// tambah user
  _register(Register event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    try {
      await repositories.user.register(
        event.agency,
        event.username,
        event.password,
        event.fullName,
        event.role,
      );

      if (repositories.user.error == "") {
        emit(RegisterSuccess());
        add(GetAllUser());
      } else {
        emit(RegisterFailed(repositories.user.error));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// mendapatkan info semua user
  _getAllUser(GetAllUser event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    try {
      final agency = await _getAgency();
      final users = await repositories.user.getAllUserByAgency(agency);
      if (repositories.user.statusCode == "200") {
        emit(GetAllUserSuccess(users));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// delete user
  _deleteUser(DeleteUser event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    try {
      await repositories.user.deleteUser(event.id);
      if (repositories.user.statusCode == "200") {
        emit(DeleteSuccess());
        add(GetAllUser());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// edit user
  _editUser(EditUser event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    try {
      await repositories.user.deleteUser("");
      if (repositories.user.statusCode == "200") {
        emit(DeleteSuccess());
        add(GetAllUser());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Get Agency
  _getAgency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("agency");
  }
}
