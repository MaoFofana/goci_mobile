

import 'package:gociapp/Data/Model/Produit.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VenteFlashApi  {

  final int secondes;
  final List<Produit> produits;
  

  VenteFlashApi({this.secondes, this.produits});
  factory VenteFlashApi.fromJson(Map<String, dynamic> json) {
   var produitsJson = json["produits"] as List;
    return VenteFlashApi(
      secondes: json['secondes'],
      produits: produitsJson.map<Produit>((json) => Produit.fromJson(json)).toList(),
    );

  }

}