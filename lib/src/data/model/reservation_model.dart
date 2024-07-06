class ReservationModel {
  ReservationModel({
      this.id, 
      this.buildingName, 
      this.dateStart, 
      this.dateEnd, 
      this.contactName, 
      this.contactEmail, 
      this.contactPhone, 
      this.numberOfGuest, 
      this.confirmed,});

  ReservationModel.fromJson(dynamic json) {
    id = json['id'];
    buildingName = json['buildingName'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    contactName = json['contactName'];
    contactEmail = json['contactEmail'];
    contactPhone = json['contactPhone'];
    numberOfGuest = json['numberOfGuest'];
    confirmed = json['confirmed'];
  }
  String? id;
  String? buildingName;
  String? dateStart;
  String? dateEnd;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  int? numberOfGuest;
  bool? confirmed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['buildingName'] = buildingName;
    map['dateStart'] = dateStart;
    map['dateEnd'] = dateEnd;
    map['contactName'] = contactName;
    map['contactEmail'] = contactEmail;
    map['contactPhone'] = contactPhone;
    map['numberOfGuest'] = numberOfGuest;
    map['confirmed'] = confirmed;
    return map;
  }

}