

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Produit  {

  int id;
  String nom;
  String prix;
  String image;
  String description;
  String sale_price;
  String regular_price;
  String stock;
  String poids;

  Produit({this.id, this.nom , this.prix, this.image , this.description , this.sale_price, this.regular_price , this.stock,this.poids});
  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'],
      nom: json["nom"],
      prix: json['prix'],
      image: json['image'],
      description: json['description'],
      sale_price: json['sale_price'],
      regular_price: json['regular_price'],
      stock : json['stock'],
      poids: json['poids']
    );

  }

  Map toJson()=> {
    'id' : id,
    'nom' : nom,
    'prix': prix,
    'image': image,
    'description': description,
    'sale_price': sale_price,
    'regular_price': regular_price,
    'stock': stock,
    'poids': poids
  };


}
