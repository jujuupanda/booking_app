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
    on<InitialRegisterEvent>(initialRegister);
    on<Register>(register);
    on<GetAllUser>(getAllUser);
    on<DeleteUser>(deleteUser);
    on<EditUserAdmin>(editUserAdmin);
    on<ChangeUsername>(changeUsername);

  }

  initialRegister(InitialRegisterEvent event, Emitter<RegisterState> emit) {
    emit(RegisterInitialState());
  }

  /// tambah user
  register(Register event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
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
  getAllUser(GetAllUser event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
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
  deleteUser(DeleteUser event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
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

  /// edit user pada fitur admin
  editUserAdmin(EditUserAdmin event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      await repositories.user.editUser(
        event.id,
        event.agency,
        event.username,
        event.password,
        event.fullName,
        event.email,
        event.phone,
      );
      if (repositories.user.statusCode == "200") {
        emit(EditSuccess());
        add(GetAllUser());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// edit username pada fitur admin
  changeUsername(ChangeUsername event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      await repositories.user.changeUsername(
        event.id,
        event.username,
      );
      if (repositories.user.error == "") {
        emit(ChangeUsernameSuccess());
        add(GetAllUser());
      } else {
        emit(ChangeUsernameFailed(repositories.user.error));
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
