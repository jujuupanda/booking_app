class ReservationModel {
  ReservationModel({
    this.id,
    this.buildingName,
    this.dateStart,
    this.dateEnd,
    this.dateCreated,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.information,
    this.status,
    this.image,
  });

  ReservationModel.fromJson(dynamic json) {
    id = json['id'];
    buildingName = json['buildingName'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    dateCreated = json['dateCreated'];
    contactName = json['contactName'];
    contactEmail = json['contactEmail'];
    contactPhone = json['contactPhone'];
    information = json['information'];
    status = json['status'];
    image = json['image'];
  }

  String? id;
  String? buildingName;
  String? dateStart;
  String? dateEnd;
  String? dateCreated;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? information;
  String? status;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['buildingName'] = buildingName;
    map['dateStart'] = dateStart;
    map['dateEnd'] = dateEnd;
    map['dateCreated'] = dateCreated;
    map['contactName'] = contactName;
    map['contactEmail'] = contactEmail;
    map['contactPhone'] = contactPhone;
    map['information'] = information;
    map['status'] = status;
    map['image'] = image;
    return map;
  }
}
