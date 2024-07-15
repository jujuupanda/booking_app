class UserModel {
  UserModel({
      this.id, 
      this.username, 
      this.password, 
      this.role, 
      this.email,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    email = json['email'];
  }
  String? id;
  String? username;
  String? password;
  String? role;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['password'] = password;
    map['role'] = role;
    map['email'] = email;
    return map;
  }

}