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
}
