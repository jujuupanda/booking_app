import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/bloc/login/login_bloc.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';

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
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

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
                  textAlign: TextAlign.center,
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
                    name: "Profil Saya",
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserGetSuccess) {
                        final user = state.user;
                        _usernameController =
                            TextEditingController(text: user.username);
                        _emailController =
                            TextEditingController(text: user.email);
                        _phoneController =
                            TextEditingController(text: user.phone);
                        _passwordController =
                            TextEditingController(text: user.password);
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _getUser();
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  const Gap(30),
                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(90),
                                      border: Border.all(width: 0.5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: Image.asset(
                                        imageNoConnection,
                                        fit: BoxFit.cover,
                                        scale: 1,
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    user.fullName!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Gap(20),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Username",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Gap(5),
                                        TextFormField(
                                          controller: _usernameController,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(Icons.person),
                                          ),
                                        ),
                                        const Gap(10),
                                        const Text(
                                          "E-Mail",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Gap(5),
                                        TextFormField(
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(Icons.mail),
                                          ),
                                        ),
                                        const Gap(10),
                                        const Text(
                                          "Nomor Telepon",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Gap(5),
                                        TextFormField(
                                          controller: _phoneController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            prefixIcon:
                                                Icon(Icons.phone_android),
                                          ),
                                        ),
                                        const Gap(10),
                                        const Text(
                                          "Password",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Gap(5),
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(Icons.person),
                                          ),
                                        ),
                                        const Gap(30),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            _popWhenExit();
                                          },
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          splashColor: Colors.blue,
                                          child: const Center(
                                              child: Text(
                                            "Keluar",
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(60),
                                ],
                              ),
                            ),
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
