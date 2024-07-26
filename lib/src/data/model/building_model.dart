class BuildingModel {
  BuildingModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.rule,
    this.image,
    this.capacity,
    this.facility,
    this.usedUntil,
  });

  BuildingModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    rule = json['rule'];
    image = json['image'];
    capacity = json['capacity'];
    facility = json['facility'];
    usedUntil = json['usedUntil'];
  }

  String? id;
  String? name;
  String? description;
  String? status;
  String? rule;
  String? image;
  int? capacity;
  String? facility;
  String? usedUntil;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['status'] = status;
    map['rule'] = rule;
    map['image'] = image;
    map['capacity'] = capacity;
    map['facility'] = facility;
    map['usedUntil'] = usedUntil;
    return map;
  }
}
