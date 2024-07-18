part of 'repositories.dart';

class ExschoolRepo {
  late String statusCode;

  getExschool() async {
    statusCode = "";
    try {
      QuerySnapshot resultBuilding =
          await Repositories().db.collection("exschools").get();
      if (resultBuilding.docs.isNotEmpty) {
        statusCode = "200";
        final List<ExschoolModel> exschools =
            resultBuilding.docs.map((e) => ExschoolModel.fromJson(e)).toList();
        return exschools;
      } else {
        statusCode = "200";
        final List<ExschoolModel> exschools = [];
        return exschools;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  addExschool(){}
}
