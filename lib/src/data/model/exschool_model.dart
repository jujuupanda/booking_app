class ExschoolModel {
  ExschoolModel({
    this.id,
    this.image,
    this.name,
    this.schedule,
    this.agency,
  });

  ExschoolModel.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    schedule = json['schedule'];
    agency = json['agency'];
  }

  String? id;
  String? image;
  String? name;
  String? schedule;
  String? agency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    map['schedule'] = schedule;
    map['agency'] = agency;
    return map;
  }
}
