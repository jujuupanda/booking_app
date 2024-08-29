import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:reservation_app/src/data/model/building_model.dart';
import 'package:reservation_app/src/data/model/history_model.dart';

import '../model/extracurricular_model.dart';
import '../model/reservation_model.dart';
import '../model/user_model.dart';

part 'login_repo.dart';

part 'reservation_repo.dart';

part 'building_repo.dart';

part 'history_repo.dart';

part 'user_repo.dart';

part 'extracurricular_repo.dart';

class Repositories {
  final db = FirebaseFirestore.instance;
  final login = LoginRepo();
  final reservation = ReservationRepo();
  final building = BuildingRepo();
  final history = HistoryRepo();
  final user = UserRepo();
  final exschool = ExschoolRepo();
}
