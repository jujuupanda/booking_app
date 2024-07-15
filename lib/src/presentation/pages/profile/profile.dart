import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/bloc/login/login_bloc.dart';

import '../../../data/bloc/user/user_bloc.dart';
import '../../utils/routes/route_name.dart';
import '../../widgets/general/header_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late LoginBloc _loginBloc;
  late UserBloc _userBloc;

  _logout() {
    _loginBloc = context.read<LoginBloc>();
    _loginBloc.add(OnLogout());
  }

  _getUser() {
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUser());
  }

  _popWhenExit() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    Icons.logout,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
                Gap(10),
                Text(
                  'Apakah kamu yakin ingin keluar?',
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Tidak',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _logout();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent),
                    child: const Center(
                      child: Text(
                        'Keluar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.goNamed(Routes().login);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  const HeaderPage(
                    name: "Saya",
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserGetSuccess) {
                        final user = state.user;
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Username: ${user.username}",
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(
                                "Email: ${user.email}",
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(
                                "role: ${user.role}",
                                style: const TextStyle(fontSize: 30),
                              ),
                              const Gap(30),
                              ElevatedButton(
                                  onPressed: () {
                                    _popWhenExit();
                                  },
                                  child: const Text("Keluar")),
                            ],
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Container(
                    decoration: const BoxDecoration(color: Color(0x80FFFFFF)),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
