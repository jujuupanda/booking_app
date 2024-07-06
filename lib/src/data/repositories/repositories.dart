import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/reservation_model.dart';
import '../sample/sample.dart';

part 'login_repo.dart';
part 'reservation_repo.dart';

class Repositories {
  final login = LoginRepo();
  final reservation = ReservationRepo();
}
