part of 'repositories.dart';

class ReservationRepo {
  late String error;
  late String statusCode;

  createReservation(
    String? buildingName,
    String? contactId,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
    String? dateStart,
    String? dateEnd,
    String? dateCreated,
    String? information,
    String? agency,
  ) async {
    statusCode = "";

    try {
      QuerySnapshot listReservations = await Repositories()
          .db
          .collection("reservations")
          .where("agency", isEqualTo: agency)
          .where("buildingName", isEqualTo: buildingName)
          .get();

      if (listReservations.docs.isNotEmpty) {
        List<ReservationModel> reservations = listReservations.docs
            .map((e) => ReservationModel.fromJson(e))
            .toList();
        if (reservations.any(
          (element) => element.status == "Menunggu",
        )) {
          statusCode = "200";
          print("Bisa reservasi");
        } else if (reservations.any(
          (element) => element.status == "Disetujui",
        )) {
          final a = reservations
              .where(
                (element) => element.status == "Disetujui",
              )
              .toList();
          print("disetujui");
          print(a);
        }
      } else {
        statusCode = "200";
      }

      await Repositories().db.collection("reservations").add({
        "id": "",
        "buildingName": buildingName,
        "contactId": contactId,
        "contactName": contactName,
        "contactEmail": contactEmail,
        "contactPhone": contactPhone,
        "dateStart": dateStart,
        "dateEnd": dateEnd,
        "dateCreated": dateCreated,
        "information": information,
        "agency": agency,
        "status": "Menunggu",
        "image": "somepath",
      }).then(
        (value) {
          Repositories()
              .db
              .collection("reservations")
              .doc(value.id)
              .update({"id": value.id});
        },
      );
      statusCode = "200";
    } catch (e) {
      throw Exception(e);
    }
  }

  getReservationForUser(String contactId) async {
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
        final onReservation = reservations
            .where(
              (element) =>
                  element.status == "Menunggu" || element.status == "Disetujui",
            )
            .toList();
        return onReservation;
      } else {
        statusCode = "200";
        final List<ReservationModel> reservations = [];
        return reservations;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  cancelReservation(String contactId) async {
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
    statusCode = "";
    try {
      await Repositories().db.collection("reservations").doc(id).delete();
      statusCode = "200";
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  acceptReservation(String id) async {
    statusCode = "";
    try {
      await Repositories()
          .db
          .collection("reservations")
          .doc(id)
          .update({"status": "Disetujui"});
      statusCode = "200";
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  getReservationForAdmin(String agency) async {
    error = "";
    statusCode = "";

    try {
      QuerySnapshot resultReservations = await Repositories()
          .db
          .collection("reservations")
          .where("agency", isEqualTo: agency)
          .get();

      if (resultReservations.docs.isNotEmpty) {
        statusCode = "200";
        final List<ReservationModel> reservations = resultReservations.docs
            .map((e) => ReservationModel.fromJson(e))
            .toList();
        final onReservation = reservations
            .where(
              (element) =>
                  element.status == "Menunggu" || element.status == "Disetujui",
            )
            .toList();
        return onReservation;
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
