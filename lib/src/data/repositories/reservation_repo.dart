part of 'repositories.dart';

class ReservationRepo {
  late String error;

  createReservation() {}

  getReservation(String contactId) {
    error = "";
    final url = Uri.parse("this is url");

    try {
      //generate reservation to model
      // final List<dynamic> results = jsonDecode(listReservation);
      final List<ReservationModel> listResults =
          listReservation.map((e) => ReservationModel.fromJson(e)).toList();
      return listResults;
    } catch (e) {
      throw Exception(e);
    }
  }
}
