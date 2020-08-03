import 'package:gociapp/Data/Model/Adresse.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Boutique {
     final int  id;
     final String storeName;
     final String firstName;
    final  String lastName;
     final String email;
     final String phone;
     final Adresse address;


    Boutique({this.id, this.storeName, this.firstName, this.lastName,
        this.email, this.phone,  this.address});

    factory Boutique.fromJson(Map<String, dynamic> json) {
      return Boutique(
          id : json['id'],
          storeName : json['store_name'],
          firstName: json['first_name'],
          lastName: json['last_name'],
          email: json['email'],
          phone: json['phone'],
          address: Adresse.fromJson(json['address'])
      );
  }
}