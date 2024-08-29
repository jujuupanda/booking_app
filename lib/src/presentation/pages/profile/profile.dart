import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/data/bloc/login/login_bloc.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bloc/user/user_bloc.dart';
import '../../utils/routes/route_name.dart';
import '../../widgets/general/header_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late LoginBloc _loginBloc;
  late UserBloc _userBloc;
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late String roleUser;
  late TabController tabController;
  int selectedIndex = 0;

  /// fungsi untuk logout
  _logout() {
    _loginBloc = context.read<LoginBloc>();
    _loginBloc.add(OnLogout());
  }

  /// fungsi untuk mendapatkan info user
  _getUser() {
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUser());
  }

  /// mendapatkan role pengguna
  _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleUser = prefs.getString("role")!;
    setState(() {
      roleUser = roleUser;
    });
  }

  /// pop up ketika user akan logout
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
                    Navigator.of(context).pop();
                    // context.goNamed(Routes().login);
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
                        'Ya',
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
    _getRole();
    _getUser();
    roleUser = "";
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              context.goNamed(Routes().login);
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserGetSuccess) {
              final user = state.user;
              _usernameController = TextEditingController(text: user.username);
              _emailController = TextEditingController(text: user.email);
              _phoneController = TextEditingController(text: user.phone);
              _passwordController = TextEditingController(text: user.password);

            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const HeaderPage(
                name: "Profil Saya",
              ),
              const Gap(10),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (roleUser == "2") {
                      return userContent();
                    } else {
                      return adminUI();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column adminUI() {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          labelStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          tabs: [
            Tab(
              child: Container(
                width: double.maxFinite,
                height: 40,
                decoration: selectedIndex == 0
                    ? BoxDecoration(
                        color: Colors.blueAccent.shade400,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: const Center(
                  child: Text("Admin"),
                ),
              ),
            ),
            Tab(
              child: Container(
                width: double.maxFinite,
                height: 40,
                decoration: selectedIndex == 1
                    ? BoxDecoration(
                        color: Colors.blueAccent.shade400,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: const Center(
                  child: Text("User"),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              /// first tab bar view
              userContent(),

              /// second tab bar view
              adminContent(),
            ],
          ),
        ),
      ],
    );
  }

  Stack userContent() {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            _getUser();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserGetSuccess) {
                  final user = state.user;
                  return Column(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                prefixIcon: Icon(Icons.phone_android),
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
                              borderRadius: BorderRadius.circular(15),
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
                      const Gap(40),
                    ],
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Center(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0x80FFFFFF),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Stack adminContent() {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            _getUser();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserGetSuccess) {
                  final user = state.user;
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      user.fullName!,
                      style: GoogleFonts.openSans(),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
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
    );
  }
}
