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

  ///Get and check reservation available in reservation page
  getReservationAvail(String dateStart, String dateEnd, String agency) async {
    statusCode = "";
    try {
      QuerySnapshot resultReservation = await Repositories()
          .db
          .collection("reservations")
          .where("agency", isEqualTo: agency)
          .get();
      if (resultReservation.docs.isNotEmpty) {
        statusCode = "200";
        final List<ReservationModel> reservations = resultReservation.docs
            .map((e) => ReservationModel.fromJson(e))
            .toList();

        final buildingBooked = reservations
            .where(
              (element) =>
                  (DateTime.parse(element.dateEnd!)
                          .isAfter(DateTime.parse(dateStart)) ||
                      DateTime.parse(element.dateStart!)
                          .isBefore(DateTime.parse(dateEnd))) &&
                  element.status == "Disetujui",
            )
            .toList();
        if (buildingBooked.isNotEmpty) {
          if (buildingBooked.any(
            (element) =>
                DateTime.parse(element.dateEnd!)
                    .isBefore(DateTime.parse(dateStart)) ||
                DateTime.parse(element.dateStart!)
                    .isAfter(DateTime.parse(dateEnd)),
          )) {
            final List<ReservationModel> noBooking = [];
            return noBooking;
          } else {
            return buildingBooked;
          }
        } else {
          final List<ReservationModel> noBooking = [];
          return noBooking;
        }
      } else {
        statusCode = "200";

        ///Do something here (can booking)
        final List<ReservationModel> noBooking = [];
        return noBooking;
      }
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
