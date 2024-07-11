part of 'repositories.dart';

class BuildingRepo {
  late String statusCode;

  getBuilding() async {
    statusCode = "";
    try {
      QuerySnapshot resultBuilding =
          await Repositories().db.collection("buildings").get();
      if (resultBuilding.docs.isNotEmpty) {
        statusCode = "200";
        final List<BuildingModel> buildings =
            resultBuilding.docs.map((e) => BuildingModel.fromJson(e)).toList();
        return buildings;
      } else {
        statusCode = "200";
        final List<BuildingModel> buildings = [];
        return buildings;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
