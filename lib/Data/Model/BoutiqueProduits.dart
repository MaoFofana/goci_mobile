
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BoutiqueProduits {
  final int id;
  final String nom;
  final String prix;
  final String image;
  final String description;
  final String salePrice;
  final String stock;
  final bool onSale;
  final String regularPrice;
  final String shortDescription;
  final String poids;

  BoutiqueProduits({this.poids,this.id, this.nom , this.prix, this.image , this.description , this.salePrice , this.stock, this.onSale, this.regularPrice, this.shortDescription});
  factory BoutiqueProduits.fromJson(Map<String, dynamic> json) {
    return BoutiqueProduits(
      id: json['id'],
      nom: json["name"],
      prix: json['price'],
      image: json['images'][0]["src"],
      description: json['description'],
      salePrice: json['sale_price'],
      regularPrice: json["regular_price"],
      stock : json['stock'],
      onSale: json['on_sale'],
      shortDescription: json['short_description'],
      poids: json["weight"]
    );

  }}