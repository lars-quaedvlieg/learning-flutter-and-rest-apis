import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;
  String? creationAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.role,
      this.avatar,
      this.creationAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['role'] = role;
    data['avatar'] = avatar;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  static List<UserModel> usersFromJSON(List userJSON) {
    return userJSON.map((data) => UserModel.fromJson(data)).toList();
  }
}
