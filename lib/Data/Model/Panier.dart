import 'package:gociapp/Data/Model/Produit.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Panier {
   Produit produit;
  int quantite ;

  Panier({this.quantite, this.produit});

   factory Panier.fromJson(Map<String, dynamic> json) {
     return Panier(
       produit :  Produit.fromJson(json["produit"]),
       quantite: json["quantite"],
     );
   }
  Map toJson(){
    Map produit = this.produit != null ? this.produit.toJson() : null;
    return {
      "produit" : produit,
      'quantite': quantite
    };
  }
}

