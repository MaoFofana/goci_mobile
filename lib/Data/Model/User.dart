

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  final String nom;
  final String password;
  final String email;
  final String id;
  final String address;
  final String city;
  final String phone;


  User({this.nom,  this.password, this.email, this.id, this.address,
      this.city, this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        nom: json['nom'],
        password: json['password'],
        email : json['email'],
        id: json['id'],
        address: json['address'],
        city: json['city'],
        phone: json['phone']
    );
  }
}
