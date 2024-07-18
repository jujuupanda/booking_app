import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'src/data/bloc/building/building_bloc.dart';
import 'src/data/bloc/exschool/exschool_bloc.dart';
import 'src/data/bloc/history/history_bloc.dart';
import 'src/data/bloc/login/login_bloc.dart';
import 'src/data/bloc/reservation/reservation_bloc.dart';
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
          create: (context) => LoginBloc(repositories: Repositories()),
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
          create: (context) => ExschoolBloc(repositories: Repositories()),
        ),
      ],
      child: const Apps(),
    );
  }
}
