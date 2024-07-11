class HistoryModel {
  HistoryModel({
    this.id,
    this.buildingName,
    this.dateStart,
    this.dateEnd,
    this.dateCreated,
    this.contactId,
    this.contactName,
    this.numberOfGuest,
    this.image,
  });

  HistoryModel.fromJson(dynamic json) {
    id = json['id'];
    buildingName = json['buildingName'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    dateCreated = json['dateCreated'];
    contactId = json['contactId'];
    contactName = json['contactName'];
    numberOfGuest = json['numberOfGuest'];
    image = json['image'];
  }

  String? id;
  String? buildingName;
  String? dateStart;
  String? dateEnd;
  String? dateCreated;
  String? contactId;
  String? contactName;
  int? numberOfGuest;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['buildingName'] = buildingName;
    map['dateStart'] = dateStart;
    map['dateEnd'] = dateEnd;
    map['dateCreated'] = dateCreated;
    map['contactId'] = contactId;
    map['contactName'] = contactName;
    map['numberOfGuest'] = numberOfGuest;
    map['image'] = image;
    return map;
  }
}
