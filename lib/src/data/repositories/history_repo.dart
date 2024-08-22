part of 'repositories.dart';

class HistoryRepo {
  late String error;
  late String statusCode;

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

  createHistory(
    String buildingName,
    String dateStart,
    String dateEnd,
    String dateCreated,
    String contactId,
    String contactName,
    String information,
    String status,
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
