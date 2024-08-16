class UserModel {
  UserModel({
    this.id,
    this.username,
    this.password,
    this.role,
    this.email,
    this.fullName,
    this.phone,
    this.agency,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
    agency = json['agency'];
  }

  String? id;
  String? username;
  String? password;
  String? role;
  String? email;
  String? fullName;
  String? phone;
  String? agency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['password'] = password;
    map['role'] = role;
    map['email'] = email;
    map['fullName'] = fullName;
    map['phone'] = phone;
    map['agency'] = agency;
    return map;
  }
}
