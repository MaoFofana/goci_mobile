import 'package:json_annotation/json_annotation.dart';


class Adresse {
  final  String street_1;
  final  String street_2;
  final  String city;
  final  String state;
   final String postcode;
final    String country;


  Adresse({this.street_1, this.street_2, this.city, this.state, this.postcode,
      this.country});

  factory Adresse.fromJson(Map<String, dynamic> json)  {
    return Adresse(
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['zip'],
      street_1: json['street_1'],
      street_2: json['street_2'],

    );
  }
}