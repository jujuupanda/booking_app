import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../data/bloc/login/login_bloc.dart';
import '../../utils/routes/route_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late LoginBloc loginBloc;

  loginButton() {
    loginBloc = context.read<LoginBloc>();
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.goNamed(Routes().home);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                height: 120,
                decoration: const BoxDecoration(color: Colors.lightBlue),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(30),
                    const Text(
                      "LOGIN",
                      style: TextStyle(fontSize: 30),
                    ),
                    const Gap(20),
                    const Text(
                      "Username",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Username"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Gap(10),
                    const Text(
                      "PASSWORD",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Gap(20),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginFailed) {
                          return Center(
                            child: Text(
                              state.error!,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.redAccent),
                            ),
                          );
                        } else if (state is LoginLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    Center(
                      child: Container(
                        width: 150,
                        height: 40,
                        color: Colors.lightBlue,
                        child: Material(
                          color: Colors.transparent,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                loginButton();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "MASUK",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
