part of 'repositories.dart';

class HistoryRepo {
  late String error;
  late String statusCode;

  /// mendapatkan informasi riwayat berdasarkan user
  getHistory(String contactId) async {
    error = "";
    statusCode = "";

    try {
      QuerySnapshot resultHistories = await Repositories()
          .db
          .collection("histories")
          .where("contactId", isEqualTo: contactId)
          .get();

      if (resultHistories.docs.isNotEmpty) {
        statusCode = "200";
        final List<HistoryModel> histories =
            resultHistories.docs.map((e) => HistoryModel.fromJson(e)).toList();
        return histories;
      } else {
        statusCode = "200";
        final List<HistoryModel> histories = [];
        return histories;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// mendapatkan informasi riwayat/laporan berdasarkan instansi (admin)
  getHistoryByAgency(String agency) async {
    statusCode = "";
    try {
      QuerySnapshot resultHistory = await Repositories()
          .db
          .collection("histories")
          .where("agency", isEqualTo: agency)
          .get();
      if (resultHistory.docs.isNotEmpty) {
        statusCode = "200";
        final List<HistoryModel> histories =
        resultHistory.docs.map((e) => HistoryModel.fromJson(e)).toList();
        return histories;
      } else {
        statusCode = "200";
        final List<HistoryModel> histories = [];
        return histories;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// membuat riwayat reservasi
  createHistory(
    String buildingName,
    String dateStart,
    String dateEnd,
    String dateCreated,
    String contactId,
    String contactName,
    String information,
    String status,
    String agency,
  ) async {
    error = "";
    statusCode = "";

    try {
      await Repositories().db.collection("histories").add({
        "id": "",
        "buildingName": buildingName,
        "dateStart": dateStart,
        "dateEnd": dateEnd,
        "dateCreated": dateCreated,
        "contactId": contactId,
        "contactName": contactName,
        "information": information,
        "status": status,
        "image": "image",
        "agency": agency,
      }).then(
        (value) {
          Repositories()
              .db
              .collection("histories")
              .doc(value.id)
              .update({"id": value.id});
        },
      );
      statusCode = "200";
    } catch (e) {
      throw Exception(e);
    }
  }
}
