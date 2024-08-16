part of 'repositories.dart';

class BuildingRepo {
  late String statusCode;

  //This for superAdmin but add agency for the detail
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

  getBuildingByAgency(String agency) async {
    statusCode = "";
    try {
      QuerySnapshot resultBuilding = await Repositories()
          .db
          .collection("buildings")
          .where("agency", isEqualTo: agency)
          .get();
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

  addBuilding(
    String? name,
    String? description,
    String? facility,
    int? capacity,
    String? rule,
    String? image,
    String? agency,
  ) async {
    statusCode = "";

    try {
      await Repositories().db.collection("buildings").add({
        "id": "",
        "name": name,
        "description": description,
        "facility": facility,
        "capacity": capacity,
        "rule": rule,
        "image": "some image",
        "agency": agency,
        "status": "Tersedia",
        "usedUntil": "",
      }).then(
        (value) {
          Repositories()
              .db
              .collection("buildings")
              .doc(value.id)
              .update({"id": value.id});
        },
      );
      statusCode = "200";
    } catch (e) {
      throw Exception(e);
    }
  }

  getBuildingAvail(String dateStart, String agency) async {
    statusCode = "";
    try {
      QuerySnapshot resultBuilding = await Repositories()
          .db
          .collection("buildings")
          .where("agency", isEqualTo: agency)
          .get();
      if (resultBuilding.docs.isNotEmpty) {
        statusCode = "200";
        final List<BuildingModel> buildings =
            resultBuilding.docs.map((e) => BuildingModel.fromJson(e)).toList();
        final buildingAvail = buildings
            .where(
              (element) =>
                  element.status == "Tersedia" ||
                  DateTime.parse(element.usedUntil!).isBefore(
                    DateTime.parse(dateStart),
                  ),
            )
            .toList();
        return buildingAvail;
      } else {
        statusCode = "200";
        final List<BuildingModel> buildings = [];
        return buildings;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Get Building Avail
  // getBuildingByAgency(String agency) async {
  //   statusCode = "";
  //   try {
  //     QuerySnapshot resultBuilding =
  //     await Repositories().db.collection("buildings").get();
  //     if (resultBuilding.docs.isNotEmpty) {
  //       statusCode = "200";
  //       final List<BuildingModel> buildings =
  //       resultBuilding.docs.map((e) => BuildingModel.fromJson(e)).toList();
  //       final buildingByAgency = buildings
  //           .where(
  //             (element) =>
  //         element.status == "Tersedia" ||
  //             DateTime.parse(element.usedUntil!).isBefore(
  //               DateTime.parse(dateStart),
  //             ),
  //       )
  //           .toList();
  //       return buildingByAgency;
  //     } else {
  //       statusCode = "200";
  //       final List<BuildingModel> buildings = [];
  //       return buildings;
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  deleteBuilding(String id) async {
    statusCode = "";
    try {
      await Repositories().db.collection("buildings").doc(id).delete();
      statusCode = "200";
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  updateBuilding(
    String id,
    String? name,
    String? description,
    String? facility,
    int? capacity,
    String? rule,
    String? image,
  ) async {
    statusCode = "";

    try {
      await Repositories().db.collection("buildings").doc(id).update({
        "name": name,
        "description": description,
        "facility": facility,
        "capacity": capacity,
        "rule": rule,
        "image": "some image",
        "status": "Tersedia",
        "usedUntil": "",
      });
      statusCode = "200";
    } catch (e) {
      throw Exception(e);
    }
  }
}
