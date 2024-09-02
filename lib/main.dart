import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reservation_app/src/data/bloc/logout/logout_bloc.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'src/data/bloc/authentication/authentication_bloc.dart';
import 'src/data/bloc/building/building_bloc.dart';
import 'src/data/bloc/extracurricular/extracurricular_bloc.dart';
import 'src/data/bloc/history/history_bloc.dart';
import 'src/data/bloc/register/register_bloc.dart';
import 'src/data/bloc/reservation/reservation_bloc.dart';
import 'src/data/bloc/reservation_building/reservation_building_bloc.dart';
import 'src/data/bloc/user/user_bloc.dart';
import 'src/data/repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(repositories: Repositories()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(repositories: Repositories()),
        ),
        BlocProvider(
          create: (context) => ReservationBloc(repositories: Repositories()),
        ),
        BlocProvider(
          create: (context) => BuildingBloc(repositories: Repositories()),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(repositories: Repositories()),
        ),
        BlocProvider(
          create: (context) => UserBloc(repositories: Repositories()),
        ),
        BlocProvider(
          create: (context) =>
              ExtracurricularBloc(repositories: Repositories()),
        ),
        BlocProvider(
          create: (context) =>
              ReservationBuildingBloc(repositories: Repositories()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(repositories: Repositories()),
        ),
      ],
      child: const Apps(),
    );
  }
}
