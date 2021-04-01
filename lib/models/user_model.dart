import 'package:flutter/material.dart';
import 'package:inveat/models/image_user_model.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  int id;
  String email;
  String first_name;
  String last_name;
  String phone;
  String last_login;
  String status;
  ImageUser image_user;
  String updatedAt;
  String createdAt;
  String token;

  User({
    @required @required this.first_name,
    @required this.email,
    @required this.image_user,
    @required this.id,
    @required this.token,
    @required this.last_name,
    @required this.phone,
    @required this.last_login,
    @required this.status,
    @required this.updatedAt,
    @required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      image_user: ImageUser.fromJson(json['image_user']),
      phone: json['phone'],
      last_login: json['last_login'],
      status: json['status'],
      token: json['token'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['image_user'] = this.image_user;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['phone'] = this.phone;
    data['last_login'] = this.last_login;
    data['status'] = this.status;
    data['token'] = this.token;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;

    return data;
  }
}
