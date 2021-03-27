import 'package:flutter/material.dart';
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
  String profileImageUrl;
  String updatedAt;
  String createdAt;

  User({
    @required @required this.first_name,
    @required this.email,
    @required this.profileImageUrl,
    @required this.id,
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
      phone: json['phone'],
      last_login: json['last_login'],
      status: json['status'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

}
