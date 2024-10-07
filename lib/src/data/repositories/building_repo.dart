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

  /// mendapatkan info gedung sesuai instansi
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

  /// menambahkan building
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
        "image": image,
        "agency": agency,
        "status": "Tersedia",
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

  ///Mendapatkan info gedung yang tersedia pada halaman reservasi
  getBuildingAvailable(String agency) async {
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
                  element.status == "Tersedia"
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

  ///Mengubah status building menjadi tidak tersedia
  changeStatusBuilding(String name) async {
    statusCode = "";
    try {
      final resultBuilding = await Repositories()
          .db
          .collection("buildings")
          .where("name", isEqualTo: name)
          .get();
      if (resultBuilding.docs.isNotEmpty) {
        final building = resultBuilding.docs.first;
        await Repositories()
            .db
            .collection("buildings")
            .doc(building.id)
            .update({
          "status": "Tidak Tersedia",
        });
        statusCode = "200";
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Menghapus building
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

  ///Mengupdate atau mengedit building
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
        "image": image,
      });
      statusCode = "200";
    } catch (e) {
      throw Exception(e);
    }
  }
}
