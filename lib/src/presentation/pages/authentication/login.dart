import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/bloc/authentication/authentication_bloc.dart';
import '../../utils/constant/constant.dart';
import '../../utils/routes/route_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// inisiasi data
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late AuthenticationBloc loginBloc;
  late String role;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// fungsi untuk login
  loginButton() {
    loginBloc = context.read<AuthenticationBloc>();
    loginBloc.add(OnLogin(
      usernameController.text.toString(),
      passwordController.text.toString(),
    ));
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is IsAdmin) {
          context.goNamed(Routes().homeAdmin);
        } else if (state is IsUser) {
          context.goNamed(Routes().home);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: RefreshIndicator(
                onRefresh: () async {
                  //Do Nothing
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            imageIconApp,
                            height: 120,
                            width: 120,
                            scale: 1,
                            fit: BoxFit.fill,
                          ),
                          const Gap(10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login",
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Gap(10),
                          TextFormField(
                            controller: usernameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Username",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username tidak boleh kosong!';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(20),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Kata Sandi",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong!';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                              builder: (context, state) {
                                if (state is LoginFailed) {
                                  return Text(
                                    state.error,
                                    style: const TextStyle(
                                        color: Colors.redAccent),
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.all(7),
                                    child: SizedBox(),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginButton();
                                  }
                                },
                                borderRadius: BorderRadius.circular(10),
                                splashColor: Colors.blue,
                                child: const Center(
                                    child: Text(
                                  "Masuk",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
            ),
          ],
        ),
      ),
    );
  }
}
