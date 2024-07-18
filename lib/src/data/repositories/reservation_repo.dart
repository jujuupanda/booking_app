part of 'repositories.dart';

class ReservationRepo {
  late String error;
  late String statusCode;

  createReservation() {}

  getReservation(String contactId) async {
    error = "";
    statusCode = "";

    try {
      QuerySnapshot resultReservations = await Repositories()
          .db
          .collection("reservations")
          .where("contactId", isEqualTo: contactId)
          .get();

      if (resultReservations.docs.isNotEmpty) {
        statusCode = "200";
        final List<ReservationModel> reservations = resultReservations.docs
            .map((e) => ReservationModel.fromJson(e))
            .toList();
        return reservations;
      } else {
        statusCode = "200";
        final List<ReservationModel> reservations = [];
        return reservations;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteReservation(String id) async {
    error = "";
    statusCode = "";
    try {
      QuerySnapshot resultReservations = await Repositories()
          .db
          .collection("reservations")
          .where("id", isEqualTo: id)
          .get();

      if (resultReservations.docs.isNotEmpty) {
        statusCode = "200";
        final List<ReservationModel> reservations = resultReservations.docs
            .map((e) => ReservationModel.fromJson(e))
            .toList();
        return reservations;
      } else {
        statusCode = "200";
        final List<ReservationModel> reservations = [];
        return reservations;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
