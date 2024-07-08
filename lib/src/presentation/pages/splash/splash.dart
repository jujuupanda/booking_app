import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/bloc/login/login_bloc.dart';

import '../../utils/constant/constant.dart';
import '../../utils/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  late LoginBloc _loginBloc;

  _splashScreen() {
    _timer = Timer(
      const Duration(seconds: 2, milliseconds: 5),
      () {
        _checkIsLogin();
      },
    );
  }

  _checkIsLogin() {
    _loginBloc = context.read<LoginBloc>();
    _loginBloc.add(InitialLogin());
  }

  @override
  void initState() {
    _splashScreen();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is IsAuthenticated) {
          context.goNamed(Routes().home);
        } else if (state is UnAuthenticated) {
          context.goNamed(Routes().login);
        } else {
          context.goNamed(Routes().home);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(imageSplash),
        ),
      ),
    );
  }
}
